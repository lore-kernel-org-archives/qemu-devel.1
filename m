Received: from eggs.gnu.org ([2001:4830:134:3::10]:36728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsqYH-0003xf-0S
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsqYC-000814-Qq
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:25:32 -0400
Date: Thu, 23 Aug 2018 16:25:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823162521.6ff80f8d.cohuck@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 00/10] Move virtio-ccw devices to
 separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Wed, 25 Jul 2018 14:20:14 +0200
Thomas Huth <thuth@redhat.com> wrote:

> For more fine-grained control over the build process, it would be good
> to have the possibility to disable single virtio devices, too. We already
> have CONFIG_VIRTIO_* switches in the Makefiles, but currently all
> virtio-ccw devices are compiled in anyway. Move them to separate files
> so we can disable them in the Makefile more easily.
> 
> NB: I did not move virtio-blk-ccw and virtio-net-ccw to a separate file
> yet since they are essential for the s390x-virtio machine and thus it
> does IMHO not make much sense to disable net and blk. But if somebody
> needs that possibility, too, I can add two more patches on top...

Thanks, applied (including the two patches on top.)
