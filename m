Received: from eggs.gnu.org ([208.118.235.92]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzOt2-0002sS-R5
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzOsI-0005kA-CU
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:17:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <fa35bb97-0354-58d9-d752-5d8ca3f56b93@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
	<w5136uot46b.fsf@maestria.local.igalia.com>
	<3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
	<w51o9d9ij92.fsf@maestria.local.igalia.com>
	<fa35bb97-0354-58d9-d752-5d8ca3f56b93@redhat.com>
Date: Mon, 10 Sep 2018 18:17:07 +0200
Message-ID: <w51k1nttji4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 07 Sep 2018 02:42:53 PM CEST, Max Reitz wrote:
> The whole purpose of bs->auto_backing_file is so you can compare it
> with bs->backing->bs->filename, see when it differs, and then you know
> that the user has changed the backing file from what it would be based
> on the image header alone (that is, if the user hadn't specified any
> @backing option at all).
  [...]
> (Now you could ask yourself, if we know the user hasn't specified any
> options to override the backing file -- why don't we just store a
> flag?  I tried that, Kevin wasn't really happy about it because it's
> hard to catch all corner cases.  There are many ways to change a
> backing file, and if you want to find out when a backing file has been
> changed to exactly what the image header says (this is the ideal
> outcome of the commit block job, for instance), you basically get back
> to the same problem of comparing filenames.)

Ok, I think this clarifies a lot. Thanks!

Berto
