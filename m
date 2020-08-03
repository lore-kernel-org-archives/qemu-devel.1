Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B646C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA95920738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnVHsOw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Xun-0006uB-W9
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2Xu5-00063Z-RL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:41:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2Xu2-0000BX-VR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596451270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsw1jD6F73oHmX9uzy0BjIk+3oSChCLNmDMx8VEFyOQ=;
 b=UnVHsOw6oCWqm+aL/rxacIOCG1zSmtnKjzy38GD1wXLZxnocdxp/Fo2+B5eKnBKL56taXH
 A6rSttA8qGVIvtKqyl91o1v/Z2Qg5gtISDeYMZveKuY1HEhg4B97vAqK2+Mk09oVdoUtuw
 K6RqRUahWbIrfl+6wJUhqOpdtM0XmX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-CIHq7pj0N1C65f6lIM5rxA-1; Mon, 03 Aug 2020 06:41:08 -0400
X-MC-Unique: CIHq7pj0N1C65f6lIM5rxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0D1A1DE1;
 Mon,  3 Aug 2020 10:41:06 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21C0D5FC36;
 Mon,  3 Aug 2020 10:41:00 +0000 (UTC)
Date: Mon, 3 Aug 2020 11:40:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v4 1/2] trace: Add support for recorder back-end
Message-ID: <20200803104059.GF244853@stefanha-x1.localdomain>
References: <20200723132903.1980743-1-dinechin@redhat.com>
 <20200723132903.1980743-2-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723132903.1980743-2-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2020 at 03:29:02PM +0200, Christophe de Dinechin wrote:
> diff --git a/configure b/configure
> index 4bd80ed507..3770ff873d 100755
> --- a/configure
> +++ b/configure
> @@ -7761,6 +7761,20 @@ fi
>  if have_backend "log"; then
>    echo "CONFIG_TRACE_LOG=y" >> $config_host_mak
>  fi
> +if have_backend "recorder"; then
> +    recorder_minver="1.0.10"
> +    if $pkg_config --atleast-version=$recorder_minver recorder ; then
> +        recorder_cflags="$($pkg_config --cflags recorder)"
> +        recorder_libs="$($pkg_config --libs recorder)"
> +        LIBS="$recorder_libs $LIBS"
> +        libs_qga="$recorder_libs $libs_qga"
> +        QEMU_CFLAGS="$QEMU_CFLAGS $recorder_cflags"
> +        zstd="yes"

Why enable zstd?

This happens after the zstd library dependency probe, so it overrides
the zstd setting even if the probe failed earlier on. This seems
strange.

> +#if defined(CONFIG_TRACE_RECORDER)
> +    {
> +        .name       = "recorder",
> +        .args_type  = "op:s?,arg:s?",
> +        .params     = "trace|dump [arg]",
> +        .help       = "trace selected recorders or print recorder dump",
> +        .cmd        = hmp_recorder,
> +    },
> +
> +SRST
> +``trace`` *cmds*

How is this sub-command different from the "trace-event <name> on|off"
HMP command?

> +  Activate or deactivate tracing for individual recorder traces.
> +  See recorder_trace_set(3) for the syntax of *cmds*
> +  For example, to activate trace ``foo`` and disable alll traces

s/alll/all/

> +  ending in ``_warning``, use ``foo:.*_warning=0``.
> +  Using ``help`` will list available traces and their current setting.

"help" is not listed in .params.

How is this sub-command different from the "info trace-events" HMP
command?

> +#ifdef CONFIG_TRACE_RECORDER
> +static void hmp_recorder(Monitor *mon, const QDict *qdict)
> +{
> +    const char *op = qdict_get_try_str(qdict, "op");
> +    const char *arg = qdict_get_try_str(qdict, "arg");
> +
> +    if (!op) {
> +        monitor_printf(mon, "missing recorder command\"%s\"\n", op);

op is NULL, why format it?

There is a space missing after "command".

> +def generate_c_begin(events, group):
> +    out('#include "qemu/osdep.h"',
> +        '#include "trace/control.h"',
> +        '#include "trace/simple.h"',

Is this header needed?

> +RECORDER_CONSTRUCTOR
> +void recorder_trace_init(void)

This function is called 3 times:
1. RECORDER_CONSTRUCTOR
2. trace_init_backends()
3. module_load_file()

That is unusual for an "init" function. Are all 3 really necessary?
Please add a comment explaining what is going on here and/or rename it
to recorder_trace_reinit().

> +{
> +    const char *traces = getenv("RECORDER_TRACES");
> +    recorder_trace_set(traces);
> +
> +    /*
> +     * Allow a dump in case we receive some unhandled signal
> +     * For example, send USR2 to a hung process to get a dump
> +     */
> +    if (traces) {
> +        recorder_dump_on_common_signals(0, 0);

Did you check all programs (i.e. qemu-system-*, qemu-user-*, qemu-img,
etc) to see whether installing various signal handlers is okay?

The library documentation says the following signals are handled:

  SIGQUIT, SIGILL, SIGABRT, SIGBUS, SIGSEGV, SIGSYS, SIGXCPU, SIGXFSZ,
  SIGINFO, SIGUSR1, SIGUSR2, SIGSTKFLT, SIGPWR

QEMU uses SIGBUS and SIGUSR1 ("SIG_IPI"). I'm not sure of the signal
policy for qemu-user-* but you might need to take special precautions.

I don't think installing signal handlers from an
__attribute__((constructor)) function is a viable approach since there
is no control over the ordering. If other object files do the same then
whose signal handler ends up being installed?

It may be cleaner to have a separate function called
recorder_setup_signals() that the programs can call when they install
signal handlers. That way the recorder signal handlers are installed
along with all the other signal handlers at program startup instead of
being installed from a constructor function that is hard to find.

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8n6bsACgkQnKSrs4Gr
c8gE3wf6AkzkpR8aUoNk0LdAxtqcK4PyUea67iXIwA69OMtIhM+GUEcZ1iGsndWl
aJHm5KRuenP4qhY9ui9IcbHY99mjVjxUejJHvjrxQSaLowvcxo8NUKGsPMmHnCF5
sx6G0rv6tLNhqIW7CRjYtR4nOWKLRo1FhX5/e+fHKk1K9E80AF1ORNBJyHa7GRZy
ZoSa6MWqSEBovqoDrj3f34iqWC27aC6TUljJpSb4N3U65b39N8QqNvIAZOOXaJOd
pu7WC8KPlORrKNVLbO7Nowq86HrY14DlP8pBNosSN2/nETMxbmhz2kpDGh4L8BgQ
41WxVCch3K3TAaNAPzDakWf6CaD7/g==
=6UkC
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--


