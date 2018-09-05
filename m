Received: from eggs.gnu.org ([2001:4830:134:3::10]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxYAR-0004iS-L9
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxYAQ-0000hP-Of
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:48:23 -0400
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
	<20180904150042.GE3803@andariel.pipo.sk>
	<20180904153436.GC4371@localhost.localdomain>
	<20180905123813.GF3803@andariel.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eff7c4ef-9db7-2b80-b853-e68bf60f4a73@redhat.com>
Date: Wed, 5 Sep 2018 08:48:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180905123813.GF3803@andariel.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 09/05/2018 07:38 AM, Peter Krempa wrote:

> block-commit is able to reopen the format layers and works as expected.
> 
> Unfortunately though the 'read-only' option is actually useful as the
> curl-driver does not work without it:
> 
> -blockdev {"driver":"http","url":"http://ftp.sjtu.edu.cn:80/ubuntu-cd/12.04/ubuntu-12.04.5-alternate-amd64.iso","node-name":"libvirt-2-storage","discard":"unmap"}: curl block device does not support writes
> 
> We obviously can encode that knowledge into libvirt but it will be hard
> to undo if qemu eventually supports writes in the curl driver.
> 
> Which other protocol drivers don't support writes? in case we have to go
> this way.

When an NBD server exported an image as read-only, the NBD block client 
cannot request write permissions.  But that's a runtime discovery 
process, not a limitation of the block driver itself.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
