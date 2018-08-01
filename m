Received: from eggs.gnu.org ([2001:4830:134:3::10]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkssa-0008HD-UO
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkssa-0003r3-2U
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:17:36 -0400
References: <20180727081939.28185-1-ndevos@redhat.com>
	<f0a7edbd-f731-7ac5-4aee-ef2ba594ed64@redhat.com>
	<20180728041839.GA1325070@localhost.localdomain>
	<20180728075005.GE1827@ndevos-x270>
	<2bf3b1f9-ab42-5256-8093-7c41aaa9f2d6@redhat.com>
	<20180730192729.GA443110@localhost.localdomain>
	<20180731091802.GL17519@ndevos-x270>
	<20180731195122.GA1748801@localhost.localdomain>
	<20180801114714.GA4925@ndevos-x270>
From: Eric Blake <eblake@redhat.com>
Message-ID: <412fadad-1b9b-5d7b-9b8f-14803c4a7ed6@redhat.com>
Date: Wed, 1 Aug 2018 10:17:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180801114714.GA4925@ndevos-x270>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, integration@gluster.org

On 08/01/2018 06:47 AM, Niels de Vos wrote:
>> If glusterfs-5 releases in October, that may line up with 3.1 or 3.2.
> 
> Ok, I'll keep these kind of patches in my tree as work-in-progress and
> when the glusterfs-5 gets tagged for alpha/beta send it again.
> 
> Even if not optimal, would you accept this as a way going forward?

It will work. But even better would be getting gluster to the point that 
it has a stable back-compat API guarantee (no future API removals or 
signature changes on existing functions - all new functionality is added 
via new API).  The more clients a library gains, the more pain you cause 
yourself and all your clients when you choose not to maintain a 
backwards-compatible stable API.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
