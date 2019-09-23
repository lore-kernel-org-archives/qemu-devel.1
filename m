Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F23C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB44206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpADbOsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB44206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCT0K-0003bl-R6
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCSzU-0002tR-Kv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCSzS-0006Jd-JM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:23:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCSzQ-0006Fp-Oi
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:23:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so15087007wrj.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2aRLOWbQBHZxfWY7ajzjlKjz7UVw1KcTfLqUCMkdlew=;
 b=KpADbOsp7RP12n00r3QP0TNNqSgIfENerJWmzVVGGQyPj81e3BRIAIPIcNWqJ++H0S
 JH3YUpeCSIp19k5feuHjgaBO658EgVD/rkO1wcEUumuHebMWtmzMyfExS9A8d67+8Bsc
 WRaU2g0djS1rR1C/mKDNowjj35kl32UceYO5ZPTvWvYpln/wpQOH1HkdnE2GbjKkqJo5
 Pqn7JTDlCLSh6flG+/zmw4M+rRWlnJLGSFUpJ0TFnTucLPuBNlNr/cc+k9x6PbEcHOkg
 xuVlMdpMBWlazwk6lswZY/2dzFU5Nh7LfTpzIWcGay/40RMX/69jsSwWln8Hey9JLYvA
 O2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2aRLOWbQBHZxfWY7ajzjlKjz7UVw1KcTfLqUCMkdlew=;
 b=Tz+fouMwq3XIrLa09B4eSOp+OWChWcMPsEOONydgcPk+LzpSxl4Sa9Tmnbb6iGRkbd
 4IolZJTOTdYNJElCiLe1DPcWSZ1M2tPK9C1WniJoc0fOkil1phEWu02pJTwVauxcWnOK
 7QLYotdwQXbfByTfyuYweC4XBRcK6y7W/3vvjQxXBFtWkZQAGWNbsphWnOUgKbRkJoeC
 FtmvcvJ8y+L+YzJ8dOSCICojHIzr0f3YsRe72HqJFLIQBSJk07Z/ogRno5mmSPTE/Tlf
 4leoHsbJgpre8XVVAiqeK3ve+/OSaT6XeoYpjH/4NH5GKd/ONo9oC/HTXT/KW6t3nzc1
 /oBw==
X-Gm-Message-State: APjAAAXVr78gn11QI0ZwpFpF4Sep4bWao+QULXThy6r0M9htlL+KnC75
 KWnIxML6y91ydBxvNBSpjqrO4IK9RAwU4A==
X-Google-Smtp-Source: APXvYqwmAQLKQBoI8Odg0BAyJa69h6mdJgrpi5W177SEM9hNziX9JnVpWXKpDqMwf/Kr4CeEu/P/aA==
X-Received: by 2002:adf:e485:: with SMTP id i5mr572727wrm.175.1569262987695;
 Mon, 23 Sep 2019 11:23:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm25105067wrb.14.2019.09.23.11.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 11:23:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 658161FF87;
 Mon, 23 Sep 2019 19:23:06 +0100 (BST)
References: <20190923174942.12182-1-dgilbert@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
In-reply-to: <20190923174942.12182-1-dgilbert@redhat.com>
Date: Mon, 23 Sep 2019 19:23:06 +0100
Message-ID: <87impic1o5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Various parts of the migration code do different things when they're
> in postcopy mode; prior to this patch this has been 'postcopy-active'.
> This patch extends 'in_postcopy' to include 'postcopy-paused' and
> 'postcopy-recover'.
>
> In particular, when you set the max-postcopy-bandwidth parameter, this
> only affects the current migration fd if we're 'in_postcopy';
> this leads to a race in the postcopy recovery test where it increases
> the speed from 4k/sec to unlimited, but that increase can get ignored
> if the change is made between the point at which the reconnection
> happens and it transitions back to active.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'm stress testing it now.

> ---
>  migration/migration.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 01863a95f5..5f7e4d15e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1659,7 +1659,14 @@ bool migration_in_postcopy(void)
>  {
>      MigrationState *s =3D migrate_get_current();
>
> -    return (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    switch (s->state) {
> +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +        return true;
> +    default:
> +        return false;
> +    }
>  }
>
>  bool migration_in_postcopy_after_devices(MigrationState *s)


--
Alex Benn=C3=A9e

