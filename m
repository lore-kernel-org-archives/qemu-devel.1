Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B9C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF0C2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF0C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFziH-00031R-5v
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:23:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFzhN-0002dR-Jf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFzhM-0003mh-Kk
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hFzhM-0003mM-B9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FE3A86663
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:22:51 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B72BC5C21A;
	Mon, 15 Apr 2019 11:22:50 +0000 (UTC)
Date: Mon, 15 Apr 2019 12:22:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190415112247.GH2852@work-vm>
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
	<f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
	<c348ffd5-a044-bc12-d1a7-50b7ab543045@redhat.com>
	<55adf1ce-7f21-bff0-c75a-2b7abd2b110e@redhat.com>
	<1892546178.13440598.1555144001543.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1892546178.13440598.1555144001543.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 15 Apr 2019 11:22:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] R: Re: [PATCH v2] target/i386: kvm: add VMX
 migration blocker
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415112248.8efRPwpAtfYWRRL2Gse6Hgiwa2_fE_Ko2K5azaC1K-4@z>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> ----- Cole Robinson <crobinso@redhat.com> ha scritto:
> > On 4/12/19 3:47 AM, Paolo Bonzini wrote:
> > > On 10/04/19 20:26, Cole Robinson wrote:
> > >> On 11/20/18 6:44 AM, Dr. David Alan Gilbert wrote:
> > >>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > >>>> Nested VMX does not support live migration yet.  Add a blocker
> > >>>> until that is worked out.
> > >>>>
> > >>>> Nested SVM only does not support it, but unfortunately it is
> > >>>> enabled by default for -cpu host so we cannot really disable it.
> > >>>>
> > >>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >>>
> > >>> So I'm OK with this, but it does need a release note warning whenever it
> > >>> goes in, because it'll surprise those who've already enabled nesting
> > >>> but don't use it on all their VMs.
> > >>>
> > >>
> > >> We are hitting this in Fedora 30. Now that nested VMX is enabled by
> > >> default at the kernel level, and virt-manager/boxes will use the
> > >> equivalent of -cpu host by default, libvirt managedsave (migrate to
> > >> file) and virt-manager snapshots (savevm) are rejected for default
> > >> created VMs on intel. That's quite unfortunate.
> > >>
> > >> Any ideas on how to resolve this?
> > > 
> > > I think the simplest solution is just to finish implementation of nested
> > > VMX live migration and backport it to Fedora 30.
> > > 
> > 
> > That would simplify things :) Any guess on the timeframe? This is kernel
> > work I presume?
> 
> No, the kernel part is already in. As a contingency plan, you could just revert this QEMU patch.

With a new-enough kernel, how hard is it to detect that this actual
migration is safe?

Dave

> Paolo
> 
> > 
> > If changes aren't landing in the near term I think we should disable
> > nested VMX by default in Fedora, maybe just with modules.d/kvm.conf
> > override. (Or revert this patch downstream, but I presume that's not a
> > good idea).
> > 
> > The alternative of just letting it sit is going to generate a lot of
> > complaints I suspect. And the only solutions will be 1) disable nested
> > VMx for your whole machine and reboot, or 2) run this virt-xml command
> > to disable VMX in your domain config... and probably forget that it's
> > there and then a year later when this is all sorted out file a bug
> > asking why nested virt isn't working for this one VM ;)
> > 
> > I guess #2 might not be avoidable anyways for the amount of people that
> > have already opted into nested VMX
> > 
> > Thanks,
> > Cole
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

