Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36E6C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8E121736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8E121736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagdB-0000iM-Vw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iafsC-00028m-VC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iafsA-0004vG-ET
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:59:47 -0500
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:47277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iafsA-0004jj-6Q
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:59:46 -0500
Received: from player756.ha.ovh.net (unknown [10.109.146.53])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5143125208F
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 13:59:43 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 717EEBE2FC49;
 Fri, 29 Nov 2019 12:59:38 +0000 (UTC)
Date: Fri, 29 Nov 2019 13:59:37 +0100
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
Message-ID: <20191129135937.74a9b264@bahia.w3ibm.bluemix.net>
In-Reply-To: <4e49ea13-fe0c-2b06-052e-474d714b88ad@redhat.com>
References: <20191129111632.22840-2-pbonzini@redhat.com>
 <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
 <4e49ea13-fe0c-2b06-052e-474d714b88ad@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1602718519870396878
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeiledggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.96.204
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
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 13:49:20 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/11/19 13:32, Greg Kurz wrote:
> > Nice. :)
> > 
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > 
> > Paolo,
> > 
> > I can take this through my 9p tree if you want. Otherwise,
> > 
> > Acked-by: Greg Kurz <groug@kaod.org>
> 
> Yes, please do it since it's self-contained.  You'd probably also test
> it better than me. :)
> 
> Paolo
> 

Ok I'll just do that then.

Cheers,

--
Greg

