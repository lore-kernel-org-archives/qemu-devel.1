Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B3221655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B3221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RdX-0001IK-F1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0Rbz-0000K3-AI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0Rbx-00036r-Vi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0Rbx-00036Z-QS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:29:17 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A62EA8553F
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 14:29:16 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t9so1308400wrx.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 07:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bl5w6DDez2H1A0CvQ75q5bX+4bNvukIwMbwjuFtTVqI=;
 b=hyolszsOWOGVEOmbU4eeDj3HTSJMWcftPaiFAIBkwnNI9ho7Gln5hygJYeJYKfICcy
 4KUD9C78BR0Mg7l3d+wS9cR+mPFBCDMmtvk2jDVWIiHsy/oCG+p5SNhHQ1IlkVJrg2bl
 1YKAm26ze++xMyQ8x04p3Komhk0v++3VkH591wTyPl9eXcIozhM/bO37j6Ujm89c4y63
 /+dAOZvVawzl7XE45Dm/GDs0GULN52OVi2RDTR1Ab0/POGA7VBK+pjHrHRlLUkAfgMiM
 PzGXWauOT5hfg1gRMs0jhhDXPG4Y5z5qm/FDqFH64rYcNWkgHW6ynWlrz1ZoZiHXBBO4
 nNLg==
X-Gm-Message-State: APjAAAVeIhj7fukYOWmPUuYUmW9yla5eAkDcPW9+HVDFYQXlU6hCqLCk
 +rF14oOAL84vQdC4v5G0jmOD2TaSEVTrr+lzlops7eR0htJUrfIei+otRsd/6Vg65X9SOP2G/s3
 cwoIiw/kwAAu4okE=
X-Received: by 2002:a1c:a852:: with SMTP id r79mr372085wme.36.1566397755420;
 Wed, 21 Aug 2019 07:29:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxZCCyBy0fRQmb6Jgo+tOHnKMf+JEDlsqmDEwR7Mgv7mE/hJcGb2akAq4TUhuZoSsUGLzX1Q==
X-Received: by 2002:a1c:a852:: with SMTP id r79mr372063wme.36.1566397755212;
 Wed, 21 Aug 2019 07:29:15 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f10sm16825599wrs.22.2019.08.21.07.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 07:29:14 -0700 (PDT)
To: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org
References: <20190821142151.19995-1-sandra@codesourcery.com>
 <20190821142151.19995-2-sandra@codesourcery.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b5ccc3eb-4f32-c5e4-d12b-7a0d4f30b599@redhat.com>
Date: Wed, 21 Aug 2019 16:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190821142151.19995-2-sandra@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] target/nios2: Fix bug in semihosted
 exit handling
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 4:21 PM, Sandra Loosemore wrote:
> This patch fixes a bug that caused semihosted exit to always return
> status 0; it was incorrectly using the value of register R_ARG0 (which
> contains the HOSTED_EXIT request number) instead of register R_ARG1.
>=20

Fixes: 413a99a92c1

> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/nios2/nios2-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> index d7a80dd..06c0861 100644
> --- a/target/nios2/nios2-semi.c
> +++ b/target/nios2/nios2-semi.c
> @@ -215,8 +215,8 @@ void do_nios2_semihosting(CPUNios2State *env)
>      args =3D env->regs[R_ARG1];
>      switch (nr) {
>      case HOSTED_EXIT:
> -        gdb_exit(env, env->regs[R_ARG0]);
> -        exit(env->regs[R_ARG0]);
> +        gdb_exit(env, env->regs[R_ARG1]);
> +        exit(env->regs[R_ARG1]);
>      case HOSTED_OPEN:
>          GET_ARG(0);
>          GET_ARG(1);
>=20

