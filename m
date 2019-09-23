Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD652C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61BF20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw5HyYKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61BF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCR6N-00008e-NZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR4k-0007dW-0z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR4h-0008Fb-D4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:20:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCR4f-0008CY-FC
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:20:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so14663907wrx.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1oNDsuwGkLDUjfEiBfX3WLUkOmtrN+xTX4rR4lFB7SM=;
 b=rw5HyYKwg5O66iTyhWwwcmEZugpRCJPUC6tI1votSyevLnUQAZDE1bP7UBOUQD7lfq
 Zp7Pf+Br4XGuCjojs498ztW0aevADovuxh9kcl75DKeIYf+Q8Xkk/MNpividRLdxlA/j
 khuOKDXPtyVM0oEWNVuI1x3c6w9XIWQqsNmEZYJLQG7jvvMYYTAQ/wzj8KjSQOZSTE1z
 W1dkf/OSkG4a0jXYNrZoSfg+q74zOE2TnS/zYfw/HmoN8ONhx5i6kR03wYij8moW6ym+
 ETLGxS8zyz7BCWu1gG0SK+Xn6YE5ZDXXdK8pMkY7DZBaSJeushNpPQxZpDu60M0GkQv+
 zHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1oNDsuwGkLDUjfEiBfX3WLUkOmtrN+xTX4rR4lFB7SM=;
 b=L4Ll6ZlTDoxxpN1yYJitGC8o8/fKCOppbXIqXglRI0+vZPZvCZ58UhBx9WtgSAZOiL
 AnaMy/hg9pldh2MeXAacRoK1UVPnPqyZTqSlbbWcOGlXW6/1/CB2WRjGK++mu0KmgZcI
 aVntr9EKiGyPAAJgWJ+FcpKY+ZcG+PbfTut92Rx4DuV43SEjRzQyUgwgULC2/i0lPdbt
 vnWFcFBUtZiNfMg0IIEgHGD6xbGQbgBczOuytc+GxazZhITKQwtSopk0cJc9RmO/3V/3
 8RjbAvTU3pi2fr1sYEdK8th4K05O7pijhS7DNYlDbux1QHBXBeHuG8xMmhBFIaSkpfoq
 2GcQ==
X-Gm-Message-State: APjAAAXjOhNQJCTe8urrJOHI00AIC7ORSX4EfDeSEfmUrwFEYH2KsVkH
 AR07GQA+ZeaYA/7rg1QPNvIdfBRjfU2yWw==
X-Google-Smtp-Source: APXvYqwec/0wiL4+QbKrMC/JnPCJvR7guJDXcwsUAwbuXg+Q99rnjS03ZvTrP22QTXkmo9FOgkfytQ==
X-Received: by 2002:a05:6000:1c4:: with SMTP id
 t4mr178501wrx.183.1569255626243; 
 Mon, 23 Sep 2019 09:20:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g13sm11426630wrm.42.2019.09.23.09.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:20:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EDB81FF87;
 Mon, 23 Sep 2019 17:20:24 +0100 (BST)
References: <20190923131022.15498-1-dgilbert@redhat.com>
 <20190923131022.15498-2-dgilbert@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] tests/migration: Fail on unexpected migration states
In-reply-to: <20190923131022.15498-2-dgilbert@redhat.com>
Date: Mon, 23 Sep 2019 17:20:24 +0100
Message-ID: <87sgonass7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
> We've got various places where we wait for a migration to enter
> a given state; but if we enter an unexpected state we tend to fail
> in odd ways; add a mechanism for explicitly testing for any state
> which we shouldn't be in.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 258aa064d4..9c62ee5331 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -255,15 +255,19 @@ static void read_blocktime(QTestState *who)
>  }
>
>  static void wait_for_migration_status(QTestState *who,
> -                                      const char *goal)
> +                                      const char *goal,
> +                                      const char **ungoals)
>  {
>      while (true) {
>          bool completed;
>          char *status;
> +        const char **ungoal;
>
>          status =3D migrate_query_status(who);
>          completed =3D strcmp(status, goal) =3D=3D 0;
> -        g_assert_cmpstr(status, !=3D,  "failed");
> +        for (ungoal =3D ungoals; *ungoal; ungoal++) {
> +            g_assert_cmpstr(status, !=3D,  *ungoal);
> +        }

You could use:

  g_assert(!g_strv_contains(ungoals, status))

if you wanted to be more gliby. But anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>          g_free(status);
>          if (completed) {
>              return;
> @@ -274,7 +278,8 @@ static void wait_for_migration_status(QTestState *who,
>
>  static void wait_for_migration_complete(QTestState *who)
>  {
> -    wait_for_migration_status(who, "completed");
> +    wait_for_migration_status(who, "completed",
> +                              (const char * []) { "failed", NULL });
>  }
>
>  static void wait_for_migration_pass(QTestState *who)
> @@ -809,7 +814,9 @@ static void test_postcopy_recovery(void)
>       * Wait until postcopy is really started; we can only run the
>       * migrate-pause command during a postcopy
>       */
> -    wait_for_migration_status(from, "postcopy-active");
> +    wait_for_migration_status(from, "postcopy-active",
> +                              (const char * []) { "failed",
> +                                                  "completed", NULL });
>
>      /*
>       * Manually stop the postcopy migration. This emulates a network
> @@ -822,7 +829,9 @@ static void test_postcopy_recovery(void)
>       * migrate-recover command can only succeed if destination machine
>       * is in the paused state
>       */
> -    wait_for_migration_status(to, "postcopy-paused");
> +    wait_for_migration_status(to, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL });
>
>      /*
>       * Create a new socket to emulate a new channel that is different
> @@ -836,7 +845,9 @@ static void test_postcopy_recovery(void)
>       * Try to rebuild the migration channel using the resume flag and
>       * the newly created channel
>       */
> -    wait_for_migration_status(from, "postcopy-paused");
> +    wait_for_migration_status(from, "postcopy-paused",
> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL });
>      migrate(from, uri, "{'resume': true}");
>      g_free(uri);


--
Alex Benn=C3=A9e

