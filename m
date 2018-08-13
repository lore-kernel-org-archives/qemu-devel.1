Received: from eggs.gnu.org ([2001:4830:134:3::10]:44419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpFvb-0000A0-LB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpFva-00024V-SE
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:42:47 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
	<e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
	<20180813155856.GL4323@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <435d9dd8-f994-f011-f62e-4568dea8fd21@janustech.com>
Date: Mon, 13 Aug 2018 19:42:23 +0300
MIME-Version: 1.0
In-Reply-To: <20180813155856.GL4323@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

> I don't actually think it's so bad to keep the cache permanently
> allocated, but I wouldn't object to a lower default for non-Linux hosts
> either. 1 MB may still be a little too low, 4 MB (covers up to 32 GB)
> might be more adequate. My typical desktop VMs are larger than 8 GB, but
> smaller than 32 GB.
> 
> Kevin
> 

And for a Windows VM just the OS installation takes above 40 GB. While 
we probably are not running Windows VMs for our own needs, it is very 
common that a customer of, for example, some cloud service uses QEMU 
(unknowingly) for a full-blown Windows. So 100 GB+ images which are 
quite heavily used is not a rare scenario. 256 GB - yeah, that would be 
on the higher end.

So 16 MB would indeed be a reasonable default for the *max.* L2 cache 
now, although below that would be too little, I think. 32 MB - if we 
want some future-proofing.

Leonid.
