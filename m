Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85397C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F6425596
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6425596
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwov-0007uW-Eh
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jpwoJ-0007NN-G1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:39:11 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:42169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jpwoG-0007Om-O0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:39:11 -0400
Received: from player694.ha.ovh.net (unknown [10.108.54.97])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 46A2021B2A3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 18:39:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id A488613C94AD9;
 Mon, 29 Jun 2020 16:39:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006016bf635-ca8a-4113-842c-b5b4a0762dee,8FB0D1E3D32E665923302A74B02F2B8B7D335768)
 smtp.auth=groug@kaod.org
Date: Mon, 29 Jun 2020 18:39:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Message-ID: <20200629183902.75d6fb0b@bahia.lan>
In-Reply-To: <3959658.0YslYoXCm0@silver>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <14ec5d880cfca878bf32e643243c7ab3f4a52440.1587309014.git.qemu_oss@crudebyte.com>
 <3959658.0YslYoXCm0@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1812980325064284480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudelledgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.177.69; envelope-from=groug@kaod.org;
 helo=6.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 12:39:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 03 Jun 2020 19:16:08 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Sonntag, 19. April 2020 17:06:17 CEST Christian Schoenebeck wrote:
> > Make top half really top half and bottom half really bottom half:
> > 
> > Each T_readdir request handling is hopping between threads (main
> > I/O thread and background I/O driver threads) several times for
> > every individual directory entry, which sums up to huge latencies
> > for handling just a single T_readdir request.
> > 
> > Instead of doing that, collect now all required directory entries
> > (including all potentially required stat buffers for each entry) in
> > one rush on a background I/O thread from fs driver by calling the
> > previously added function v9fs_co_readdir_many() instead of
> > v9fs_co_readdir(), then assemble the entire resulting network
> > response message for the readdir request on main I/O thread. The
> > fs driver is still aborting the directory entry retrieval loop
> > (on the background I/O thread inside of v9fs_co_readdir_many())
> > as soon as it would exceed the client's requested maximum R_readdir
> > response size. So this will not introduce a performance penalty on
> > another end.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c | 122 +++++++++++++++++++++++----------------------------
> >  1 file changed, 55 insertions(+), 67 deletions(-)
> 
> Ping. Anybody?
> 
> I would like to roll out this patch set soon and this is the only patch in 
> this series missing a review yet.
> 

Hi Christian,

Sorry for getting back to this only now :-\

So I still have some concerns about the locking of the directory stream
pointer a fid. It was initially introduced to avoid concurrent accesses
by multiple threads to the corresponding internal glibc object, as
recommended in the readdir(3) manual page. Now, this patch considerably
extends the critical section to also contain calls to telldir() and all
the _many_ readdir()... so I'm not sure exactly what's the purpose of
that mutex right now. Please provide more details.

Cheers,

--
Greg

