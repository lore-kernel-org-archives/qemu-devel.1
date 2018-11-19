Received: from eggs.gnu.org ([2001:4830:134:3::10]:45299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnPN-0000sz-5H
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnPM-0000d1-Gz
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:32:25 -0500
References: <20181119172924.2296342-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <024942ff-c624-9bf9-bf49-a844499ed1a1@redhat.com>
Date: Mon, 19 Nov 2018 11:32:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181119172924.2296342-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] iotests: Enhance 223 to cover
 multiple bitmap granularities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 11/19/18 11:29 AM, Eric Blake wrote:
> Testing granularity at the same size as the cluster isn't quite
> as fun as what happens when it is larger or smaller.  This
> enhancement also shows that qemu's nbd server can server the

s/server/serve/

> same disk over multiple exports simultaneously.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
