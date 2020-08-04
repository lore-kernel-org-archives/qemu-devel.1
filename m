Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09E122B40
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09E122B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tJ5-0001Be-TC
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k2tIA-0000Ka-4h; Tue, 04 Aug 2020 05:31:30 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:44835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k2tI6-0001B9-RX; Tue, 04 Aug 2020 05:31:29 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.201])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 0CBDA538A476;
 Tue,  4 Aug 2020 11:31:15 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 4 Aug 2020
 11:31:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b458461f-3b69-42fd-8ae6-4dfa2d73d5da,
 8D702D8D1A8AFA4BF73756F32E969A291ABE5FDC) smtp.auth=groug@kaod.org
Date: Tue, 4 Aug 2020 11:31:13 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 1/1] docs: adding NUMA documentation for pseries
Message-ID: <20200804113113.36c624e6@bahia.lan>
In-Reply-To: <20200803133440.825276-1-danielhb413@gmail.com>
References: <20200803133440.825276-1-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7a5d527b-97e4-4dfe-b8b2-3c0c3995a50f
X-Ovh-Tracer-Id: 3090032296128584160
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 05:31:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Aug 2020 10:34:40 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> This patch adds a new documentation file, ppc-spapr-numa.rst,
> informing what developers and user can expect of the NUMA distance
> support for the pseries machine, up to QEMU 5.1.
> 
> In the (hopefully soon) future, when we rework the NUMA mechanics
> of the pseries machine to at least attempt to contemplate user
> choice, this doc will be extended to inform about the new
> support.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
> 

This fixes the build break I was experiencing with v1.

Tested-by: Greg Kurz <groug@kaod.org>

