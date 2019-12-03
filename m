Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A847C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01288205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01288205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icBD3-0002uR-Sw
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icAjd-0001Pp-JQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icAjU-0007v7-Va
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:09:05 -0500
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:38793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icAjU-0007Xp-Nm
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:09:00 -0500
Received: from player728.ha.ovh.net (unknown [10.109.143.183])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id A9060212EDF
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 17:08:54 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 2BA01CC6EE67;
 Tue,  3 Dec 2019 16:08:46 +0000 (UTC)
Date: Tue, 3 Dec 2019 17:08:44 +0100
From: Greg Kurz <groug@kaod.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191203170844.1defe3f0@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191203131046.GF3078@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <db27af39-62a8-46e5-fccd-f09ed497b7bd@redhat.com>
 <20191203130250.GD3078@work-vm>
 <dce5bc69-b7df-1ff8-39fc-81bb8486c1c5@redhat.com>
 <20191203131046.GF3078@work-vm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9842054036895275314
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.44.50
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
Cc: mszeredi@redhat.com, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=
 " <berrange@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 13:10:46 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 03/12/19 14:02, Dr. David Alan Gilbert wrote:
> > >> It could be in fsdev/virtiofsd,
> > > fsdev is currently all 9p stuff, so that would seem very confusing.
> > 
> > Move it to fsdev/9p?
> 
> Greg: Are you OK with us doing that, and then having fsdev/virtiofsd for
> our side of things?
> 

That's okay with me.

> > >> but I agree with Daniel that at this
> > >> point the QEMU build system introduces baggage that you may not want for
> > >> virtiofsd.
> > >
> > > I've already got it wired up in contrib with qemu's build system
> > > so that doesn't seem to be an issue.   The question is purely a 'where'.
> > 
> > Oh I agree it's not an insurmountable problem.  For a new project I may
> > not want to deal with the complicated rules.mak stuff; however, if
> > virtiofsd doesn't have to do anything complicated then it's your choice.
> 
> Fortunately we don't seem to have touched that.
> 
> Dave
> 
> > Paolo
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


