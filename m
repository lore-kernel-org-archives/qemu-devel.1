Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD26C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B5A205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRxN9nGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B5A205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWHs-0006pY-CW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZWFa-0004Sy-GI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:03:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZWFZ-0001Cu-EN
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFdE3NW/UVZsHqsQ67wnQMNSVLq5hvhJNrMSOWcHbd8=;
 b=XRxN9nGxSW3ovzrN27hEP35j8pXrKUm9pkLd9sunQhf4pzhtlEl7J+gLPwKSgaSzAeL5CU
 0V4bjthODnQVS1k/MUMlUEJeLr7QfC0seIUA3O+jBmXAcPgNh29iWX/eBVzzMFBLrrwKiQ
 gNazqEvjm+9BjY07P+GZ2yb6F9fj8nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420--_T4RK79MCyxtbpNI4xOyA-1; Fri, 15 May 2020 05:03:19 -0400
X-MC-Unique: -_T4RK79MCyxtbpNI4xOyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3C158018A2;
 Fri, 15 May 2020 09:03:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B95591059115;
 Fri, 15 May 2020 09:03:13 +0000 (UTC)
Date: Fri, 15 May 2020 11:03:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v10 14/14] iotests: use python logging for iotests.log()
Message-ID: <20200515090312.GC93011@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-15-jsnow@redhat.com>
 <20200331134446.GF7030@linux.fritz.box>
 <1a38728b-aa4b-f3e4-c3ad-1a2b8d2e9269@redhat.com>
 <20200514100623.GB5518@linux.fritz.box>
 <e9190eb8-637d-9e79-a1ee-02f783675025@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e9190eb8-637d-9e79-a1ee-02f783675025@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 21:54 hat John Snow geschrieben:
> 
> 
> On 5/14/20 6:06 AM, Kevin Wolf wrote:
> > Am 14.05.2020 um 08:24 hat John Snow geschrieben:
> >> On 3/31/20 9:44 AM, Kevin Wolf wrote:
> >>> Am 31.03.2020 um 02:00 hat John Snow geschrieben:
> >>>> We can turn logging on/off globally instead of per-function.
> >>>>
> >>>> Remove use_log from run_job, and use python logging to turn on
> >>>> diffable output when we run through a script entry point.
> >>>>
> >>>> iotest 245 changes output order due to buffering reasons.
> >>>>
> >>>>
> >>>> An extended note on python logging:
> >>>>
> >>>> A NullHandler is added to `qemu.iotests` to stop output from being
> >>>> generated if this code is used as a library without configuring logging.
> >>>> A NullHandler is only needed at the root, so a duplicate handler is not
> >>>> needed for `qemu.iotests.diff_io`.
> >>>>
> >>>> When logging is not configured, messages at the 'WARNING' levels or
> >>>> above are printed with default settings. The NullHandler stops this from
> >>>> occurring, which is considered good hygiene for code used as a library.
> >>>>
> >>>> See https://docs.python.org/3/howto/logging.html#library-config
> >>>>
> >>>> When logging is actually enabled (always at the behest of an explicit
> >>>> call by a client script), a root logger is implicitly created at the
> >>>> root, which allows messages to propagate upwards and be handled/emitted
> >>>> from the root logger with default settings.
> >>>>
> >>>> When we want iotest logging, we attach a handler to the
> >>>> qemu.iotests.diff_io logger and disable propagation to avoid possible
> >>>> double-printing.
> >>>>
> >>>> For more information on python logging infrastructure, I highly
> >>>> recommend downloading the pip package `logging_tree`, which provides
> >>>> convenient visualizations of the hierarchical logging configuration
> >>>> under different circumstances.
> >>>>
> >>>> See https://pypi.org/project/logging_tree/ for more information.
> >>>>
> >>>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>>
> >>> Should we enable logger if -d is given?
> >>>
> >>> Previously we had:
> >>>
> >>> $ ./check -d -T -raw 281
> >>> [...]
> >>> 281 not run: not suitable for this image format: raw
> >>> 281      not run    [15:39:03] [15:39:04]                    not suitable for this image format: raw
> >>> Not run: 281
> >>>
> >>> After this series, the first line of output from notrun() is missing.
> >>> Not that I think it's important to have the line, but as long as we
> >>> bother to call logger.warning(), I thought that maybe we want to be able
> >>> to actually see the effect of it somehwere?
> >>>
> >>> Kevin
> >>>
> >>
> >> Uh, okay. So this is weirder than I thought it was going to be!
> >>
> >> So, if you move the debug configuration up above the _verify calls,
> >> you'll see the message printed out to the debug stream:
> >>
> >> DEBUG:qemu.iotests:iotests debugging messages active
> >> WARNING:qemu.iotests:281 not run: not suitable for this image format: raw
> >>
> >> ...but if you omit the `-d` flag, the message vanishes into a black
> >> hole. Did it always work like that ...?
> > 
> > Yes, this is how it used to work. It's a result of ./check only printing
> > the test output with -d, and such log messages are basically just test
> > output.
> > 
> > And I think it's exactly what we want: Without -d, you want only the
> > summary, i.e. a single line that says "pass", "fail" or "notrun",
> > potentially with a small note at the end of the line, but that's it.
> 
> OK, maybe. So I guess what happens here is that if you don't use -d, the
> output gets redirected to file, and that file is summarily deleted.
> 
> Your phrase "but as long as we bother to call logger.warning(), I
> thought that maybe we want to be able to actually see the effect of it
> somewhere" stuck with me -- I think you're right.

Yes, and I still think the same, but "somewhere" includes -d for me. I
just wouldn't want it to be effectively dead code that doesn't have an
effect no matter what options you use.

> I kind of do expect that if I call a function called warning() that it's
> gonna do some damage. principle of least surprise, etc.
> 
> So two things:
> 
> (1) Maybe the iotest logger ought to always use stderr, and we should
> see any calls to warning() or error() even when debugging is off.

Even stderr is considered test output. This is not an accident, but we
actually want to test that we get error messages. So this wouldn't
change the visible result.

Maybe what we should do is print a small notice "warnings/errors were
logged" at the end of the line like we do for notrun, so you know you
should rerun the test with -d?

But anyway, why would we ever get error() with a test that passes?

> (2) These skip notifications are not warnings, they are informational
> and can be disabled when `-d` is omitted. (Especially because they are
> represented through another channel.)
> 
> (I'll send the fixup for the simpler thing first, and you can take or
> leave the second thing.)

I would be perfectly happy with just a fix that makes the messages
appear again with -d.

Kevin


