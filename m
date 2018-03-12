Received: from eggs.gnu.org ([2001:4830:134:3::10]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evS8I-0003Fk-NS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evS8F-0000wN-J6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evS8F-0000w5-EN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:25:11 -0400
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-5-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc075c89-06bf-4dfc-782e-ba7caf1c9b9f@redhat.com>
Date: Mon, 12 Mar 2018 13:24:54 -0500
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/23] RISC-V: Use ROM base address and
 size from memmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/08/2018 10:12 PM, Michael Clark wrote:
> Another case of replaceing hard coded constants, this time

s/replaceing/replacing/

> referring to the definition in the virt machine's memmap.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
