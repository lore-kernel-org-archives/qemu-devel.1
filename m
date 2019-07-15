Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ACC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB85E2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rz4yo/QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB85E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxTd-0001lx-NV
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hmxT3-000810-BE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hmxT2-0001Am-0M
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:21 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:40852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hmxT1-00019B-7v
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:19 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id EA14C2E097D;
 Mon, 15 Jul 2019 12:40:10 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 uKQSW8mXmJ-eAtqCCAB; Mon, 15 Jul 2019 12:40:10 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563183610; bh=XiGjSuDPV5TMc7w/swxGq4pl/T6MrZlTEvnjAzR3FMg=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=rz4yo/QAVY7Tn8/12BENAKP7FX57eUGjo8GypTPJizh7/GyGiuQ+npPTpHqAe/sKo
 IlvWwxKg0vNDxijx+usgc6NvEw8/F0LFGlXbvZdLZgZGZdIbuaoLb/zzNghlHOhp0p
 HnfjgEqLNujB4umB0YxNoK+ZiGww90F3mwaxIPDM=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net (localhost [::1])
 by mxbackcorp2j.mail.yandex.net with LMTP id v1E6VAvKuO-Px3O9M8A
 for <yury-kotov@yandex-team.ru>; Mon, 15 Jul 2019 12:40:00 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
 Mon, 15 Jul 2019 12:39:59 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
In-Reply-To: <20190710092338.23559-3-yury-kotov@yandex-team.ru>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
 <20190710092338.23559-3-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 15 Jul 2019 12:40:09 +0300
Message-Id: <1262801563183599@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] cpus: Fix throttling during vm_stop
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

10.07.2019, 12:26, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Throttling thread sleeps in VCPU thread. For high throttle percentage
> this sleep is more than 10ms. E.g. for 60% - 15ms, for 99% - 990ms.
> vm_stop() kicks all VCPUs and waits for them. It's called at the end of
> migration and because of the long sleep the migration downtime might be
> more than 100ms even for downtime-limit 1ms.
> Use qemu_cond_timedwait for high percentage to wake up during vm_stop.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
> =C2=A0cpus.c | 27 +++++++++++++++++++--------
> =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index ffc57119ca..3c069cdc33 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -74,6 +74,8 @@
>
> =C2=A0#endif /* CONFIG_LINUX */
>
> +static QemuMutex qemu_global_mutex;
> +
> =C2=A0int64_t max_delay;
> =C2=A0int64_t max_advance;
>
> @@ -776,7 +778,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_=
on_cpu_data opaque)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double pct;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double throttle_ratio;
> - long sleeptime_ns;
> + int64_t sleeptime_ns;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!cpu_throttle_get_percentage()) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> @@ -784,11 +786,22 @@ static void cpu_throttle_thread(CPUState *cpu, ru=
n_on_cpu_data opaque)
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pct =3D (double)cpu_throttle_get_percenta=
ge()/100;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0throttle_ratio =3D pct / (1 - pct);
> - sleeptime_ns =3D (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
> -
> - qemu_mutex_unlock_iothread();
> - g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
> - qemu_mutex_lock_iothread();
> + /* Add 1ns to fix double's rounding error (like 0.9999999...) */
> + sleeptime_ns =3D (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS=
 + 1);
> +
> + while (sleeptime_ns >=3D SCALE_MS && !cpu->stop) {
> + int64_t start, end;
> + start =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> + qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,

Paolo, Richard, please tell me what you think.
I'm not sure is it correct to use qemu_cond_timedwait() here?
I see that qemu_cond_timedwait()/qemu_cond_wait() and
qemu_mutex_(un)lock_iothread() have a different behavior in some cases.
But there are some similar using of qemu_cond_wait with halt_cond, so may=
 be
it's ok to use qemu_cond_timedwait() here too.

> + sleeptime_ns / SCALE_MS);
> + end =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> + sleeptime_ns -=3D end - start;
> + }
> + if (sleeptime_ns >=3D SCALE_US && !cpu->stop) {
> + qemu_mutex_unlock_iothread();
> + g_usleep(sleeptime_ns / SCALE_US);
> + qemu_mutex_lock_iothread();
> + }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_set(&cpu->throttle_thread_schedule=
d, 0);
> =C2=A0}
>
> @@ -1166,8 +1179,6 @@ static void qemu_init_sigbus(void)
> =C2=A0}
> =C2=A0#endif /* !CONFIG_LINUX */
>
> -static QemuMutex qemu_global_mutex;
> -
> =C2=A0static QemuThread io_thread;
>
> =C2=A0/* cpu creation */
> --
> 2.22.0

Regards,
Yury

