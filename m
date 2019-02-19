Received: from eggs.gnu.org ([209.51.188.92]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gw589-0001Fd-SK
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gw587-0000fS-W6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:08:13 -0500
MIME-Version: 1.0
References: <20190219115937.21587-1-stefanha@redhat.com>
	<2598979f-d8b5-4324-3ca4-f87802d4a9d1@redhat.com>
	<30c66aaa-2807-69cd-2395-dcd49e59b136@virtuozzo.com>
In-Reply-To: <30c66aaa-2807-69cd-2395-dcd49e59b136@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Feb 2019 13:07:58 +0000
Message-ID: <CAJSP0QVk-aisqUW8feav3XNLebC182TRY7LaMrVa-cP87n43ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: drop unnecessary
 accel=kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 12:12 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> 19.02.2019 15:02, Thomas Huth wrote:
> > On 19/02/2019 12.59, Stefan Hajnoczi wrote:
> >> Tests 235 and 238 do not require the kvm accelerator.  TCG works fine.
> >>
> >> Use the default accelerator instead of requiring kvm.
> >>
> >> Suggested-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>   tests/qemu-iotests/235 | 1 -
> >>   tests/qemu-iotests/238 | 1 -
> >>   2 files changed, 2 deletions(-)
> >>
> >> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> >> index d6edd97ab4..329da8f0c2 100755
> >> --- a/tests/qemu-iotests/235
> >> +++ b/tests/qemu-iotests/235
> >> @@ -49,7 +49,6 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
> >>                   str(size))
> >>
> >>   vm = QEMUMachine(iotests.qemu_prog)
> >> -vm.add_args('-machine', 'accel=kvm')
> >
> > According to the initial commit log of 235:
> >
> >   "iotests: simple mirror test with kvm on 1G image"
> >
> > ... so I assume KVM was used on purpose here?
> >
> >   Thomas
> >
>
> As I remember kvm is not really necessary, and test have a comment about it:
> # And it didn't reproduce if at least one of the following:
> ...
> # 3. drop kvm and use iotests.VM() (maybe, because of qtest) (however, it still
> #    reproduces, if just drop kvm, but gdb failed to produce full backtraces
> #    for me)
>
> But the comment should be updated with this patch.

Will fix in v2.

Stefan
