Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF4C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4174320693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="dCLQpZu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4174320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mnq-0004Ng-ED
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i8mms-0003i9-9F
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i8mmp-0005VU-6r
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:43:00 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:36530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i8mmo-0005TQ-CV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:42:59 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id ACD2F2E14FB;
 Fri, 13 Sep 2019 17:42:53 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 iA2jSartRI-grsuhZlO; Fri, 13 Sep 2019 17:42:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568385773; bh=Wxt5xCjcFTm5WLWFntSPtEzy06ghBPkr7i7fZ3apDws=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=dCLQpZu/dMxrIV2vLEsOn1wsVlxf/YXgX9zbI0Y+fT1LcOG7r7RMSgh1PXkOQt8qi
 IkUI1V7V9wn/ld3QXnIHn04/LrQ7HdaZIkV82mZAR0JIKRLJqyXpnVO9wXlKPayxAl
 N1Yl1se45LdJFPT16Yo8ZIhcyGawjKmdpTX3o9WQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net (localhost [::1])
 by mxbackcorp2j.mail.yandex.net with LMTP id 1peWqOegwF-zsPzHFoX
 for <yury-kotov@yandex-team.ru>; Fri, 13 Sep 2019 17:42:43 +0300
Received: by sas1-fc7737ec834f.qloud-c.yandex.net with HTTP;
 Fri, 13 Sep 2019 17:42:43 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
In-Reply-To: <8d153143-22ea-cb81-f33a-7356155c9fe4@virtuozzo.com>
References: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
 <8d153143-22ea-cb81-f33a-7356155c9fe4@virtuozzo.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 13 Sep 2019 17:42:53 +0300
Message-Id: <926881568385763@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: Re: [Qemu-devel] [PATCH] migration: Fix use-after-free during
 process exit
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vladimir!

13.09.2019, 16:43, "Vladimir Sementsov-Ogievskiy" <vsementsov@virtuozzo.c=
om>:
> Hi!
>
> 08.04.2019 14:33, Yury Kotov wrote:
>> =C2=A0It fixes heap-use-after-free which was found by clang's ASAN.
>>
>> =C2=A0Control flow of this use-after-free:
>> =C2=A0main_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Got SIGTERM and completes main l=
oop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls migration_shutdown
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- migrate_fd_cancel (s=
o, migration_thread begins to complete)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- object_unref(OBJECT(=
current_migration));
>>
>> =C2=A0migration_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* migration_iteration_finish -> sc=
hedule cleanup bh
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* object_unref(OBJECT(s)); (Now, c=
urrent_migration is freed)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* exits
>>
>> =C2=A0main_thread:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls vm_shutdown -> drain bdrvs=
 -> main loop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> cleanup_bh -> use a=
fter free
>
> [..]
>
>> =C2=A0+static void migrate_fd_cleanup_schedule(MigrationState *s)
>> =C2=A0+{
>> =C2=A0+ /* Ref the state for bh, because it may be called when
>> =C2=A0+ * there're already no other refs */
>> =C2=A0+ object_ref(OBJECT(s));
>> =C2=A0+ qemu_bh_schedule(s->cleanup_bh);
>> =C2=A0+}
>
> so you ref on scheduling
>
>> =C2=A0+
>> =C2=A0+static void migrate_fd_cleanup_bh(void *opaque)
>> =C2=A0+{
>> =C2=A0+ MigrationState *s =3D opaque;
>> =C2=A0+ migrate_fd_cleanup(s);
>> =C2=A0+ object_unref(OBJECT(s));
>> =C2=A0+}
>
> and unref after execution of bh.
>
> but migration code has also call to qemu_bh_delete(s->cleanup_bh) from
> migrate_fd_cleanup(), in migrate_fd_cleanup() is called not only from
> migrate_fd_cleanup_bh..
>
> I mean, that if we call qemu_bh_delete after scheduling, we will not
> unref our new reference.
>
> Still, seems it's impossible, as all other calls to migrate_fd_cleanup
> are done before migration thread creation.
>
> Don't know, should something done around it or not, but decided to ment=
ion it.
>

Hmm.. It's very interesting, thanks! I need more time to understand
is there a problem or not, but after quick look I see one possibility
to achieve a leak: qmp_migrate after cleanup bh schedule and before bh ca=
ll...

>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0void migrate_set_error(MigrationState *s, const Erro=
r *error)
>> =C2=A0=C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock(&s->error_mu=
tex);
>> =C2=A0@@ -3144,7 +3157,7 @@ static void migration_iteration_finish(Mig=
rationState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0erro=
r_report("%s: Unknown ending state %d", __func__, s->state);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0brea=
k;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0- qemu_bh_schedule(s->cleanup_bh);
>> =C2=A0+ migrate_fd_cleanup_schedule(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock_iothread()=
;
>> =C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -3279,7 +3292,7 @@ void migrate_fd_connect(MigrationState *s,=
 Error *error_in)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool resume =3D s->state =3D=
=3D MIGRATION_STATUS_POSTCOPY_PAUSED;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->expected_downtime =3D s->=
parameters.downtime_limit;
>> =C2=A0- s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup, s);
>> =C2=A0+ s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup_bh, s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (error_in) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migr=
ate_fd_error(s, error_in);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migr=
ate_fd_cleanup(s);
>
> --
> Best regards,
> Vladimir

Regards,
Yury

