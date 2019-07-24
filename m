Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 18:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7CC217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7CC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqLnn-0001FI-O9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 14:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hqLnc-0000r6-4E
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 14:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hqLna-0006Ij-Ta
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 14:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hqLna-0006Fe-Fe
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 14:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5302300D1C2;
 Wed, 24 Jul 2019 18:15:32 +0000 (UTC)
Received: from localhost (ovpn-116-19.gru2.redhat.com [10.97.116.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D400866606;
 Wed, 24 Jul 2019 18:15:30 +0000 (UTC)
Date: Wed, 24 Jul 2019 15:15:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190724181528.GA8322@habkost.net>
References: <20190716145121.19578-1-tao3.xu@intel.com>
 <20190716145121.19578-3-tao3.xu@intel.com>
 <20190723165641.55930926@redhat.com>
 <20190723152357.GI11469@habkost.net>
 <20190724162721.736f7efe@Igors-MacBook-Pro>
 <20190724150241.GM11469@habkost.net>
 <20190724174811.545b4598@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724174811.545b4598@Igors-MacBook-Pro>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 24 Jul 2019 18:15:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 02/11] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Cc: jingqi.liu@intel.com, Tao Xu <tao3.xu@intel.com>, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 05:48:11PM +0200, Igor Mammedov wrote:
> On Wed, 24 Jul 2019 12:02:41 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jul 24, 2019 at 04:27:21PM +0200, Igor Mammedov wrote:
> > > On Tue, 23 Jul 2019 12:23:57 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > 
> > > > On Tue, Jul 23, 2019 at 04:56:41PM +0200, Igor Mammedov wrote:
> > > > > On Tue, 16 Jul 2019 22:51:12 +0800
> > > > > Tao Xu <tao3.xu@intel.com> wrote:
> > > > > 
> > > > > > Add struct NumaState in MachineState and move existing numa global
> > > > > > nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
> > > > > > numa_support into MachineClass to decide which submachines support NUMA.
> > > > > > 
> > > > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > > > > > ---
> > > > > > 
> > > > > > No changes in v7.
> > > > > > 
> > > > > > Changes in v6:
> > > > > >     - Rebase to upstream, move globals in arm/sbsa-ref and use
> > > > > >       numa_mem_supported
> > > > > >     - When used once or twice in the function, use
> > > > > >       ms->numa_state->num_nodes directly
> > > > > >     - Correct some mistakes
> > > > > >     - Use once monitor_printf in hmp_info_numa
> > > > > > ---
> > > > [...]
> > > > > >      if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
> > > > > > -        pxb->numa_node >= nb_numa_nodes) {
> > > > > > +        pxb->numa_node >= ms->numa_state->num_nodes) {
> > > > > this will crash if user tries to use device on machine that doesn't support numa
> > > > > check that numa_state is not NULL before dereferencing 
> > > > 
> > > > That's exactly why the machine_num_numa_nodes() was created in
> > > > v5, but then you asked for its removal.
> > > V4 to more precise.
> > > I dislike small wrappers because they usually doesn't simplify code and make it more obscure,
> > > forcing to jump around to see what's really going on.
> > > Like it's implemented in this patch it's obvious what's wrong right away.
> > > 
> > > In that particular case machine_num_numa_nodes() was also misused since only a handful
> > > of places (6) really need NULL check while majority (48) can directly access ms->numa_state->num_nodes.
> > > without NULL check.
> > 
> > I strongly disagree, here.  Avoiding a ms->numa_state==NULL check
> > is pointless optimization,
> I see it not as optimization (compiler probably would manage to optimize out most of them)
> but as rather properly self documented code. Doing check in places where it's
> not needed is confusing at best and can mask/introduce later subtle bugs at worst.
> 
> > and leads to hard to spot bugs like
> > the one you saw above.
> That one was actually easy to spot because of the way it's written in this patch.

When somebody is looking at a line of code containing
"ms->numa_state->num_nodes", how exactly are they supposed to
know if ms->numa_state is already guaranteed to be non-NULL, or
not?

-- 
Eduardo

