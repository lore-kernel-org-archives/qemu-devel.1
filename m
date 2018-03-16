Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewouO-0002RD-Gs
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewouN-0005QR-O6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:56:32 -0400
Date: Fri, 16 Mar 2018 14:56:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180316145541-mutt-send-email-mst@kernel.org>
References: <1521178795-21894-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521178795-21894-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Add new CD-ROM related qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Mar 16, 2018 at 06:39:52AM +0100, Thomas Huth wrote:
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


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> v2:
>  - Use g_spawn_sync() instead of execlp() to run genisoimage
>  - The "-cdrom" parameter test is now run on all architectures (with
>    machine "none" for the machines that are not explicitly checked)
>  - Some rewordings and improved comments here and there
> 
> Thomas Huth (3):
>   tests/boot-sector: Add magic bytes to s390x boot code header
>   tests/cdrom-test: Test booting from CD-ROM ISO image file
>   tests/cdrom-test: Test that -cdrom parameter is working
> 
>  tests/Makefile.include |   2 +
>  tests/boot-sector.c    |   9 +-
>  tests/cdrom-test.c     | 222 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+), 3 deletions(-)
>  create mode 100644 tests/cdrom-test.c
> 
> -- 
> 1.8.3.1
