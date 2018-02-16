Received: from eggs.gnu.org ([2001:4830:134:3::10]:55150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eme2G-0007Yk-9p
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eme2B-00006u-6D
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:18:36 -0500
Date: Fri, 16 Feb 2018 12:18:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216121810.56ed961e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Hi,

for 2.13 (or whatever it will be called), I'd like to switch to a
submaintainer model for s390x, where maintainers for a certain s390x
area (including myself) send me pull requests that I integrate into
s390-next resp. s390-fixes, for which I send a pull request to merge
into master.

The problem here is that I don't want these sub pull requests to be
picked up by Peter's scripts, generating confusion. So far, my ideas
have been:

- Post s390 pull requests only to qemu-s390x@nongnu.org. This sucks, as
  it makes part of the process intransparent to any QEMU developer not
  subscribed to that mailing list.
- Put a certain marker into the subject, like "PULL *s390x*" or so. I'm
  not sure how robust that is.
- Ditch the pull request idea, keep applying patches. This is not quite
  as bad as it sounds, as I have the infrastructure to apply patches
  anyway, but it hides the real workflow (and simply pulling is likely
  less work for me in the long run.)

Thoughts? Ideas?
