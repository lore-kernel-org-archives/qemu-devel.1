Received: from eggs.gnu.org ([2001:4830:134:3::10]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMlj-0001Rl-Cd
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 07:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMli-00032H-IP
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 07:49:43 -0500
Date: Fri, 22 Dec 2017 13:49:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222124930.GD3763@localhost.localdomain>
References: <20171215080446.10671-1-famz@redhat.com>
	<20171215080446.10671-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215080446.10671-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: Open backing image in force
 share mode for size probe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 15.12.2017 um 09:04 hat Fam Zheng geschrieben:
> Management tools create overlays of running guests with qemu-img:
> 
>   $ qemu-img create -b /image/in/use.qcow2 -f qcow2 /overlay/image.qcow2
> 
> but this doesn't work anymore due to image locking:
> 
>     qemu-img: /overlay/image.qcow2: Failed to get shared "write" lock
>     Is another process using the image?
>     Could not open backing image to determine size.
> Use the force share option to allow this use case again.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied this patch to the block branch. Please resend a fixed
version of the test case.

Kevin
