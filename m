Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF65C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E502C2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E502C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfpt-00071X-1X
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ibflv-0002pn-5D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ibflt-0001Yr-QW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:05:27 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:57110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ibflt-0001XV-Ja
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:05:25 -0500
Received: from player711.ha.ovh.net (unknown [10.108.57.226])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8A0FB14E4DE
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 08:05:23 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 610F5CA67345;
 Mon,  2 Dec 2019 07:05:14 +0000 (UTC)
Subject: Re: [for-5.0 0/4] spapr: Improvements to CAS feature negotiation
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d2be7503-63d6-c8aa-16ba-b9483106481c@kaod.org>
Date: Mon, 2 Dec 2019 08:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129053356.232413-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13236923731548801856
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.52.162
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 06:33, David Gibson wrote:
> This series contains several cleanups to the handling of the
> ibm,client-architecture-support firmware call used for boot time
> feature negotiation between the guest OS and the firmware &
> hypervisor.
> 
> Mostly it's just internal polish, but one significant user visible
> change is that we no longer generate an extra CAS reboot to switch
> between XICS and XIVE interrupt modes (by far the most common cause of
> CAS reboots in practice).


I love it. thanks for removing this extra reboot.

C. 


> 
> David Gibson (4):
>   spapr: Don't trigger a CAS reboot for XICS/XIVE mode changeover
>   spapr: Improve handling of fdt buffer size
>   spapr: Fold h_cas_compose_response() into
>     h_client_architecture_support()
>   spapr: Simplify ovec diff
> 
>  hw/ppc/spapr.c              | 92 +++----------------------------------
>  hw/ppc/spapr_hcall.c        | 90 +++++++++++++++++++++++++-----------
>  hw/ppc/spapr_ovec.c         | 30 ++++--------
>  include/hw/ppc/spapr.h      |  4 +-
>  include/hw/ppc/spapr_ovec.h |  4 +-
>  5 files changed, 83 insertions(+), 137 deletions(-)
> 


