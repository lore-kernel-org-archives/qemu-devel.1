Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE6C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E27E2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E27E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irI93-00042i-EK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msuchanek@suse.de>) id 1irI8B-0003Vz-11
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msuchanek@suse.de>) id 1irI87-0000N3-1q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:04:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msuchanek@suse.de>)
 id 1irI86-0000Ml-Rp; Tue, 14 Jan 2020 04:04:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2803AAAB8;
 Tue, 14 Jan 2020 09:04:49 +0000 (UTC)
Date: Tue, 14 Jan 2020 10:04:45 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH qemu] spapr: Kill SLOF
Message-ID: <20200114090445.GD4113@kitsune.suse.cz>
References: <20200103074404.30853-1-aik@ozlabs.ru>
 <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
 <dd98618f-01c6-850f-ac00-454a2f798508@gmail.com>
 <81f1f752-3ada-2c8d-38b7-1344c7633e14@ozlabs.ru>
 <e3299f0688127627de96eb2db1f127bf94df9085.camel@redhat.com>
 <36763452-a67f-b663-42d2-48cd99995a0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36763452-a67f-b663-42d2-48cd99995a0c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 195.135.220.15
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Andrea Bolognani <abologna@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, Paul Mackerras <paulus@ozlabs.org>,
 Sam Bobroff <sbobroff@linux.ibm.com>, qemu-ppc@nongnu.org,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 12:23:13PM +0100, Thomas Huth wrote:
> On 07/01/2020 10.39, Andrea Bolognani wrote:
> > On Tue, 2020-01-07 at 12:55 +1100, Alexey Kardashevskiy wrote:
> >> On 07/01/2020 01:15, Daniel Henrique Barboza wrote:
> >>> Question: does Petitboot already replaces SLOF in every possible
> >>> scenario for all
> >>> the spapr machine features?
> >>
> >> Petitboot kernel+initramdisk almost replaces SLOF + GRUB.
> > 
> > Is this necessarily a good thing? Personally I quite like the fact
> > that I can use the same bootloader across x86, ppc64 and aarch64.
> 
> AFAIK petitboot can use the grub config files ... and it is already used
> on bare metal POWER8 and POWER9 systems, so it should not be such a big
> change to use it for POWER KVM guests, too?

Except it is not really pSeries then anymore.

Thanks

Michal

