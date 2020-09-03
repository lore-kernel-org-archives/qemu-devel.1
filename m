Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116FC206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116FC206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDley-0008B6-3I
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDleL-0007jv-2Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:35:21 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:53043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDleI-0001BC-Pi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:35:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.221])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 953385D7C84E;
 Thu,  3 Sep 2020 11:35:15 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 3 Sep 2020
 11:35:15 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002e49744b8-a294-4ba5-a0c6-c2caeed1f9e2,
 FF22E3E2F99647A0705B7EB067E934078DCBDF97) smtp.auth=groug@kaod.org
Date: Thu, 3 Sep 2020 11:35:14 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Message-ID: <20200903113514.7a0a6ac8@bahia.lan>
In-Reply-To: <25793713.39nqsFcaVY@silver>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com> <2877776.MzA8b4DPAS@silver>
 <20200902185422.16b4ee28@bahia.lan> <25793713.39nqsFcaVY@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 8e769b1e-d79d-4248-b681-90404f8c78ea
X-Ovh-Tracer-Id: 13317988525710023133
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegleevgeeiveevhedvveevveefhfeiffdvhefhffevteeuleduffdtveevteegffenucffohhmrghinhepqhgvmhhurdhorhhgpdhorghsihhsqdhophgvnhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegsvghrrhgrnhhgvgesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 05:35:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 03 Sep 2020 10:20:40 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 2. September 2020 18:54:22 CEST Greg Kurz wrote:
> > > Well, I can do that of course. But somehow I fear users get lost by just
> > > pointing them to "man 1 qemu" in the log message. It already starts that
> > > e.g. on Debian there is no "man qemu", it is "man qemu-system" there
> > > instead. Next issue is that qemu man page is currently not structured in
> > > a way that would> 
> > > allow me to directly point them to the relevant man heading like:
> > > 	man --pager='less -p ^9P-msize' qemu
> > > 
> > > So they would need to scroll their way through the entire man page by
> > > themselfes and find confusing sections like "-fsdev -device virtio-9p-pci"
> > > vs. "-virtfs", etc. I can imagine some people will struggle with that.
> > > 
> > > With a link like "https://wiki.qemu.org/Documentation/9psetup#msize" the
> > > thing would be crystal clear within seconds.
> > > 
> > > Just my opinion. Greg?
> > 
> > Fine by me for this patch.
> > 
> > For a longer term, maybe we should find a way to advertise some hint
> > for msize to the guest... Not sure how to do that though.
> 
> On the long term that would be possible, however only with a protocol change 
> allowing server to send minimum, maximum and recommended msize to client.
> 

Hmm... not sure adding a new 9P protocol version for this is the
way to go. Not speaking of all the hustle this would cause, these
msizes rather look like properties of the device that the guest
can use to configure the 9P session.

What about adding them to the virtio-9p device config along with
the mount 'tag' and teach trans_virtio.c in linux to expose them
as well in the sysfs entry of the device ?

This could also be the occasion to describe virtio-9p in the virtio
spec [1]. Something that has been sitting on my TODO list for years
but I could never find time to consider...

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html

> As you know, right now server only has a say in maximum msize.
> 

I guess you mean minimum size ?

> Best regards,
> Christian Schoenebeck
> 
> 


