Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E214C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7264D22DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7264D22DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BNB-0001EP-I4
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i0BLJ-0008LV-TJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i0BLI-00081u-03
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i0BLG-00080V-44
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 677608372EE;
 Tue, 20 Aug 2019 21:06:57 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A48360BF3;
 Tue, 20 Aug 2019 21:06:54 +0000 (UTC)
Date: Tue, 20 Aug 2019 18:06:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Yash Mankad <ymankad@redhat.com>
Message-ID: <20190820210652.GL3908@habkost.net>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <87pnl5sks3.fsf@dusky.pond.sub.org>
 <20190816074932.GK13569@beluga.usersys.redhat.com>
 <87h86hpae5.fsf@dusky.pond.sub.org>
 <20190816174241.GE3908@habkost.net>
 <75655410-9af9-e463-9471-675299929bde@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75655410-9af9-e463-9471-675299929bde@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 20 Aug 2019 21:06:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Erik Skultety <eskultet@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>,
 "Danilo C. L. de Paula" <ddepaula@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 05:07:10PM -0400, Yash Mankad wrote:
> On 8/16/19 1:42 PM, Eduardo Habkost wrote:
> > On Fri, Aug 16, 2019 at 02:22:58PM +0200, Markus Armbruster wrote:
> >> Erik Skultety <eskultet@redhat.com> writes:
> >>
> >>> On Fri, Aug 16, 2019 at 08:10:20AM +0200, Markus Armbruster wrote:
> >>>> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>>>
> >>>>> We have this issue reported when using libvirt to hotplug CPUs:
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> >>>>>
> >>>>> Basically, libvirt is not copying die-id from
> >>>>> query-hotpluggable-cpus, but die-id is now mandatory.
> >>>> Uh-oh, "is now mandatory": making an optional property mandatory is an
> >>>> incompatible change.  When did we do that?  Commit hash, please.
> >>>>
> >>>> [...]
> >>>>
> >>> I don't even see it as being optional ever - the property wasn't even
> >>> recognized before commit 176d2cda0de introduced it as mandatory.
> >> Compatibility break.
> >>
> >> Commit 176d2cda0de is in v4.1.0.  If I had learned about it a bit
> >> earlier, I would've argued for a last minute fix or a revert.  Now we
> >> have a regression in the release.
> >>
> >> Eduardo, I think this fix should go into v4.1.1.  Please add cc:
> >> qemu-stable.
> > I did it in v2.
> >
> >> How can we best avoid such compatibility breaks to slip in undetected?
> >>
> >> A static checker would be nice.  For vmstate, we have
> >> scripts/vmstate-static-checker.py.  Not sure it's used.
> > I don't think this specific bug would be detected with a static
> > checker.  "die-id is mandatory" is not something that can be
> > extracted by looking at QOM data structures.  The new rule was
> > being enforced by the hotplug handler callbacks, and the hotplug
> > handler call tree is a bit complex (too complex for my taste, but
> > I digress).
> >
> > We could have detected this with a simple CPU hotplug automated
> > test case, though.  Or with a very simple -device test case like
> > the one I have submitted with this patch.
> >
> > This was detected by libvirt automated test cases.  It would be
> > nice if this was run during the -rc stage and not only after the
> > 4.1.0 release, though.
> >
> > I don't know details of the test job.  Danilo, Mirek, Yash: do
> > you know how this bug was detected, and what we could do to run
> > the same test jobs in upstream QEMU release candidates?
> 
> This bug was caught by our internal gating tests.
> 
> The libvirt gating tests for the virt module include the
> following Avocado-VT test case:
> 
> libvirt_vcpu_plug_unplug.positive_test.vcpu_set.live.vm_operate.save
> 
> This job failed with the error that you can see in the description
> of the BZ#1741451 [0].
> 
> If you think that this would have been caught by a simple hotplug
> case, I'd recommend adding a test for hotplug to avocado_qemu.
> Otherwise, if you want, I can look into adding this particular
> libvirt test case to our QEMU CI efforts.

Having a hotplug test case using avocado_qemu would help catch
some bugs, but it's not enough if we want to catch integration
issues between QEMU and libvirt (like this one).

I wouldn't focus just on that particular libvirt test case.
I suggest we run a reasonably large set of libvirt test cases
against QEMU release candidates as soon as they are tagged.

> 
> Thanks,
> Yash
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1741451#c0
> 

-- 
Eduardo

