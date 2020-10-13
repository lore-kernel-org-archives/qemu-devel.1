Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B68C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717ED20725
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeA+Ja8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717ED20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGqj-00073T-GD
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSGpQ-0006YR-L9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSGpO-0005e1-GL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602582160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pHpfBvRnvdxcVWrRN1r6b7nQxNMLOyCYwg8NtxvOlWY=;
 b=aeA+Ja8zFHYes4EyRLwC5zFC5cctOE0HF1PnevIOvYWyATQYWlcK6hhk0HBR13Wl9NOLAY
 aung+5BvZUcamFCcIXRz3RmKGSIIfb1StZDATH8/uVeBY6SCBp4lUWyEZPx9Xnxt3FyJ/Y
 wKD4dlC0NKSKPZK3vycfcde34DCRMwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-NAtXICkzPc2SrZq4q_-oGw-1; Tue, 13 Oct 2020 05:42:39 -0400
X-MC-Unique: NAtXICkzPc2SrZq4q_-oGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2BF9802B60;
 Tue, 13 Oct 2020 09:42:36 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22CEB6EF41;
 Tue, 13 Oct 2020 09:42:18 +0000 (UTC)
Date: Tue, 13 Oct 2020 10:42:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20201013094216.GF70612@redhat.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
 <20200930142408.GA320669@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200930142408.GA320669@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 03:24:08PM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
> > > On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > 
> > > On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
> > >>> It should be accompanied by a test in tests/. PCI-level testing APIS for
> > >>> BARs, configuration space, interrupts, etc are available in
> > >>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
> > >>> device backend interact with QEMU's vfio-user-pci implementation.
> > >> 
> > >> We plan to use a libmuser-based backend for testing. This, I suppose, will
> > >> make libmuser a dependency of QEMU (either as a submodule or as a library),
> > >> which for now can be disabled in the default configuration. Is this acceptable?
> > > 
> > > If there are no other dependencies and libmuser supports all host
> > > operating systems that QEMU's -device vfio-user supports, then I think
> > > it's a good idea to use libmuser for at least one in-tree test in QEMU.
> > > 
> > >>> Also please let us know who is working on what so additional people can
> > >>> get involved in areas that need work!
> > >> 
> > >> Swapnil and I will be working on libmuser and the test in QEMU, John and
> > >> the mp-qemu folks will be working on the patches for implementing
> > >> --device vfio-user-pci.
> > > 
> > > Great!
> > > 
> > > John: Will mpqemu use libmuser to implement the remote PCI host
> > > controller?
> > > 
> > 
> > 
> > 	The vfio-user-pci plan is to use libmuser on the server side.
> 
> Okay. Using libmuser in tests seems like a good choice in that case.
> 
> We'll need to figure out the details of how to do it because the
> traditional shared library dependency approach is not well-suited to
> in-development code. It would involve shipping libmuser distro packages
> so QEMU's build system can declare a library dependency (with details
> provided in a pkg-config file).
> 
> Here are approaches that are better for in-development libraries:
> 1. Keep the libmuser code in qemu.git.
> 2. A copy of libmuser in qemu.git with changes being sent upstream
>    (allows more flexibility in case QEMU-specific issues require
>    experimentation).
> 3. Git submodules.
> 
> #1 if you're happy to use the QEMU development process for merging
> libmuser code then it's easiest to officially host the code in qemu.git.
> libmuser gets a subdirectory in the qemu.git tree and you (the
> maintainers) send pull requests. A libmuser library build target
> provides installable static and shared libraries so external
> applications can link against libmuser too. The big advantage here is
> that QEMU can instantly use the latest libmuser code changes.
> 
> #2 works best if the library is a small (just a few source files) with
> no fancy build system requirements.
> 
> #3 is used in QEMU for several other components. Submodules are a pain
> to sync (requires sending a qemu.git patch to move to a new commit ID),
> so this isn't good for a dependency that moves quickly.

I don't think this is actually downside. If anything I think submodules
I think it would actually let libmuser develop faster.

QEMU is such a large project with high volume patches, that changes
take a long time to merge, even when everything is working well.

I think libmuser would have much faster development velocity if
the bit flowing into qemu.git was only as the trivial submodule
hash updates, as opposed to every single libmuser functional patch.

Maintaining libmuser as a standalone git repo avoids need for
libmuser to tie itself to QEMU's release cycle or processes. In
particular it means libmuser could opt to use a modern development
workflow using a GitForge with merge requests, instead of the
legacy email workflow.

Especially if we're considering libmuser to be consumed by non-QEMU
codebases, then long term it almost certainly should be a standalone
project. With this in mind, I think it will be better for libmuser
to start off as a standalone project straight away, so it can build
up its developer community organically, and not have people put off
contributing by the QEMU firehose.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


