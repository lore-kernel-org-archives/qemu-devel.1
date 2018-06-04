Received: from eggs.gnu.org ([2001:4830:134:3::10]:45076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPjtv-0002I9-Ny
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPjts-0002Pw-Kk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:27:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPjts-0002Pn-G0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:27:32 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <152808659065.396.9065157974177590230@d39dc562802a>
	(no-reply@patchew.org's message of "Sun, 3 Jun 2018 21:29:51 -0700
	(PDT)")
References: <152808659065.396.9065157974177590230@d39dc562802a>
Reply-To: quintela@redhat.com
Date: Mon, 04 Jun 2018 09:30:24 +0200
Message-ID: <874lij101b.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180604042156.13812-1-quintela@redhat.com
> Subject: [Qemu-devel] [PULL 0/5] Migration pull request

> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/20180514065700.22202-1-clg@kaod.org -> patchew/20180514065700.22202-1-clg@kaod.org
>  * [new tag]               patchew/20180604042156.13812-1-quintela@redhat.com -> patchew/20180604042156.13812-1-quintela@redhat.com
> Switched to a new branch 'test'
> 99ac0fb20d migration: not wait RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect
> 7c902253bb migration: remove unnecessary variables len in QIOChannelRDMA
> 3c1203cb38 migration: Don't activate block devices if using -S
> 2ecc458546 migration: discard non-migratable RAMBlocks
> 718b388d4e migration: introduce decompress-error-check
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/5: migration: introduce decompress-error-check...
> Checking PATCH 2/5: migration: discard non-migratable RAMBlocks...
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #191: FILE: migration/ram.c:161:
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    RAMBLOCK_FOREACH(block)                            \
> +        if (!qemu_ram_is_migratable(block)) {} else
>
> ERROR: trailing statements should be on next line
> #193: FILE: migration/ram.c:163:
> +        if (!qemu_ram_is_migratable(block)) {} else

We know. it is on purpose.  There is no good solution.  Changing
checkpatch don't make sense either, it is an one-off case.

Later, Juan.
