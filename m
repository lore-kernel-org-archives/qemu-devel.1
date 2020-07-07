Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF8CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B7720663
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B7720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspbe-0007GF-S5
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jspZr-0005ko-NE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:32:11 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:37367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jspZp-0008IV-Ik
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:32:11 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.97])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id BDA6E97964
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 17:32:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 4CA331432B347;
 Tue,  7 Jul 2020 15:31:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0035301fe21-5822-4f44-82f1-e2972b61088a,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 17:31:57 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: hw/intc/xics.c:605: ics_realize: Assertion `ics->xics' failed
Message-ID: <20200707173157.79de0c7f@bahia.lan>
In-Reply-To: <20200707161155.16dff2ea@bahia.lan>
References: <104a1848-4686-0b6f-fb0c-e09e2ffbd031@redhat.com>
 <20200707161155.16dff2ea@bahia.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10769795559951931698
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.56.233; envelope-from=groug@kaod.org;
 helo=8.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 11:32:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 16:11:55 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 7 Jul 2020 13:01:54 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > 
> >  Hi Greg,
> > 
> > I just ran  scripts/device-crash-test and it triggered the assert that
> > you've added in commit b015a9809427c8 ("xics: Link ICS_PROP_XICS
> > property to ICSState::xics pointer"):
> > 
> > $ qemu-system-ppc64 -S -M powernv9,accel=tcg -device pnv-psi-POWER8

Ah I hadn't realized you had a PSI device on the command line...

> > qemu-system-ppc64: hw/intc/xics.c:605: ics_realize: Assertion
> > `ics->xics' failed.
> > Aborted (core dumped)
> > 
> > That's ugly. Could you please have a look how this could be done in a
> > nicer way? (Maybe set errp and return in that case?)
> > 

PSI devices are really internal to the chip, they shouldn't be
instantiated from the command line. I'll send a patch to make
them not user creatable.

> >  Thanks,
> >   Thomas
> > 
> 
> Hi Thomas,
> 
> I'll look at that right away. Thanks for the report.
> 
> Cheers,
> 
> --
> Greg


