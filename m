Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E86C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22406215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22406215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQS0u-0004us-SB
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQRzw-0004LX-BH; Thu, 08 Oct 2020 05:14:04 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:43653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQRzt-0003Xv-9j; Thu, 08 Oct 2020 05:14:04 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.134])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id AE2CA63468D6;
 Thu,  8 Oct 2020 11:13:56 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 8 Oct 2020
 11:13:56 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0010f6c6f53-1a7b-4b92-bde5-0b7f9547059e,
 0790828B1F24D1EF09E1BE8E049C9F9AD207BACD) smtp.auth=groug@kaod.org
Date: Thu, 8 Oct 2020 11:13:55 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 0/5] pseries NUMA distance calculation
Message-ID: <20201008111355.2d089c84@bahia.lan>
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
References: <20201007172849.302240-1-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f08d3613-b467-432b-beaf-7aef86e5ecad
X-Ovh-Tracer-Id: 15588084214296386016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeekgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptdelleefjeetuefhgeegvdfgtdeigeeukeevheehudeutdfhleevvdfhvedvveeinecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 05:13:57
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  7 Oct 2020 14:28:44 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> This forth version is based on review comments and suggestion

Series for SLOF ? ;-) ;-) ;-)

> from David in v3.
> 
> changes from v3:
> - patch 4:
>     * copied the explanation in spapr_numa_define_associativity_domains()
>       to the commit message
>     * return numa_level directly instead of calculating a temp
>       value in spapr_numa_get_numa_level()
>     * we're now setting assoc_src in all n_levels above it in 
>       spapr_numa_define_associativity_domains()
> - patch 5:
>     * changed the documentation as suggested by David
> 
> v3 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10443.html
> 
> Daniel Henrique Barboza (5):
>   spapr: add spapr_machine_using_legacy_numa() helper
>   spapr_numa: forbid asymmetrical NUMA setups
>   spapr_numa: change reference-points and maxdomain settings
>   spapr_numa: consider user input when defining associativity
>   specs/ppc-spapr-numa: update with new NUMA support
> 
>  capstone                      |   2 +-
>  docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++--
>  hw/ppc/spapr.c                |  12 ++
>  hw/ppc/spapr_numa.c           | 185 ++++++++++++++++++++++++--
>  include/hw/ppc/spapr.h        |   2 +
>  5 files changed, 419 insertions(+), 17 deletions(-)
> 


