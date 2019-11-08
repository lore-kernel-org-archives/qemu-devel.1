Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25676FC6194
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED4A21D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED4A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2zJ-0007qO-Hb
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2xZ-0006Xg-9Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2xX-0007or-J1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:01:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2xX-0007kU-Am
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:01:47 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8394C04959B
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 12:01:44 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g13so3525860wme.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 04:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AB/CNrdzUpNGwQgpu66FwiqNpGIQBx0Jf+JXKV0ntQg=;
 b=gLL0blsD6R1gV1x6wXGK+0rdpbxPNznJ6RAKSAPBACTqM9iGMPjEd54CpCUAJnHdkr
 ESqnU/eS+oiyCOVCZNErBBGsC2nX7OPeefExxUTcLPEwNrOgolHCpj9vJB5PBVj+MDZi
 0+PWJtdf6v3gHaltR7cuiW/l2pbGAm4H01/bM9Bc2lkU1+2ozBVIgnX67ZWk0i8Q8nle
 0EkV4n0wJFFmQ3XP4bMvhy1Ukc+//ipOW4YCz4ouMwAzccEjIMkxTW9s/yidy2LBqFWc
 CMr5/+uZ+fwVjWbEyyiV0uMOV5F/M4r7b8KdJaiPirxFu2SMBCuxK13QfC1xpdo82OSN
 dGBQ==
X-Gm-Message-State: APjAAAWxSEWEQemuHXQcXV48DYoz+taVHEg/PJXaNZL+Bpx+RWd8OmBy
 F3CvT9lvvDipnRH+LZVi0+wkH1nujEHm25rq4IvugawJTHJ41tKeP4EDOhMWnlxjajDFRqdf9nH
 JVKglPSGNtaoUFFY=
X-Received: by 2002:adf:9786:: with SMTP id s6mr1027429wrb.188.1573214503499; 
 Fri, 08 Nov 2019 04:01:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYy7RKwhq44LXLIxqKnVvRwUOaCmiEhQchn7wa9uuEgNdTSHCdp9oMbYMIJIIyRFVGxs5wIQ==
X-Received: by 2002:adf:9786:: with SMTP id s6mr1027407wrb.188.1573214503321; 
 Fri, 08 Nov 2019 04:01:43 -0800 (PST)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id u7sm10166460wre.59.2019.11.08.04.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 04:01:42 -0800 (PST)
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, alex.bennee@linaro.org,
 thuth@redhat.com
References: <20191108104307.125020-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40fc4179-31fa-b421-7a02-7d68b28a91a9@redhat.com>
Date: Fri, 8 Nov 2019 13:01:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108104307.125020-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 11:43 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> We're seeing occasional asserts in 'wait_for_migraiton_fail', that
> I can't reliably reproduce, and where the cores don't have any useful
> state.  Print the 'status' out, so we can see which unexpected state
> we're ending up in.

Back to the good remote printf() debugging :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tests/migration-test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 59f291c654..ac780dffda 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -899,8 +899,13 @@ static void wait_for_migration_fail(QTestState *fr=
om, bool allow_active)
>  =20
>       do {
>           status =3D migrate_query_status(from);
> -        g_assert(!strcmp(status, "setup") || !strcmp(status, "failed")=
 ||
> -                 (allow_active && !strcmp(status, "active")));
> +        bool result =3D !strcmp(status, "setup") || !strcmp(status, "f=
ailed") ||
> +                 (allow_active && !strcmp(status, "active"));
> +        if (!result) {
> +            fprintf(stderr, "%s: unexpected status status=3D%s allow_a=
ctive=3D%d\n",
> +                    __func__, status, allow_active);
> +        }
> +        g_assert(result);
>           failed =3D !strcmp(status, "failed");
>           g_free(status);
>       } while (!failed);
>=20

