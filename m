Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f6whJ-0006bP-6e
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f6whE-0003hO-U1
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:16:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1f6whE-0003gw-Q5
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:16:48 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <152360619100.1854.4118391342119729453@71c20359a636>
	(no-reply@patchew.org's message of "Fri, 13 Apr 2018 00:56:32 -0700
	(PDT)")
References: <152360619100.1854.4118391342119729453@71c20359a636>
Reply-To: quintela@redhat.com
Date: Fri, 13 Apr 2018 13:18:14 +0200
Message-ID: <87d0z3pd6x.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, famz@redhat.com, dgilbert@redhat.com, peter.maydell@linaro.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, kwankhede@nvidia.com, zhenyuw@linux.intel.com, yulei.zhang@intel.com, alex.williamson@redhat.com, pbonzini@redhat.com, zhi.a.wang@intel.com, david@gibson.dropbear.id.au

no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180413075200.15217-1-clg@kaod.org
> Subject: [Qemu-devel] [PATCH v2] migration: discard non-migratable RAMBlocks
>

> === OUTPUT BEGIN ===
> Checking PATCH 1/1: migration: discard non-migratable RAMBlocks...
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #96: FILE: migration/ram.c:191:
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    RAMBLOCK_FOREACH(block)                            \
> +        if (!qemu_ram_is_migratable(block)) {} else
>
> ERROR: trailing statements should be on next line
> #98: FILE: migration/ram.c:193:
> +        if (!qemu_ram_is_migratable(block)) {} else
>
> total: 2 errors, 0 warnings, 167 lines checked

To be fair, I don't know how to fix this outside of:

BEGIN_RAMBLOCK_FOREACH(...)

END_RAMBLOCK_FOREACH()

type of construct.  I was wondering about what could happen if the
RAMBLOCK_FOREACH was insied an if, but checkpatch beated me to it.

Later, Juan.
