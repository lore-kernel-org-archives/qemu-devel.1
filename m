Received: from eggs.gnu.org ([2001:4830:134:3::10]:43115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiIxv-0008JR-VA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiIxs-0000ZH-UP
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:32:27 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
Date: Wed, 25 Jul 2018 15:32:01 +0300
In-Reply-To: <32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
Content-Language: en-GB-large
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

   On 07/25/2018 03:22 PM, Eric Blake wrote:

     On 07/25/2018 03:26 AM, Kevin Wolf wrote:

     Only looking at the external interface for now, I wonder whether it
     would be nicer not to have two mutually exclusive options, but to
     make
     l2-cache-size an alternate that can take either an int like before
     (meaning the number of bytes) or a string/enum (with the only
     accepted
     value "full" for now).

     That does sound interesting.

   This does, but currently QEMU supports QEMU_OPT_STRING, QEMU_OPT_BOOL,
   QEMU_OPT_NUMBER, and QEMU_OPT_SIZE. Looks like it will require a more
   fundamental change to accept an option that can be either a string or a
   size.

     Another interesting question is whether 'full' shouldn't keep
     meaning
     full throughout the lifetime of the BlockDriverState, i.e. should it
     keep adapting to the new size when the image size changes?

     Do we even resize the cache now for image size changes? If we use an
     enum, we could have two different values depending on whether the
     chosen cache size remains fixed or also tries to resize when the
     image grows.

   Is it even possible to change the virtual disk image size online?
   Found a problem with my previous patch: the property was not actually
   set as a proper boolean option. Also, fixing the error output in iotest
   103 (thanks Kevin for the catch!). V5 is on the way.
