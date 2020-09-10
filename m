Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5592C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD7821D90
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=phystech-edu.20150623.gappssmtp.com header.i=@phystech-edu.20150623.gappssmtp.com header.b="G89RHuMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD7821D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=phystech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTGr-0004Jw-Kd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1kGTGD-0003SN-V6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:33:37 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1kGTGA-00064q-6Q
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:33:36 -0400
Received: by mail-lj1-x244.google.com with SMTP id n25so9925184ljj.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phystech-edu.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=vND6ZMX/PqnO2zoZgd5PmPgzkSfBY/In8mH9gUI4qko=;
 b=G89RHuMk859Az/ZpLRHqGVuPV6EARKnhrJrSxAopboZZfPfEkN6PiqAB4EOZVTyV7M
 t08hpsjXj66XBlPU50sjOWndWZ/IXCZ9bVEF5BfFr00Af3yDEAJtTqQ4VWE6jqkZ9MXT
 mQb3gFRqOIaHXuxGqPyU1CJLT0dWz0Ocl5J0nw9ReAY+a7iGCe+g9RTgyoqsDn0m7wa6
 GaywSV5hwy6nwof+Qyc4uWI8t2zFY8bRRo++afQl1U71Olf5yy8jh5Torj2MhSKzduu+
 vQgZzK6tgs87y8aLwrLyLumpZp/DtqocR39H6uxSNIqhRaqHh13Ey7UHpdQwDJpg03Lu
 /fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=vND6ZMX/PqnO2zoZgd5PmPgzkSfBY/In8mH9gUI4qko=;
 b=m9ncDpSSQkxbs8Kn/ZdI4oOHueZv2vLlq4oRnPdolEzzdrYKLHMtYm6ENJ4rbQkyhd
 FYGNIEZlkPC/S75ybZW1p1r7+MZA40eQ9X1s5WABIjRGjuYib88DdPMcTM8lWc+P/6PP
 et42RcbJW9FzKlMPbGtPsA81sP5Alt5cFru8/t+dQh8u3Tn6fLPiuQTdNlhvAp3u7it1
 k8lAJZQ9PHx1hSJ22+jwvwrDnOWMyfiaozD6lT7S/S3SMiKCwCCxl2jpD+LM/9zhpynN
 VOewab9DqTeq81Ghtnh3Vzk0LSsrMVKfeBUE8ThIDUKDkDs62SQpjfu10MHv0q/IDy/k
 aEww==
X-Gm-Message-State: AOAM530DKvtaopw6+HYebpV4rcB+5F65yUxQZQMwwFQeNQaoua3MoH0p
 KRAoC2RyjS+epA/GUaL0rfopJA==
X-Google-Smtp-Source: ABdhPJwp460vIX5PU+bA1MrOOrkLssTxHhEG3EZHj5j3XeuwDaGqQgNmi7GpaQXr52wIxLoH3iSRyg==
X-Received: by 2002:a2e:9943:: with SMTP id r3mr5155286ljj.342.1599770011454; 
 Thu, 10 Sep 2020 13:33:31 -0700 (PDT)
Received: from 192.168.1.5 (109-252-137-165.dynamic.spd-mgts.ru.
 [109.252.137.165])
 by smtp.gmail.com with ESMTPSA id y11sm8878ljc.27.2020.09.10.13.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 13:33:31 -0700 (PDT)
Date: Thu, 10 Sep 2020 23:33:29 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: AlexChen <alex.chen@huawei.com>
Subject: Re: elf2dmp: Fix memory leak on main() error paths
Message-ID: <20200910233329.41078ba0@192.168.1.5>
In-Reply-To: <5F463659.8080101@huawei.com>
References: <5F463659.8080101@huawei.com>
Organization: MIPT
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=viktor.prutyanov@phystech.edu; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 18:15:53 +0800
AlexChen <alex.chen@huawei.com> wrote:

> From: AlexChen <alex.chen@huawei.com>
> 
> The 'kdgb' is allocating memory in get_kdbg(), but it is not freed
> in both fill_header() and fill_context() failed branches, fix it.
> 
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>  contrib/elf2dmp/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index 9a2dbc2902..ac746e49e0 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -568,12 +568,12 @@ int main(int argc, char *argv[])
>      if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
>              KdVersionBlock, qemu_elf.state_nr)) {
>          err = 1;
> -        goto out_pdb;
> +        goto out_kdbg;
>      }
> 
>      if (fill_context(kdbg, &vs, &qemu_elf)) {
>          err = 1;
> -        goto out_pdb;
> +        goto out_kdbg;
>      }
> 
>      if (write_dump(&ps, &header, argv[2])) {

Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

-- 
Viktor Prutyanov

