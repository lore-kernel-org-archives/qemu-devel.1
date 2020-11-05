Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8BC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2713922203
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J149agkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2713922203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kags5-0007ul-3B
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kagrL-00074i-6u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kagrF-0001QT-A5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604588843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5n4HmvUrb0nZvEFW+GeMdEHDZWEKh9JRjzXxw54Ifk=;
 b=J149agkPLVeamM0n3Lg2K2osxzumzn3/A2ckyDAW/B+mplBv7iPhkfG+6r+QCSkcxMFp29
 olGBCKWlFGeQJQd/PjYfBS0r4jaoP/hPGJFPh6pA89B6kbQpyYIcCtCzMy8nQKGF4fnchg
 kSpGFBhQ+4S7VmNQcB3yMsWDopRMOnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-0zgZkziIOWWuwXZlFwdLqg-1; Thu, 05 Nov 2020 10:07:19 -0500
X-MC-Unique: 0zgZkziIOWWuwXZlFwdLqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFA0C1006CA2;
 Thu,  5 Nov 2020 15:07:17 +0000 (UTC)
Received: from redhat.com (ovpn-115-13.ams2.redhat.com [10.36.115.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C06E6198D;
 Thu,  5 Nov 2020 15:07:16 +0000 (UTC)
Date: Thu, 5 Nov 2020 15:07:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2] vl: pause option
Message-ID: <20201105150712.GO630142@redhat.com>
References: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
 <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
 <87imakby2n.fsf@linaro.org>
 <db5462f0-f96f-2498-3aa3-ec322462ba22@oracle.com>
MIME-Version: 1.0
In-Reply-To: <db5462f0-f96f-2498-3aa3-ec322462ba22@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 09:55:21AM -0500, Steven Sistare wrote:
> On 11/4/2020 4:40 PM, Alex Bennée wrote:
> > Eric Blake <eblake@redhat.com> writes:
> >> On 11/2/20 9:50 AM, Steve Sistare wrote:
> >>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
> >>> variable to pause QEMU during process startup using SIGSTOP and allow a
> >>> developer to attach a debugger, or observe the process using tools such as
> >>> strace.  Useful when the QEMU has been launched with some other entity, such
> >>> as libvirt.  QEMU_PAUSE is checked in a constructor at the highest priority,
> >>> and can be used to debug other constructors.  The -pause option is checked
> >>> later, during argument processing in main, but is useful if passing an
> >>> environment variable from a launcher to qemu is awkard.
> >>>
> >>> Usage: qemu -pause, or QEMU_PAUSE=1
> >>> After attaching a debugger, send SIGCONT to the qemu process to continue.
> >>
> >> Changing behavior via a new environment variable is awkward.  What
> >> happens, for example, if libvirt inherits this variable set, but is not
> >> aware of its impact to alter how qemu starts up?  Can we get by with
> >> ONLY a command line option?
> >>
> >> Also, how does this option differ from what we already have with qemu
> >> --preconfig?
> > 
> > In the original discussion:
> > 
> >   Subject: [PATCH V1 12/32] vl: pause option
> >   Date: Thu, 30 Jul 2020 08:14:16 -0700
> >   Message-Id: <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
> > 
> > it seems the idea was to stop qemu as early as possible for debugging
> > when launched by some other launcher which wasn't modifiable except by
> > pass through configuration to QEMU's command line.
> > 
> > <snip>
> > 
> >> Isn't it always possible to provide a wrapper qemu process to be invoked
> >> by whatever third-party management app (like libvirt), where your
> >> wrapper then starts the real qemu under gdb to begin with, rather than
> >> having to hack qemu itself to have a special start-up mode?
> > 
> > I agree - this feels like a bit of an over complication as a debug
> > helper. How many times can a failure to launch by some binary blob not
> > be debugged by either a gdb follow-fork or a copying of the command line
> > and running gdb --args?
> 
> Follow fork is awkward and error prone when the launcher performs many forks before forking
> qemu. gdb --args does not work when the launcher sets up an environment for qemu to run
> in, pre-opening fd's being just one example.  For developers, often the "launcher" is a 
> script that performs setup and passes the myriad qemu options.  Even in that case, it is
> easier to add a flag or set an env var to enable debugging. The pause option is fast 
> (for the user) and reliable.

What is your launcher ?  Are you using libvirt, or something else ?

If the goal is simply to make it easy to attach GDB right at the start of
QEMU execution, then could this feature be supported by the launcher itself
in an easier way.

eg, immediately before the execve(qemu, ....) syscall, the launcher can
simply send SIGSTOP to itself.  You can now fire up GDB, attach to it,
and be able to watch execution from the very momement of execve(),
which is even earlier than this patch allows for, and still avoids the
need to follow across forks. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


