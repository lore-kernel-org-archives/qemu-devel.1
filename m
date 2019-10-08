Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD156ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EEC206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EEC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlzr-0006dj-Ii
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHlyt-0005qT-CJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHlyr-00053I-FQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:40:35 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:48647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHlyr-00052D-6L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:40:33 -0400
Received: from player699.ha.ovh.net (unknown [10.108.42.102])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id EB7B8207FA0
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:40:30 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 4C3A3AB07787;
 Tue,  8 Oct 2019 09:39:34 +0000 (UTC)
Date: Tue, 8 Oct 2019 11:39:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
Message-ID: <20191008113932.18eb4c1d@bahia.lan>
In-Reply-To: <a449a64d-ca3c-2442-27b3-70b565545a36@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <87eeznn185.fsf@dusky.pond.sub.org>
 <a449a64d-ca3c-2442-27b3-70b565545a36@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6452813842595354963
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheelgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.176
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 08:41:08 +0000
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 08.10.2019 10:30, Markus Armbruster wrote:
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> > 
> >> Hi all!
> >>
> >> Here is a proposal of auto propagation for local_err, to not call
> >> error_propagate on every exit point, when we deal with local_err.
> >>
> >> There are also two issues with errp:
> >>
> >> 1. error_fatal & error_append_hint/error_prepend: user can't see this
> >> additional info, because exit() happens in error_setg earlier than info
> >> is added. [Reported by Greg Kurz]
> > 
> > How is this series related to Greg's "[PATCH 00/17] Fix usage of
> > error_append_hint()"?  Do we need both?
> 
> These series is a substitution for Greg's. Still, there are problems with
> automation, which Greg pointed in 21/31, and I don't know what to do next.
> 
> May be, just continue to review patches and fix them by hand. May be try to
> improve automation...
> 

The feeling I have after working on my series is that the lines that deal
with errors are mixed up with the functional code in a variety of ways.
That makes it very difficult if not impossible to come with code patterns
suitable for a 100% automated solution IMHO.

My questioning is more around the semantics of error_fatal actually. What
does passing &error_fatal gives us over passing &local_err and calling
error_report_err()+exit(), apart from breaking error_append_hint() and
error_prepend() ?

> > 
> >> 2. error_abort & error_propagate: when we wrap
> >> error_abort by local_err+error_propagate, resulting coredump will
> >> refer to error_propagate and not to the place where error happened.
> >> (the macro itself don't fix the issue, but it allows to [3.] drop all
> >> local_err+error_propagate pattern, which will definitely fix the issue)
> >> [Reported by Kevin Wolf]
> >>
> >> Still, applying new macro to all errp-functions is a huge task, which is
> >> impossible to solve in one series.
> >>
> >> So, here is a minimum: solve only [1.], by adding new macro to all
> >> errp-functions which wants to call error_append_hint.
> >>
> >> v4;
> >> 02: - check errp to be not NULL
> >>      - drop Eric's r-b
> >> 03: add Eric's r-b
> >> 04: - rename macro to ERRP_AUTO_PROPAGATE [Kevin]
> >>      - improve comment and commit msg, mention
> >>        error_prepend
> >> 05: - handle error_prepend too
> >>      - use new macro name
> >>      - drop empty line at the end
> >>
> >> commit message for auto-generated commits updated,
> >> commits regenerated.
> >>
> >> I'll use cc-cmd to cc appropriate recipients per patch, still
> >> cover-letter together with 04-06 patches should be interesting for
> >> all:
> > [...]
> > 
> > Big series; let me guess its structure.
> > 
> >> Vladimir Sementsov-Ogievskiy (31):
> >>    errp: rename errp to errp_in where it is IN-argument
> >>    hw/core/loader-fit: fix freeing errp in fit_load_fdt
> >>    net/net: fix local variable shadowing in net_client_init
> > 
> > Preparations.
> > 
> >>    error: auto propagated local_err
> > 
> > The new idea.
> > 
> >>    scripts: add script to fix error_append_hint/error_prepend usage
> >>    python: add commit-per-subsystem.py
> > 
> > Scripts to help you apply it.
> > 
> >>    s390: Fix error_append_hint/error_prepend usage
> >>    ARM TCG CPUs: Fix error_append_hint/error_prepend usage
> >>    PowerPC TCG CPUs: Fix error_append_hint/error_prepend usage
> >>    arm: Fix error_append_hint/error_prepend usage
> >>    SmartFusion2: Fix error_append_hint/error_prepend usage
> >>    ASPEED BMCs: Fix error_append_hint/error_prepend usage
> >>    Boston: Fix error_append_hint/error_prepend usage
> >>    PowerNV (Non-Virtualized): Fix error_append_hint/error_prepend usage
> >>    PCI: Fix error_append_hint/error_prepend usage
> >>    SCSI: Fix error_append_hint/error_prepend usage
> >>    USB: Fix error_append_hint/error_prepend usage
> >>    VFIO: Fix error_append_hint/error_prepend usage
> >>    vhost: Fix error_append_hint/error_prepend usage
> >>    virtio: Fix error_append_hint/error_prepend usage
> >>    virtio-9p: Fix error_append_hint/error_prepend usage
> >>    XIVE: Fix error_append_hint/error_prepend usage
> >>    block: Fix error_append_hint/error_prepend usage
> >>    chardev: Fix error_append_hint/error_prepend usage
> >>    cmdline: Fix error_append_hint/error_prepend usage
> >>    QOM: Fix error_append_hint/error_prepend usage
> >>    Migration: Fix error_append_hint/error_prepend usage
> >>    Sockets: Fix error_append_hint/error_prepend usage
> >>    nbd: Fix error_append_hint/error_prepend usage
> >>    PVRDMA: Fix error_append_hint/error_prepend usage
> >>    ivshmem: Fix error_append_hint/error_prepend usage
> > 
> > Applying it.
> > 
> > Correct?
> > 
> 
> Yes
> 
> 


