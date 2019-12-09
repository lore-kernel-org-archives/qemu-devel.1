Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4CEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3378C207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3378C207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLgr-0007S9-3R
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieLfZ-00060X-Vc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieLfX-0004Do-Mn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:57 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:34495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieLfX-0004DQ-Fy
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:55 -0500
Received: from player158.ha.ovh.net (unknown [10.109.143.246])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id B772610F42E
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 17:13:52 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 0A8DDCF9D7A7;
 Mon,  9 Dec 2019 16:13:42 +0000 (UTC)
Date: Mon, 9 Dec 2019 17:13:41 +0100
From: Greg Kurz <groug@kaod.org>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 1/1] pseries: Update SLOF firmware image
Message-ID: <20191209171341.7db0bd9c@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209160015.20253-2-eblake@redhat.com>
References: <20191209160015.20253-1-eblake@redhat.com>
 <20191209160015.20253-2-eblake@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8268608916702140809
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.238
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, jsnow@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Dec 2019 10:00:15 -0600
Eric Blake <eblake@redhat.com> wrote:

> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This fixes PCI bridge regression.
> 
> Alexey Kardashevskiy (3):
>       ibm,client-architecture-support: Fix stack handling
>       fdt: Fix updating the tree at H_CAS
>       version: update to 20191209
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

This doesn't look like the right patch... this one belongs
to David Gibson's PR that was merged earlier today.

>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 928552 -> 931040 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/README b/pc-bios/README
> index 830645c51fbe..91218c69e9d6 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -17,7 +17,7 @@
>  - SLOF (Slimline Open Firmware) is a free IEEE 1275 Open Firmware
>    implementation for certain IBM POWER hardware.  The sources are at
>    https://github.com/aik/SLOF, and the image currently in qemu is
> -  built from git tag qemu-slof-20191022.
> +  built from git tag qemu-slof-20191209.
> 
>  - sgabios (the Serial Graphics Adapter option ROM) provides a means for
>    legacy x86 software to communicate with an attached serial console as
> diff --git a/pc-bios/slof.bin b/pc-bios/slof.bin
> index 0b93fe8c011fc352803dc24e3110b7f926493769..50fc9b1e1cb837809c38fed1e9099b262e8600f1 100644
> GIT binary patch
> delta 5477
> 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
> 
> delta 3433
> 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
> 
> diff --git a/roms/SLOF b/roms/SLOF
> index 899d98836513..8ebf2f55e1ba 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 899d98836513bb3d6a4f4e48ef7cee887ee5f57b
> +Subproject commit 8ebf2f55e1ba1492b942ba4b682160e644fc0f98


