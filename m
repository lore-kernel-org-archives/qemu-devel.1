Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A21C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69B120856
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sNE-0000da-00
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0sKt-000788-NK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0sKp-0005rl-U4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0sKp-0005rD-Iy
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 15:01:23 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 731AF356F9
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 19:01:22 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id g8so3603453otj.16
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 12:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f9oyCo318oQ6xz0uw5gBSu1gtuNjrN0lvb7+fd3WDjI=;
 b=no6XSJXgbSj3Je60lTowC616rYsHp0+3J8ykv5yEGO92RT71xwvUzGfH9WJcI4sQeA
 YEOyK3/yzJG/QB4PzUpbvMETdvG6vgaB/7KfCa5lilCU/ERD9KVpB90PgcWiXV425vfB
 uFGk+zyk92bTj/2pOE/ILgS1p7noBJkib4yz7uXqn9WJDjvUNEU6w0BfN/NhdxupFLnP
 UljLUd+XzUApR2EqQpm0ruIFMmypLiAg6H79UKgwV5XO3d6xT4q93UOZV+xe6QTFO7XK
 cYZdTmab5GdXH3TsTCibNY0j+vst2EILG9b11gMBdog0eEmsQZAhx85aVUNnGbE97ptA
 Z1zg==
X-Gm-Message-State: APjAAAUO2CPzZ8mHkshFMqgmub5RCS9fLBvdkTp13HILHln9kRVd8pNE
 3YnpQKQJUCihyM3VBuQ2s8ETEk/tNsd7urtcd9OWmr6PvbP7WDGMjRdQFbj0hv7XrPb1PZdwzkX
 rvxulomj1tRpSSdjd2RPriY+l0JLo2kE=
X-Received: by 2002:a05:6830:20d5:: with SMTP id
 z21mr937414otq.132.1566500481690; 
 Thu, 22 Aug 2019 12:01:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwk2E84vXUtV1LOFU4KHbWuOWsHH29nlIlASjdxbDjH9MTDcIQG9JFXpFqVHEyr72dyQ57RCQa3EF7IKgI5XyA=
X-Received: by 2002:a05:6830:20d5:: with SMTP id
 z21mr937379otq.132.1566500481306; 
 Thu, 22 Aug 2019 12:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
In-Reply-To: <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 22:01:09 +0300
Message-ID: <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 9:11 PM Max Reitz <mreitz@redhat.com> wrote:

> On 22.08.19 18:39, Nir Soffer wrote:
> > On Thu, Aug 22, 2019 at 5:28 PM Max Reitz <mreitz@redhat.com
> > <mailto:mreitz@redhat.com>> wrote:
> >
> >     On 16.08.19 23:21, Nir Soffer wrote:
> >     > When creating an image with preallocation "off" or "falloc", the
> first
> >     > block of the image is typically not allocated. When using Gluster
> >     > storage backed by XFS filesystem, reading this block using direct
> I/O
> >     > succeeds regardless of request length, fooling alignment detectio=
n.
> >     >
> >     > In this case we fallback to a safe value (4096) instead of the
> optimal
> >     > value (512), which may lead to unneeded data copying when alignin=
g
> >     > requests.  Allocating the first block avoids the fallback.
> >     >
> >     > When using preallocation=3Doff, we always allocate at least one
> >     filesystem
> >     > block:
> >     >
> >     >     $ ./qemu-img create -f raw test.raw 1g
> >     >     Formatting 'test.raw', fmt=3Draw size=3D1073741824
> >     >
> >     >     $ ls -lhs test.raw
> >     >     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
> >     >
> >     > I did quick performance tests for these flows:
> >     > - Provisioning a VM with a new raw image.
> >     > - Copying disks with qemu-img convert to new raw target image
> >     >
> >     > I installed Fedora 29 server on raw sparse image, measuring the
> time
> >     > from clicking "Begin installation" until the "Reboot" button
> appears:
> >     >
> >     > Before(s)  After(s)     Diff(%)
> >     > -------------------------------
> >     >      356        389        +8.4
> >     >
> >     > I ran this only once, so we cannot tell much from these results.
> >
> >     So you=E2=80=99d expect it to be fast but it was slower?  Well, you=
 only ran
