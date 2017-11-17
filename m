Received: from eggs.gnu.org ([2001:4830:134:3::10]:34144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfv0-0005kp-IQ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfuz-0007CM-Pi
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:38:50 -0500
Date: Fri, 17 Nov 2017 13:38:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117123840.GC4795@localhost.localdomain>
References: <20171117112913.21875-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117112913.21875-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 (for-2.11)] qcow2: fix image corruption
 after committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 17.11.2017 um 12:29 hat Daniel P. Berrange geschrieben:
> After committing the qcow2 image contents into the base image, qemu-img
> will call bdrv_make_empty to drop the payload in the layered image.
> 
> When this is done for qcow2 images, it blows away the LUKS encryption
> header, making the resulting image unusable. There are two codepaths
> for emptying a qcow2 image, and the second (slower) codepath leaves
> the LUKS header intact, so force use of that codepath.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
