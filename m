Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E4C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DAA21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DAA21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hij3A-00072Q-QL
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hij0T-0004si-G4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hij0P-0004zA-3H
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hij0O-0004xJ-RW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3DAA882F5
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 17:25:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AA129CD9;
 Wed,  3 Jul 2019 17:25:03 +0000 (UTC)
Date: Wed, 3 Jul 2019 18:25:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190703172501.GI23082@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703171005.26231-1-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 03 Jul 2019 17:25:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> We can pass trace trace options with the -trace command line
> argument.
>=20
> Tracing might be useful when running qtests. To avoid to have
> to modify the tests and recompile, add the possibility to pass
> trace options via the shell environment.
>=20
> We add:
> - QEMU_TRACE_EVENTS:    List of events to enable (coma separated)
> - QEMU_TRACE_EVENTFILE: File with list of events to enable
> - QEMU_TRACE_LOGFILE:   File to log the trace events.
>=20
> Example of use:
>=20
>   $ QEMU_TRACE_EVENTS=3Dpl011\* make check-qtest-arm
>     TEST    check-qtest-arm: tests/boot-serial-test
>   18650@1562168430.027490:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18650@1562168430.027535:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18650@1562168430.027544:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18650@1562168430.028037:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18650@1562168430.028049:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18650@1562168430.028057:pl011_can_receive LCR 0x00000000 read_count 0=
 returning 1
>   18653@1562168430.053250:pl011_write addr 0x00000000 value 0x00000054
>   18653@1562168430.053276:pl011_irq_state irq state 0
>   [...]
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> I'm not sure where to document that...
> ---
>  trace/control.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/trace/control.c b/trace/control.c
> index 43fb7868db..aea802623c 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -288,6 +288,8 @@ void trace_fini_vcpu(CPUState *vcpu)
> =20
>  bool trace_init_backends(void)
>  {
> +    char *trace_env;
> +
>  #ifdef CONFIG_TRACE_SIMPLE
>      if (!st_init()) {
>          fprintf(stderr, "failed to initialize simple tracing backend.\=
n");
> @@ -306,6 +308,13 @@ bool trace_init_backends(void)
>      openlog(NULL, LOG_PID, LOG_DAEMON);
>  #endif
> =20
> +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
> +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
> +    trace_env =3D getenv("QEMU_TRACE_EVENTS");
> +    if (trace_env) {
> +        trace_enable_events(trace_env);
> +    }
> +

I don't think it is a nice idea to add this via environment variables
to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handshake
to read the env vars and then pass a suitable -trace arg when spawning
QEMU ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

