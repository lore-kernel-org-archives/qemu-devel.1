Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87544C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E29B21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3CxCfbTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E29B21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40Rk-0002tw-Bb
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j40P8-0007fw-PB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j40P7-0004Zu-Pg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:47:02 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j40P0-0004Tu-PC; Tue, 18 Feb 2020 05:46:55 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E3FA896EF0;
 Tue, 18 Feb 2020 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582022812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDbOYa/JAH7yg067XMLutHKJFAx6JLL7i8d5AJAHhBU=;
 b=3CxCfbTASOD7oAMD7zpwgwl5e0pN9Yx4Y9Z82yjKR9e76k11LxKPRYIaQ5KjHcbYetXC9w
 0pGdjv8ROjqYwCCzQtD55n8G1b4roEGp7GN9jzZ1PS3zvPKoo9Cq+wM+IcYS3Cf1jK/Fqy
 szHViB5/3gOW1Ev/2IEn2IYoWD16Klw=
Subject: Re: [PATCH RESEND 01/13] scripts/checkpatch.pl: Detect superfluous
 semicolon in C code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200218094402.26625-1-philmd@redhat.com>
 <20200218094402.26625-2-philmd@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <b6a9843f-b47d-b560-7726-4aee0de5d6be@greensocs.com>
Date: Tue, 18 Feb 2020 11:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218094402.26625-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582022812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDbOYa/JAH7yg067XMLutHKJFAx6JLL7i8d5AJAHhBU=;
 b=bZvQbNecuHPdG/OXYa6LCUxxdHBNjrwPKgpDHOrbEGqAZS4Pb4dZvcKvNaV2kJme0PnKUA
 GYK3hqsigffx7nOhFbI72L72K9a9CDIDJSTsFREDDgPaD573EHbneMAe1BGMnw6vKMfU9+
 FdYKok427AHD6CLdlgm4gj7ZJ/gQ7xo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582022812; a=rsa-sha256; cv=none;
 b=r0R5VHq2RIdaP/BS6iiIvdj3LI5YGhOMB/Z+9EYwiSYy83f8hsKx1zgZ2dcTlymZfCgY0e
 exEr5+VtPZUUaKVUJ5ZEtSxButUYMG3CstxHQ6sM8d/XkWaE6bXBlKUHMttrEKWbNs9NTg
 6iSg8JOSqNOh1EaStmmLWsHNueOm+Vg=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 10:43 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Display error when a commit contains superfluous semicolon:
>=20
>   $ git show 6663a0a3376 | scripts/checkpatch.pl -q -
>   ERROR: superfluous trailing semicolon
>   #276: FILE: block/io_uring.c:186:
>   +                ret =3D -ENOSPC;;
>   total: 1 errors, 1 warnings, 485 lines checked
>=20
> Reported-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ce43a306f8..11512a8a09 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1830,6 +1830,11 @@ sub process {
>  			ERROR("suspicious ; after while (0)\n" . $herecurr);
>  		}
> =20
> +# Check superfluous trailing ';'
> +		if ($line =3D~ /;;$/) {
> +			ERROR("superfluous trailing semicolon\n" . $herecurr);
> +		}
> +
>  # Check relative indent for conditionals and blocks.
>  		if ($line =3D~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*=
#/ && $line !~ /\}\s*while\s*/) {
>  			my ($s, $c) =3D ($stat, $cond);
>=20

