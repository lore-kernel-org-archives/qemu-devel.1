Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4972EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A56221569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A56221569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudx5-0006XM-UC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iubID-0004vk-3D
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iubIB-0003u1-Kt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:09:00 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:35179)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iubIB-0003sx-EB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:08:59 -0500
Received: from player711.ha.ovh.net (unknown [10.108.16.166])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2F89212E08D
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:08:56 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 8D17CE6B7655;
 Thu, 23 Jan 2020 12:08:55 +0000 (UTC)
Date: Thu, 23 Jan 2020 13:08:53 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 07/11] tests/virtio-9p: failing splitted readdir test
Message-ID: <20200123130853.736d507b@bahia.lan>
In-Reply-To: <23580535.7v2ZZEAp5V@silver>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <4dc3706db1f033d922e54af8c74a81211de8b79f.1579567020.git.qemu_oss@crudebyte.com>
 <20200122235954.1305faab@bahia.lan> <23580535.7v2ZZEAp5V@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10148861760805706048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.148
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 12:36:12 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 22. Januar 2020 23:59:54 CET Greg Kurz wrote:
> > On Tue, 21 Jan 2020 01:17:35 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > This patch is not intended to be merged. It resembles
> > > an issue (with debug messages) where the splitted
> > > readdir test fails because server is interrupted with
> > > transport error "Failed to decode VirtFS request type 40",
> > 
> > Ok. When we send a new request, we call:
> > 
> > uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
> >                         uint32_t len, bool write, bool next)
> > {
> >     uint16_t flags = 0;
> >     vq->num_free--;
> > 
> > [...]
> > 
> >     return vq->free_head++; /* Return and increase, in this order */
> > }
> 
> Ah, I see!
> 
> > where vq->num_free is the number of available buffers (aka. requests) in
> > the vq and vq->free_head the index of the next available buffer. The size
> > of the vq of the virtio-9p device is MAX_REQ (128) buffers. The driver
> > is very simple and doesn't care to handle the scenario of a full vq,
> > ie, num_free == 0 and free_head is past the vq->desc[] array. It seems
> > that count=128 generates enough extra requests to reach the end of the
> > vq. Hence the "decode" error you get. Maybe an assert(vq->num_free) in
> > qvirtqueue_add() would make that more clear ?
> 
> So just that I get it right; currently the 9pfs test suite writes to a 
> ringbuffer with every request (decreasing the free space in the ringbuffer), 
> but it never frees up that space in the ringbuffer?
> 

Correct.

> > Not sure it is worth to address this limitation though. Especially since
> > count=128 isn't really a recommended choice in the first place. 
> 
> Well, if that's what happens with the ringbuffer, it would need to be 
> addressed somehow anyway, otherwise it would be impossible to add more 9pfs 
> tests, since they would hit the ringbuffer limit as well at a certain point, 
> no matter how simple the requests are.
> 

This just means that a single test shouldn't generate more than
128 requests. I guess this is enough for a variety of tests.

> Wouldn't it make sense to reset the ringbuffer after every succesful, 
> individual 9pfs test?
> 

This is the case, hence my suggestion to pass count to fs_readdir_split()
instead of the having a vcount[] array.

> > It has
> > more chances to cause a disconnect if the server needs to return a longer
> > file name (which is expected since most fs have 255 character long file
> > names).
> 
> Well, this test is dependent on what's provided exactly by the synth driver 
> anyway. So I don't see the value 128 as a problem here. The readdir/split test 
> could even determine the max. length of a file provided by synth driver if you 
> are concerned about that, because the file name template macro 
> QTEST_V9FS_SYNTH_READDIR_FILE used by synth driver is public.
> 

It would make sense to use this knowledge and come up with
a _good_ default value for 'count'.

> And BTW it is not really this specific 'count' value (128) that triggers this 
> issue, if you just run the readdir/split test with i.e.:
> 
> 	const uint32_t vcount[] = { 128 };
> 
> then you won't trigger this test environment issue.
> 

I mean that I don't really care to check small values because
they're likely never used by real clients, and we already know
what we might get in the end: the server disconnects.

> Best regards,
> Christian Schoenebeck
> 
> 


