Received: from eggs.gnu.org ([2001:4830:134:3::10]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOIWN-0006df-6G
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOIWJ-00083I-8P
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:01:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180531004323.4611-1-jsnow@redhat.com>
References: <20180531004323.4611-1-jsnow@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 31 May 2018 09:01:13 +0100
Message-ID: <CAJSP0QWsKDKeFCuVT3ToMA0g--Zc74h9U4F=3denbGjY=VShsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] ahci: fix completion race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Thu, May 31, 2018 at 1:43 AM, John Snow <jsnow@redhat.com> wrote:
> Commit d759c951f changed the main thread lock release/reacquisition,
> and in so doing apparently jostled loose a race condition in the AHCI
> code.
>
> Patch 2 should be sufficient to fix this, and patches 1 and 3 are just
> little trivial fixes.
>
> This might be sufficient to fix the bug as reported at
> https://bugs.launchpad.net/qemu/+bug/1769189
> but the nature of the timing changes make it difficult to confirm,
> so I am posting this patchset for the reporters to help test.
>
> John Snow (3):
>   ahci: trim signatures on raise/lower
>   ahci: fix PxCI register race
>   ahci: don't schedule unnecessary BH
>
>  hw/ide/ahci.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Nice find!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
