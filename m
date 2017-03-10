Received: from eggs.gnu.org ([2001:4830:134:3::10]:56396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGE2-0002yn-4f
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGDy-000160-Uh
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:48:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmGDy-00015q-Nz
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:48:34 -0500
References: <20170309152708.30635-1-dgilbert@redhat.com>
	<fa186054-0b8c-924f-b30b-34ed92a83337@redhat.com>
	<20170309161352.GI2480@work-vm>
	<b3f5e4e8-1039-0d50-235a-8616ec67aedc@redhat.com>
	<20170309163805.GJ2480@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <713a5748-1a15-55ac-b26e-94d30e870da5@redhat.com>
Date: Fri, 10 Mar 2017 09:48:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170309163805.GJ2480@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org



On 09/03/2017 17:38, Dr. David Alan Gilbert wrote:
> It is used by all of the _ram specific functions, so it seemed worth
> including the comment.

It's internal though.  memory.c users never use it in a way that creates
a RAMBlock.

> (I also see it's used in some of the boards but I don't understand
> why - e.g. hw/ppc/ppc405_boards.c calls it on something that looks
> like RAM.  Although perhaps that's related to the 'fix this' above it)

It's a weird 0-length memory region, and it doesn't have a RAMBlock.
Probably needed only to satisfy ppc405ep_init.

    ram_bases[0] = 0;
    ram_sizes[0] = 0x08000000;
    memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
    ram_bases[1] = 0x00000000;
    ram_sizes[1] = 0x00000000;

Paolo