> it
> >     once and it isn=E2=80=99t really a precise benchmark...
> >
> >     > The second test was cloning the installation image with qemu-img
> >     > convert, doing 10 runs:
> >     >
> >     >     for i in $(seq 10); do
> >     >         rm -f dst.raw
> >     >         sleep 10
> >     >         time ./qemu-img convert -f raw -O raw -t none -T none
> >     src.raw dst.raw
> >     >     done
> >     >
> >     > Here is a table comparing the total time spent:
> >     >
> >     > Type    Before(s)   After(s)    Diff(%)
> >     > ---------------------------------------
> >     > real      530.028    469.123      -11.4
> >     > user       17.204     10.768      -37.4
> >     > sys        17.881      7.011      -60.7
> >     >
> >     > Here we see very clear improvement in CPU usage.
> >     >
> >     > Signed-off-by: Nir Soffer <nsoffer@redhat.com
> >     <mailto:nsoffer@redhat.com>>
> >     > ---
> >     >  block/file-posix.c         | 25 +++++++++++++++++++++++++
> >     >  tests/qemu-iotests/150.out |  1 +
> >     >  tests/qemu-iotests/160     |  4 ++++
> >     >  tests/qemu-iotests/175     | 19 +++++++++++++------
> >     >  tests/qemu-iotests/175.out |  8 ++++----
> >     >  tests/qemu-iotests/221.out | 12 ++++++++----
> >     >  tests/qemu-iotests/253.out | 12 ++++++++----
> >     >  7 files changed, 63 insertions(+), 18 deletions(-)
> >     >
> >     > diff --git a/block/file-posix.c b/block/file-posix.c
> >     > index b9c33c8f6c..3964dd2021 100644
> >     > --- a/block/file-posix.c
> >     > +++ b/block/file-posix.c
> >     > @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void
> *opaque)
> >     >      return ret;
> >     >  }
> >     >
> >     > +/*
> >     > + * Help alignment detection by allocating the first block.
> >     > + *
> >     > + * When reading with direct I/O from unallocated area on Gluster
> >     backed by XFS,
> >     > + * reading succeeds regardless of request length. In this case w=
e
> >     fallback to
> >     > + * safe aligment which is not optimal. Allocating the first bloc=
k
> >     avoids this
> >     > + * fallback.
> >     > + *
> >     > + * Returns: 0 on success, -errno on failure.
> >     > + */
> >     > +static int allocate_first_block(int fd)
> >     > +{
> >     > +    ssize_t n;
> >     > +
> >     > +    do {
> >     > +        n =3D pwrite(fd, "\0", 1, 0);
> >
> >     This breaks when fd has been opened with O_DIRECT.
> >
> >
> > It seems that we always open images without O_DIRECT when creating an
> image
> > in qemu-img create, or when creating a target image in qemu-img convert=
.
>
> Yes.  But you don=E2=80=99t call this function directly from image creati=
on code
> but instead from the truncation function.  (The former also calls the
> latter, but truncating is also an operation on its own.)
>
> [...]
>
> >     (Which happens when you open some file with cache.direct=3Don, and =
then
> >     use e.g. QMP=E2=80=99s block_resize.)
> >
> >
> > What would be a command triggering this? I can add a test.
>
> block_resize, as I=E2=80=99ve said:
>
> $ ./qemu-img create -f raw empty.img 0
>

This is extreme edge case - why would someone create such image?


> $ x86_64-softmmu/qemu-system-x86_64 \
>     -qmp stdio \
>     -blockdev file,node-name=3Dfile,filename=3Dempty.img,cache.direct=3Do=
n \
>      <<EOF
> {'execute':'qmp_capabilities'}
>

This is probably too late for the allocation, since we already probed
the alignment before executing block_resize, and used a safe fallback
(4096).
It can help if the image is reopened, since we probe alignment again.

> {'execute':'block_resize',
>  'arguments':{'node-name':'file',
>               'size':1048576}}

EOF
> $ ./qemu-img map empty.img
> Offset          Length          Mapped to       File
>
> (You=E2=80=99d expect a data chunk here.)

I suppose you can get the same effect with blockdev-create and some
> format that explicitly resizes the file to some target length (LUKS does
> this, I think), but this is the most direct route.
>

I will try to handle -blockdev in the next version.

>     It isn=E2=80=99t that bad because eventually you simply ignore the er=
ror.  But
> >     it still makes me wonder whether we shouldn=E2=80=99t write like th=
e biggest
> >     power of two that does not exceed the new file length or
> MAX_BLOCKSIZE.
> >
> >
> > It makes sense if there is a way to cause qemu-img to use O_DIRECT when
> > creating an image.
> >
> >     > +    } while (n =3D=3D -1 && errno =3D=3D EINTR);
> >     > +
> >     > +    return (n =3D=3D -1) ? -errno : 0;
> >     > +}
> >     > +
> >     >  static int handle_aiocb_truncate(void *opaque)
> >     >  {
> >     >      RawPosixAIOData *aiocb =3D opaque;
> >     > @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void
> *opaque)
> >     >                  /* posix_fallocate() doesn't set errno. */
> >     >                  error_setg_errno(errp, -result,
> >     >                                   "Could not preallocate new
> data");
> >     > +            } else if (current_length =3D=3D 0) {
> >     > +                allocate_first_block(fd);
> >
> >     Should posix_fallocate() not take care of precisely this?
> >
> >
> > Only if the filesystem does not support fallocate() (e.g. NFS < 4.2).
> >
> > In this case posix_fallocate() is doing:
> >
> >   for (offset +=3D (len - 1) % increment; len > 0; offset +=3D incremen=
t)
> >     {
> >       len -=3D increment;
> >       if (offset < st.st_size)
> >         {
> >           unsigned char c;
> >           ssize_t rsize =3D __pread (fd, &c, 1, offset);
> >           if (rsize < 0)
> >             return errno;
> >           /* If there is a non-zero byte, the block must have been
> >              allocated already.  */
> >           else if (rsize =3D=3D 1 && c !=3D 0)
> >             continue;
> >         }
> >       if (__pwrite (fd, "", 1, offset) !=3D 1)
> >         return errno;
> >     }
> >
> >
> https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.ht=
ml#96
> >
> > So opening a file with O_DIRECT will break preallocation=3Dfalloc on su=
ch
> > filesystems,
>
> But won=E2=80=99t the function above just fail with EINVAL?
> allocate_first_block() is executed only in case of success.
>

Sure, but if posix_fallocate() fails, we fail qemu-img create/convert.

> and writing one byte in allocate_first_block() is safe.
> >
> >     >              }
> >     >          } else {
> >     >              result =3D 0;
> >
> >     [...]
> >
> >     > diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
> >     > index df89d3864b..ad2d054a47 100755
> >     > --- a/tests/qemu-iotests/160
> >     > +++ b/tests/qemu-iotests/160
> >     > @@ -57,6 +57,10 @@ for skip in $TEST_SKIP_BLOCKS; do
> >     >      $QEMU_IMG dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out" skip=3D"$=
skip"
> >     -O "$IMGFMT" \
> >     >          2> /dev/null
> >     >      TEST_IMG=3D"$TEST_IMG.out" _check_test_img
> >     > +
> >     > +    # We always write the first byte of an image.
> >     > +    printf "\0" > "$TEST_IMG.out.dd"
> >     > +
> >     >      dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out.dd" skip=3D"$skip"
> status=3Dnone
> >
> >     Won=E2=80=99t this dd completely overwrite $TEST_IMG.out.dd (especi=
ally given
> >     the lack of conv=3Dnotrunc)?
> >
> >
> > There is an issue only if dd open the file with O_TRUNC.
>
> It isn=E2=80=99t an issue, I just don=E2=80=99t understand why the printf=
 would be
> necessary at all.
>
> dd should always truncate the output image unless conv=3Dnotrunc is
> specified.  But even if it didn=E2=80=99t do that, in all of these test c=
ases it
> should copy some data from $TEST_IMG to the output, and thus should
> always overwrite the first byte anyway.
>

Right, this change is not needed.

> I will test
> > this again.
> >
> >     >
> >     >      echo
> >     > diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> >     > index 51e62c8276..c6a3a7bb1e 100755
> >     > --- a/tests/qemu-iotests/175
> >     > +++ b/tests/qemu-iotests/175
> >     > @@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> >     >  # the file size.  This function hides the resulting difference i=
n
> the
> >     >  # stat -c '%b' output.
> >     >  # Parameter 1: Number of blocks an empty file occupies
> >     > -# Parameter 2: Image size in bytes
> >     > +# Parameter 2: Minimal number of blocks in an image
> >     > +# Parameter 3: Image size in bytes
> >     >  _filter_blocks()
> >     >  {
> >     >      extra_blocks=3D$1
> >     > -    img_size=3D$2
> >     > +    min_blocks=3D$2
> >     > +    img_size=3D$3
> >     >
> >     > -    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing
> >     allocated/" \
> >     > -        -e "s/blocks=3D$((extra_blocks + img_size /
> >     512))\\(\$\\|[^0-9]\\)/everything allocated/"
> >     > +    sed -e "s/blocks=3D$((extra_blocks +
> >     min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
> >
> >     I don=E2=80=99t think adding extra_blocks to min_blocks makes sense=
.  Just
> >     min_blocks alone should be what we want here.
> >
> >
> > We had failing tests (in vdsm) showing that filesystem may return more
> > blocs than
> > expected even for non-empty files, so this may be needed.
>
> But min_blocks is exactly the number of blocks of a file that has one
> allocated block.  I don=E2=80=99t see how adding the number of blocks an =
empty
> file occupies makes sense.
>

You are right. The test fails on filesystem that allocates extra blocks.

Nir
