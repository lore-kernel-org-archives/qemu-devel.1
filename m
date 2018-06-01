Received: from eggs.gnu.org ([2001:4830:134:3::10]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXcr-0001KZ-N7
	for qemu-devel@nongnu.org; Thu, 31 May 2018 20:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXcq-0007jK-Lp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 20:09:01 -0400
References: <1524822046-22779-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4eae64a0-6f03-48c0-0c36-cb4d879169a7@redhat.com>
Date: Thu, 31 May 2018 20:08:53 -0400
MIME-Version: 1.0
In-Reply-To: <1524822046-22779-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Add new CD-ROM related qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 04/27/2018 05:40 AM, Thomas Huth wrote:
> With one of my clean-up patches (see commit 1454509726719e0933c800), I
> recently accidentially broke the "-cdrom" parameter (more precisely
> "-drive if=scsi") on a couple of boards, since there was no error
> detected during the "make check" regression testing. This is clearly an
> indication that we are lacking tests in this area.
> So this small patch series now introduces some tests for CD-ROM drives:
> The first two patches introduce the possibility to check that booting
> from CD-ROM drives still works fine for x86 and s390x, and the third
> patch adds a test that certain machines can at least still be started
> with the "-cdrom" parameter (i.e. that test would have catched the
> mistake that I did with my SCSI cleanup patch).
> 
> v3:
>  - Rebased to current master branch
>  - Add a final patch that adds an entry to the MAINTAINERS file
> 
> v2:
>  - Use g_spawn_sync() instead of execlp() to run genisoimage
>  - The "-cdrom" parameter test is now run on all architectures (with
>    machine "none" for the machines that are not explicitly checked)
>  - Some rewordings and improved comments here and there
> 
> Thomas Huth (4):
>   tests/boot-sector: Add magic bytes to s390x boot code header
>   tests/cdrom-test: Test booting from CD-ROM ISO image file
>   tests/cdrom-test: Test that -cdrom parameter is working
>   MAINTAINERS: Add the cdrom-test to John's section
> 
>  MAINTAINERS            |   1 +
>  tests/Makefile.include |   2 +
>  tests/boot-sector.c    |   9 +-
>  tests/cdrom-test.c     | 222 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+), 3 deletions(-)
>  create mode 100644 tests/cdrom-test.c
> 

*coughs*

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
