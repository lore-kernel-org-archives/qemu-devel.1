Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B94C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50ED20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50ED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFpr-0006z5-5n
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFnj-0005VL-Gk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFnh-0003es-UJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFnh-0003de-Lr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:30:21 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90E9483F3C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:30:20 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so165806wmf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5UwO0KG1Np77AFeMve4+gdin01AQQUcwyTtFtjiou+I=;
 b=kpDgJ8uIOExxYxXINeo4sfYrUMaKgMCsGBE2FPT4W09MIPS9O2qvSwga97PYRZjnGx
 johyQNCkariKXRtC5Qspz6NJthfUu8UaKHIbBjzx+nFN+XO+pIxPkUXZBeabsM9+OCYX
 q65PEcSeOQNcinFg9/kcKsDTuRFV4j6ydIkgATDFVi9dHMUv9FnjMvhKdsXsE6xB2e+X
 wVOuSwvvEvryjYu7595OzenJP4YqcSl1OIduqlSw8UPIDdJMFFE4cnEw0fErWFjD4p0i
 gpcto9I5ISWTg4TtHhQYc+wam1+yWLDJDCCZem76G62y4V1lHZ2X5KnitYVNRbvwUm+W
 I7Iw==
X-Gm-Message-State: APjAAAXk6ELlScjrkswIhNOK7B945i75m+0oGQIa3wnbLyx2+8REsiiQ
 2DiDgUpBdYneVfR/mnZ8uGLfyAaZecukoYF+QxRnMpqDd+2+PNn/8EYXkz7KmJZ0AVL95EsiCqP
 7Ao8Sfx1d2Wb7k0c=
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr453517wrv.388.1569450618727; 
 Wed, 25 Sep 2019 15:30:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHT0IRgCXV1196rLmSvdwxUqxvt1tivXwnXWyMS/hcxFowFe9pirYYmDJkECTl6eHwQyKrVg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr453508wrv.388.1569450618546; 
 Wed, 25 Sep 2019 15:30:18 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y5sm317270wma.14.2019.09.25.15.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:30:17 -0700 (PDT)
Subject: Re: [PATCH v3 08/33] tests/migration: Fail on unexpected migration
 states
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3426d48f-ea23-6e09-fc0e-81425b4114fa@redhat.com>
Date: Thu, 26 Sep 2019 00:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, f4bug@amsat.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> We've got various places where we wait for a migration to enter
> a given state; but if we enter an unexpected state we tend to fail
> in odd ways; add a mechanism for explicitly testing for any state
> which we shouldn't be in.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190923131022.15498-2-dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 258aa064d48..9c62ee5331b 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -255,15 +255,19 @@ static void read_blocktime(QTestState *who)
>  }
> =20
>  static void wait_for_migration_status(QTestState *who,
> -                                      const char *goal)
> +                                      const char *goal,
> +                                      const char **ungoals)
>  {
>      while (true) {
>          bool completed;
>          char *status;
> +        const char **ungoal;
> =20
>          status =3D migrate_query_status(who);
>          completed =3D strcmp(status, goal) =3D=3D 0;
> -        g_assert_cmpstr(status, !=3D,  "failed");
> +        for (ungoal =3D ungoals; *ungoal; ungoal++) {
> +            g_assert_cmpstr(status, !=3D,  *ungoal);

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        }
>          g_free(status);
>          if (completed) {
>              return;
> @@ -274,7 +278,8 @@ static void wait_for_migration_status(QTestState *w=
ho,
> =20
>  static void wait_for_migration_complete(QTestState *who)
>  {
> -    wait_for_migration_status(who, "completed");
> +    wait_for_migration_status(who, "completed",
> +                              (const char * []) { "failed", NULL });
>  }
> =20
>  static void wait_for_migration_pass(QTestState *who)
> @@ -809,7 +814,9 @@ static void test_postcopy_recovery(void)
>       * Wait until postcopy is really started; we can only run the
>       * migrate-pause command during a postcopy
>       */
> -    wait_for_migration_status(from, "postcopy-active");
> +    wait_for_migration_status(from, "postcopy-active",
> +                              (const char * []) { "failed",
> +                                                  "completed", NULL })=
;
> =20
>      /*
>       * Manually stop the postcopy migration. This emulates a network
> @@ -822,7 +829,9 @@ static void test_postcopy_recovery(void)
>       * migrate-recover command can only succeed if destination machine
>       * is in the paused state
>       */
> -    wait_for_migration_status(to, "postcopy-paused");
> +    wait_for_migration_status(to, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL })=
;
> =20
>      /*
>       * Create a new socket to emulate a new channel that is different
> @@ -836,7 +845,9 @@ static void test_postcopy_recovery(void)
>       * Try to rebuild the migration channel using the resume flag and
>       * the newly created channel
>       */
> -    wait_for_migration_status(from, "postcopy-paused");
> +    wait_for_migration_status(from, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL })=
;
>      migrate(from, uri, "{'resume': true}");
>      g_free(uri);
> =20
>=20

