Received: from eggs.gnu.org ([2001:4830:134:3::10]:36311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e57Md-0005T6-5Q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e57MZ-0006w0-5P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:43:43 -0400
Date: Thu, 19 Oct 2017 11:43:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171019114331.44a29bec.cohuck@redhat.com>
In-Reply-To: <9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
	<9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Enable the simple virtio tests on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>

On Wed, 18 Oct 2017 10:01:57 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 10/18/2017 09:20 AM, Thomas Huth wrote:
> > First patch introduces the qtest_startf() function that can be used
> > to start tests with a printf-like string. This patch was originally
> > part of Eric's bigger qtest refactoring series, and I originally wanted
> > to wait 'til it's included in the master branch. But since this did
> > not happen yet and QEMU soft-freeze is approaching soon, I decided
> > to rather included a slightly simplified version of that patch here
> > instead.  
> 
> Fair enough.  I'm also trying to focus on getting features in before
> soft freeze, hence my lack of rebasing the qtest refactoring series in
> the meantime.  Arguably (although it is a bit weak) we can claim
> testsuite fixes as material that is still relevant after soft freeze as
> it does not affect the final installed binaries, as long as they still
> go in before hard freeze, but it's hard to say at this point if any of
> my qtest refactoring will make 2.11.
> 

Hi Eric,

does Thomas' port of your patch look sane? If yes, I'll queue both
patches on s390-next for 2.11.
