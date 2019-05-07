Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BF2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D6A20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2G8-0002MK-3o
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:44:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hO2F0-0001lM-AV
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hO2Ez-0002wk-6z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:42:50 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:46115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hO2Ez-0002vb-0p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:42:49 -0400
Received: from player738.ha.ovh.net (unknown [10.108.57.49])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 81360124FF9
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 17:42:46 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
	(Authenticated sender: groug@kaod.org)
	by player738.ha.ovh.net (Postfix) with ESMTPSA id 602965A14343;
	Tue,  7 May 2019 15:42:41 +0000 (UTC)
Date: Tue, 7 May 2019 17:42:39 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507174239.59ad26d1@bahia.lan>
In-Reply-To: <3336211.WybC1Bzqah@silver>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1895198.u98Sn5qOsY@silver> <20190507115556.3d578690@bahia.lan>
	<3336211.WybC1Bzqah@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12066832252380485952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.76
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 07 May 2019 14:23:11 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 7. Mai 2019 11:55:56 CEST Greg Kurz wrote:
> > > support the 'vii' feature of patch 5, which introduces the XML config  
> > 
> > What is patch 5 ?!? What is 'vii' ? I am a bit lost here...  
> 
> Hi Greg,
> 
> Sorry that I caused a bit of confusion, You were actually commenting mostly on 
> v2 of the patch set, where my email client replaced the message IDs and hence 
> screwed threading.
> 
> This is v3 that I sent yesterday and which has correct threading:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01143.html
> 

For a reason yet to be investigated, I haven't received it yet...

> Please just have a glimpse on that v3 thread, and before I address the details 
> that you requested (I have reviewed them all already and will address them), I 
> would like you to ask you for a coarse feedback on design/features first. 
> Because there are some things where I am unresolved on design level yet:
> 

I'll try but probably not before next week.

> 1. Should I drop the "persistency" feature of patch 3 (same inode numbers 
> after reboots/suspends)  completely from the patch set? It is disabled at 
> compile time by default for now after entire v3 patch set is applied. Or 
> should that persistency feature probably become a qemu command line option 
> instead?
> 
> 2. If persistency feature should be preserved, shall I probably move out all 
> the inode remapping code into a separate C unit to avoid 9p.c getting bloated 
> too much (the amount of code for saving/loading the qp*_table hash tables is 
> quite large). If yes, any suggestion for an appropriate unit name?
> 
> 3. Are you fine with the suggested variable length suffixes (patch 4) becoming 
> the default behaviour (instead of the fixed length 16 bit prefix solution by 
> Antonios)?
> 
> 4. Do you have a better idea for a name instead of the suggested "vii" (patch 
> 5) virtfs qemu command line option? And are you fine with the idea of that 
> "vii" feature anyway?
> 
> > > This is the counter part patch against latest libvirt git master head to  
> > 
> > Hmm... shouldn't this be Cc'd to libvir-list@redhat.com as well then ?  
> 
> Well, for now I just provided that libvirt patch to give you an idea about how 
> imagined this "vii" feature to be used. Does it make sense to CC them already 
> even though this suggested "vii" command line option does not exist on qemu 
> side yet?
> 
> I know I piled up quite a bit of code on this patch set, so to speed up things 
> simply raise questions instead of spending too much time in reviewing 
> everything in detail already.
> 
> Thanks Greg!
> 
> Best regards,
> Christian Schoenebeck


