Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B23C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C611C20786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp7ujeXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAspY-0000lO-59
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAsp2-0000Hm-4E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:38:28 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAsp0-0008Ag-Fe
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:38:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id v13so1062973oiv.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QnahO6RaE7Swl7ORyoZff6JyJLeR1Uxy7pFWOUSO9v8=;
 b=lp7ujeXgJgBO2ayhfXnq2HGsb5VxbTMZkRJWEddB/HugRuHu6DT3uXuRSb5ywyS1Qh
 MFFPtEokT8EGNIatENwLo4zQ/LMhMije5jAlHTBzN6EU5qEd2NxM4WVAWGvXuXqjXFJ9
 dPCdzhBWx0OMKYSgGnKM87yx6WjirNyQW93iJA+Afc30EQSzblVwm5rCijP4JPaxyKzE
 E4z72geQZsolmT30N1rXndhP6THkB3LCu1Bov7HUKlf+YNnty8lrm5HfA96rTj84t+Az
 Xv3mBFSzDC1+2hBuexa44i6auuOFuf7EGwW0aanrkMCXI1ReykZV7QLroXEJHG26Emv+
 uheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QnahO6RaE7Swl7ORyoZff6JyJLeR1Uxy7pFWOUSO9v8=;
 b=h09gVlTrTK78wf8MvBLxOpAhmKFakZMFsb6Oj3wKs61K9Mtds8MHBd/F4W5uVROKKm
 UvvQ8vxy5KoYVv1Zi5De3kTmqegSGptp96yFf5yAs7aWh1uZoppFweFTsL3ODTDgGrvg
 BbH3zKF++Qk8r8YJXN95mc4Dtxxdpfvrp/mNODZ2Xyjj9KJVOw5PuOKIo+PMRDy40DkG
 nnqZcd66MjG/ruPPzEgRYtOZ36ZbiUkwD0GqvfkohrVPGYaARnCbbXShfg5fSnhIOOy5
 +1L9pPlklPZedlNJXuhV5Suy9qIqicKq++3KWGSCrimfJjKsiOJrFTiULWAzeDEwiHfw
 FgSg==
X-Gm-Message-State: AOAM532u5BwQqOhp8DS9uvTN+Au07IErdDAhaQKOTjvcbA0+ZiBo6sAa
 3jTJCwV4iTiuw2PybnRaOJsdiNnbnfyzpvyOBD8=
X-Google-Smtp-Source: ABdhPJxlLHsRrk7WFi8tIXFV4gRMK3X90aO55c5aqdz7ynI5tI7qwpUbmQwfn69k5cVkGXmENb3T5MvyKL3pIW7SR58=
X-Received: by 2002:aca:1117:: with SMTP id 23mr3566926oir.97.1598438304969;
 Wed, 26 Aug 2020 03:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-12-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-12-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:37:49 +0800
Message-ID: <CAKXe6S+8mDZ4Ka8kenPBOu8-Jx=hm8Jk9wNedN11Wy75y0YApw@mail.gmail.com>
Subject: Re: [PATCH 11/12] vnc-auth-sasl: Plug memleak in
 vnc_socket_ip_addr_string
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A
>
> 'addr' forgot to free in vnc_socket_ip_addr_string error path. Fix that.

s/forgot/is forgot, I think the maintainer will do this minor adjustment.

.



>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc-auth-sasl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index 7b2b09f242..0517b2ead9 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -522,6 +522,7 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
>
>      if (addr->type !=3D SOCKET_ADDRESS_TYPE_INET) {
>          error_setg(errp, "Not an inet socket type");
> +        qapi_free_SocketAddress(addr);
>          return NULL;
>      }
>      ret =3D g_strdup_printf("%s;%s", addr->u.inet.host, addr->u.inet.por=
t);
> --
> 2.18.2
>
>

