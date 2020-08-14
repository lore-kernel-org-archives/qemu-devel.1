Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C61C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83F720855
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Hc/wzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83F720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6b3n-0003Uf-7J
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 10:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6b2a-0002Ii-St
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 10:50:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6b2Z-00032m-5C
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 10:50:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id c4so7702082otf.12
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+MYu4dGjPdKCIl6Vj+uJZUqckMyamuj+vvUa9/hozCY=;
 b=Z+Hc/wzZw9yOYjsyo1T3U5S36RiQfjq2+r1FbVzMK1cYsfdhBXj5FL7PSZqbbVmGuR
 hnQu1qyLFkFCZB0mMDHrts2zBBiI4yQkj31zKBQZ4wii3dVDWZxstf1YKcCh7bUAPuMv
 4RH6ukZ0l0Oy187jreGUbb5w1hSXe2z2B8Iyq5wVw/1pPA0ndCx8eFvoQ8uBFK6G+I5m
 JuQT+pQbMUKw5KCGqPhxF+P1+8t/0KGL86vR2bX6RxIvS5l25/7kiFwYOwy7OinJclFM
 g6rr+ORNxvWXH2V1OvARS03E29K1OzA6WtKHH4GkeqTS7WYSxz/rIjMgwr2rbRaV8Dxw
 lvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+MYu4dGjPdKCIl6Vj+uJZUqckMyamuj+vvUa9/hozCY=;
 b=ElYtldquzsrad8mxl9D6cK++js13c93YSkzxemxvJxi5ZWepBgRHQlnY7u2mTVMsLa
 HV6tDHv0dBdpN3ptCPJdfHs0wGy1Ib2dKLnaW8Rn5Myr5oxZapW9kEZ3uXvKtMEOj7pV
 4smjJFzkRCKrm2e7ewTi71g87GqxhRzHkI4KmP/ZWXtMX3q/TATO9rTEfOCdGId15pmq
 3ygEjNryehr/FunBSKabB1YIKfXRpCL4btxiVF5cqau5t6DsPl05KRYqawcqL04Kau/e
 WX2UcJuz/ND+J4tpnMejAur9NJf4YJMcqyt6zYNjISl5Gvp4z/bZd5AekwkIcTslvcW7
 jXpA==
X-Gm-Message-State: AOAM533sRaas7GXNRW6RA3MsU1BogMFiUXcAjDZabHCJMQLjhQKGt0YV
 weNqL0rlWeI1lH3mWUt3aGIMx7u/AnAoekYGx1U=
X-Google-Smtp-Source: ABdhPJyf8vWta2eWhMaFmGLj2bKXeNQnPaErTKjwf34Y9Zd5uYiK/w9ETtgNKAoGpI2CJXYmRCOqipQriZMFlEwl8oM=
X-Received: by 2002:a05:6830:796:: with SMTP id
 w22mr1979411ots.353.1597416641915; 
 Fri, 14 Aug 2020 07:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-13-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-13-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Aug 2020 22:50:06 +0800
Message-ID: <CAKXe6S+Oc=DaNE=JXW850xoUVmRWv9423NtDVvKd25QfurAgzA@mail.gmail.com>
Subject: Re: [PATCH 12/12] test-util-sockets: Fix a memleak in
 test_socket_unix_abstract_good
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kuhn.chenqun@huawei.com, euler.robot@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Fix a memleak in test_socket_unix_abstract_good().
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---

Hi Nengyuan,
I have sent this two month ago:
-->https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00809.html

seems the maintainer forget to push it to upstream.

Thanks,
Li Qiang


>  tests/test-util-sockets.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 261dc48c03..5c4204a130 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
>      g_thread_join(cli);
>      g_thread_join(serv);
>
> +    g_rand_free(r);
>      g_free(abstract_sock_name);
>  }
>  #endif
> --
> 2.18.2
>
>

