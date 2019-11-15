Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5197C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E33B20748
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E33B20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaY8-000857-MH
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVaWo-0007PA-O9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVaWm-0002RO-Fo
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:16:42 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:33322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVaWk-0002PO-GR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:16:38 -0500
Received: from player711.ha.ovh.net (unknown [10.109.146.5])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id B2545145419
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 13:16:28 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 89C13C09FA87;
 Fri, 15 Nov 2019 12:16:23 +0000 (UTC)
Subject: Re: [PATCH for-5.0 0/8] ppc: Consolidate QOM links and pointers to
 the same object
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <59f7978d-0c34-cc92-f0bd-e72a1a7e9d8f@kaod.org>
Date: Fri, 15 Nov 2019 13:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10888578000738880339
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.75.26
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/2019 12:53, Greg Kurz wrote:
> There's a recurring pattern in the code where a const link is added to a
> newly instanciated object and the link is then used in the object's realize
> function to keep a pointer to the QOM entity which the link points to.
> 
> void create_obj_B(Object *obj_a)
> {
>     Object *obj_b;
> 
>     obj_b = object_new(TYPE_B);
>     object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_abort);
> }
> 
> void object_B_realize(DeviceState *dev, Error **errp)
> {
>     Object *obj_a;
> 
>     obj_a = object_property_get_link(OBJECT(dev), "link-to-a", errp);
>     if (!obj_a) {
>         return;
>     }
> 
>     obj_b->obj_a = A(obj_a); // If obj_b->obj_a is changed, the link property
>                              // still points to the original obj_a that was
>                              // passed to object_property_add_const_link()
> }
> 
> Confusing bugs could arise if the pointer and the link go out of sync for
> some reason. This can be avoided if the property is defined to directly use
> the pointer with object_property_add_link() and object_property_set_link().
> 
> This series just does that for all occurences of the fragile pattern in
> the XIVE and PNV code.

Can we use DEFINE_PROP_LINK() instead ?

C. 


> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (8):
>       xive: Link "cpu" property to XiveTCTX::cs pointer
>       xive: Link "xive" property to XiveSource::xive pointer
>       xive: Link "xive" property to XiveEndSource::xrtr pointer
>       ppc/pnv: Link "psi" property to PnvLpc::psi pointer
>       ppc/pnv: Link "psi" property to PnvOCC::psi pointer
>       ppc/pnv: Link "chip" property to PnvHomer::chip pointer
>       ppc/pnv: Link "chip" property to PnvCore::chip pointer
>       ppc/pnv: Link "chip" property to PnvXive::chip pointer
> 
> 
>  hw/intc/pnv_xive.c        |   29 +++++++++-----------
>  hw/intc/spapr_xive.c      |    8 +++---
>  hw/intc/xive.c            |   65 ++++++++++++++++++++++-----------------------
>  hw/ppc/pnv.c              |   32 +++++++++++-----------
>  hw/ppc/pnv_core.c         |   18 +++++++-----
>  hw/ppc/pnv_homer.c        |   24 +++++++++--------
>  hw/ppc/pnv_lpc.c          |   23 ++++++++--------
>  hw/ppc/pnv_occ.c          |   23 ++++++++--------
>  hw/ppc/pnv_psi.c          |    3 +-
>  include/hw/ppc/pnv.h      |    2 +
>  include/hw/ppc/pnv_core.h |    2 +
>  11 files changed, 115 insertions(+), 114 deletions(-)
> 