> Changes in v2:
> - added 'index.rst' entry to fix a build error
> 
>  docs/specs/index.rst          |   1 +
>  docs/specs/ppc-spapr-numa.rst | 191 ++++++++++++++++++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 docs/specs/ppc-spapr-numa.rst
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 426632a475..1b0eb979d5 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -12,6 +12,7 @@ Contents:
>  
>     ppc-xive
>     ppc-spapr-xive
> +   ppc-spapr-numa
>     acpi_hw_reduced_hotplug
>     tpm
>     acpi_hest_ghes
> diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
> new file mode 100644
> index 0000000000..e762038022
> --- /dev/null
> +++ b/docs/specs/ppc-spapr-numa.rst
> @@ -0,0 +1,191 @@
> +
> +NUMA mechanics for sPAPR (pseries machines)
> +============================================
> +
> +NUMA in sPAPR works different than the System Locality Distance
> +Information Table (SLIT) in ACPI. The logic is explained in the LOPAPR
> +1.1 chapter 15, "Non Uniform Memory Access (NUMA) Option". This
> +document aims to complement this specification, providing details
> +of the elements that impacts how QEMU views NUMA in pseries.
> +
> +Associativity and ibm,associativity property
> +--------------------------------------------
> +
> +Associativity is defined as a group of platform resources that has
> +similar mean performance (or in our context here, distance) relative to
> +everyone else outside of the group.
> +
> +The format of the ibm,associativity property varies with the value of
> +bit 0 of byte 5 of the ibm,architecture-vec-5 property. The format with
> +bit 0 equal to zero is deprecated. The current format, with the bit 0
> +with the value of one, makes ibm,associativity property represent the
> +physical hierarchy of the platform, as one or more lists that starts
> +with the highest level grouping up to the smallest. Considering the
> +following topology:
> +
> +::
> +
> +    Mem M1 ---- Proc P1    |
> +    -----------------      | Socket S1  ---|
> +          chip C1          |               |
> +                                           | HW module 1 (MOD1)
> +    Mem M2 ---- Proc P2    |               |
> +    -----------------      | Socket S2  ---|
> +          chip C2          |
> +
> +The ibm,associativity property for the processors would be:
> +
> +* P1: {MOD1, S1, C1, P1}
> +* P2: {MOD1, S2, C2, P2}
> +
> +Each allocable resource has an ibm,associativity property. The LOPAPR
> +specification allows multiple lists to be present in this property,
> +considering that the same resource can have multiple connections to the
> +platform.
> +
> +Relative Performance Distance and ibm,associativity-reference-points
> +--------------------------------------------------------------------
> +
> +The ibm,associativity-reference-points property is an array that is used
> +to define the relevant performance/distance  related boundaries, defining
> +the NUMA levels for the platform.
> +
> +The definition of its elements also varies with the value of bit 0 of byte 5
> +of the ibm,architecture-vec-5 property. The format with bit 0 equal to zero
> +is also deprecated. With the current format, each integer of the
> +ibm,associativity-reference-points represents an 1 based ordinal index (i.e.
> +the first element is 1) of the ibm,associativity array. The first
> +boundary is the most significant to application performance, followed by
> +less significant boundaries. Allocated resources that belongs to the
> +same performance boundaries are expected to have relative NUMA distance
> +that matches the relevancy of the boundary itself. Resources that belongs
> +to the same first boundary will have the shortest distance from each
> +other. Subsequent boundaries represents greater distances and degraded
> +performance.
> +
> +Using the previous example, the following setting reference points defines
> +three NUMA levels:
> +
> +* ibm,associativity-reference-points = {0x3, 0x2, 0x1}
> +
> +The first NUMA level (0x3) is interpreted as the third element of each
> +ibm,associativity array, the second level is the second element and
> +the third level is the first element. Let's also consider that elements
> +belonging to the first NUMA level have distance equal to 10 from each
> +other, and each NUMA level doubles the distance from the previous. This
> +means that the second would be 20 and the third level 40. For the P1 and
> +P2 processors, we would have the following NUMA levels:
> +
> +::
> +
> +  * ibm,associativity-reference-points = {0x3, 0x2, 0x1}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x3) => associativity[2] = C1
> +  Second NUMA level (0x2) => associativity[1] = S1
> +  Third NUMA level (0x1) => associativity[0] = MOD1
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x3) => associativity[2] = C2
> +  Second NUMA level (0x2) => associativity[1] = S2
> +  Third NUMA level (0x1) => associativity[0] = MOD1
> +
> +  P1 and P2 have the same third NUMA level, MOD1: Distance between them = 40
> +
> +Changing the ibm,associativity-reference-points array changes the performance
> +distance attributes for the same associativity arrays, as the following
> +example illustrates:
> +
> +::
> +
> +  * ibm,associativity-reference-points = {0x2}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x2) => associativity[1] = S1
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x2) => associativity[1] = S2
> +
> +  P1 and P2 does not have a common performance boundary. Since this is a one level
> +  NUMA configuration, distance between them is one boundary above the first
> +  level, 20.
> +
> +
> +In a hypothetical platform where all resources inside the same hardware module
> +is considered to be on the same performance boundary:
> +
> +::
> +
> +  * ibm,associativity-reference-points = {0x1}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x1) => associativity[0] = MOD0
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x1) => associativity[0] = MOD0
> +
> +  P1 and P2 belongs to the same first order boundary. The distance between then
> +  is 10.
> +
> +
> +How the pseries Linux guest calculates NUMA distances
> +=====================================================
> +
> +Another key difference between ACPI SLIT and the LOPAPR regarding NUMA is
> +how the distances are expressed. The SLIT table provides the NUMA distance
> +value between the relevant resources. LOPAPR does not provide a standard
> +way to calculate it. We have the ibm,associativity for each resource, which
> +provides a common-performance hierarchy,  and the ibm,associativity-reference-points
> +array that tells which level of associativity is considered to be relevant
> +or not.
> +
> +The result is that each OS is free to implement and to interpret the distance
> +as it sees fit. For the pseries Linux guest, each level of NUMA duplicates
> +the distance of the previous level, and the maximum amount of levels is
> +limited to MAX_DISTANCE_REF_POINTS = 4 (from arch/powerpc/mm/numa.c in the
> +kernel tree). This results in the following distances:
> +
> +* both resources in the first NUMA level: 10
> +* resources one NUMA level apart: 20
> +* resources two NUMA levels apart: 40
> +* resources three NUMA levels apart: 80
> +* resources four NUMA levels apart: 160
> +
> +
> +Consequences for QEMU NUMA tuning
> +---------------------------------
> +
> +The way the pseries Linux guest calculates NUMA distances has a direct effect
> +on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, this is
> +the default ibm,associativity-reference-points being used in the pseries
> +machine:
> +
> +ibm,associativity-reference-points = {0x4, 0x4, 0x2}
> +
> +The first and second level are equal, 0x4, and a third one was added in
> +commit a6030d7e0b35 exclusively for NVLink GPUs support. This means that
> +regardless of how the ibm,associativity properties are being created in
> +the device tree, the pseries Linux guest will only recognize three scenarios
> +as far as NUMA distance goes:
> +
> +* if the resources belongs to the same first NUMA level = 10
> +* second level is skipped since it's equal to the first
> +* all resources that aren't a NVLink GPU, it is guaranteed that they will belong
> +  to the same third NUMA level, having distance = 40
> +* for NVLink GPUs, distance = 80 from everything else
> +
> +In short, we can summarize the NUMA distances seem in pseries Linux guests, using
> +QEMU up to 5.1, as follows:
> +
> +* local distance, i.e. the distance of the resource to its own NUMA node: 10
> +* if it's a NVLink GPU device, distance: 80
> +* every other resource, distance: 40
> +
> +This also means that user input in QEMU command line does not change the
> +NUMA distancing inside the guest for the pseries machine.


