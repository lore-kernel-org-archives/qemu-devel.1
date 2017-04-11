Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxym0-0006lK-UJ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxylx-0005OH-R8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:08 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:59636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxylx-0005Ns-K8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:05 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id ED27431126
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:36:03 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-21-git-send-email-clg@kaod.org>
	<20170410081414.GS27571@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <69eb038a-9a68-1baf-5c2f-1aee1b774309@kaod.org>
Date: Tue, 11 Apr 2017 18:35:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170410081414.GS27571@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/21] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/10/2017 10:14 AM, David Gibson wrote:
> +/* Copyright (c) 2013-2017, IBM Corporation.
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> + * implied.
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + */
> +
> +#ifndef PCI_HOST_PNV_PHB3_REGS_H
> +#define PCI_HOST_PNV_PHB3_REGS_H
> +
> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +#define PPC_BITLSHIFT(be)       (63 - (be))
> +#define PPC_BITLSHIFT32(be)     (31 - (be))

These could probably be defined for all hw/ppc/ and target/ppc to use ? 

C. 
