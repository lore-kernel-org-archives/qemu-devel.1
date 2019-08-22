Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA3CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01626233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01626233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0q9x-0003F9-34
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0q84-0001x4-PP
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0q81-0000nB-48
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0q80-0000mq-QN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:40:01 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D03E083F3D
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:39:59 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id v133so2400130oia.18
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cBtGuiGbNmzlvuMsk6eTW2IV8EBUQlvms3uoC2raAQw=;
 b=F25qSnvK7wEQinoyI4eMiw7imStL+RvoVBtIM9/EgaCfrbM0OBDOirFY+Ch9XwUj4Z
 oeQrF5ydVSbUD5y4isxl7QC0rBaq43kdLBZEryVkuByAgLFqWVm8prv+y48ECqsv0rkF
 ucSXJZ33OKpL6b1tU9UfJaPTf0fJO/G/tnR6CPZ3A4wXdg8gP/rYYnvxmB8dOIs5NK7B
 imXPUUpBgLEfC438xEIt+v8I0JBg4c2mYem+HnaPiGjXOZ4+tGwtauECF3y+xnEJFOr/
 PDdyC/BSPNNJfGSpXoXR7QtQpUos0peGnuY2Akg7tpN/XQv7ezMecDQ9csaQug4BLUP0
 V9lQ==
X-Gm-Message-State: APjAAAX7L1GSJkMXzlx+Qb/pX91/xyje52jteau5Zr8zbyat3vAVDLUf
 JsCukbyhl1sMeHhOQNY8F0ajh6ZpTNlZvAXfeepY4bQcQG+ACqJtuMcN9oE+vnlLJPH5vIkvb6P
 +dpve/jN3lTbc6p3EOdJ/6w+VaVVCPDI=
X-Received: by 2002:a9d:76da:: with SMTP id p26mr385093otl.311.1566491999183; 
 Thu, 22 Aug 2019 09:39:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwljpThKn3NZbcJ7fFr2a9UexLZEnm87eAv1aoUjnbC83jutl2ipitDzNxTwr9cjIbgZo8ept9U+sf5Ocl00ps=
X-Received: by 2002:a9d:76da:: with SMTP id p26mr385066otl.311.1566491998806; 
 Thu, 22 Aug 2019 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
In-Reply-To: <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 19:39:47 +0300
Message-ID: <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
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

On Thu, Aug 22, 2019 at 5:28 PM Max Reitz <mreitz@redhat.com> wrote:

> On 16.08.19 23:21, Nir Soffer wrote:
> > When creating an image with preallocation "off" or "falloc", the first
> > block of the image is typically not allocated. When using Gluster
> > storage backed by XFS filesystem, reading this block using direct I/O
> > succeeds regardless of request length, fooling alignment detection.
> >
> > In this case we fallback to a safe value (4096) instead of the optimal
> > value (512), which may lead to unneeded data copying when aligning
> > requests.  Allocating the first block avoids the fallback.
> >
> > When using preallocation=3Doff, we always allocate at least one filesys=
tem
> > block:
> >
> >     $ ./qemu-img create -f raw test.raw 1g
> >     Formatting 'test.raw', fmt=3Draw size=3D1073741824
> >
> >     $ ls -lhs test.raw
> >     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
> >
> > I did quick performance tests for these flows:
> > - Provisioning a VM with a new raw image.
> > - Copying disks with qemu-img convert to new raw target image
> >
> > I installed Fedora 29 server on raw sparse image, measuring the time
> > from clicking "Begin installation" until the "Reboot" button appears:
> >
> > Before(s)  After(s)     Diff(%)
> > -------------------------------
> >      356        389        +8.4
> >
> > I ran this only once, so we cannot tell much from these results.
>
> So you=E2=80=99d expect it to be fast but it was slower?  Well, you only =
ran it
> once and it isn=E2=80=99t really a precise benchmark...
>
> > The second test was cloning the installation image with qemu-img
> > convert, doing 10 runs:
> >
> >     for i in $(seq 10); do
> >         rm -f dst.raw
> >         sleep 10
> >         time ./qemu-img convert -f raw -O raw -t none -T none src.raw
> dst.raw
> >     done
> >
> > Here is a table comparing the total time spent:
> >
> > Type    Before(s)   After(s)    Diff(%)
> > ---------------------------------------
> > real      530.028    469.123      -11.4
> > user       17.204     10.768      -37.4
> > sys        17.881      7.011      -60.7
> >
> > Here we see very clear improvement in CPU usage.
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >  block/file-posix.c         | 25 +++++++++++++++++++++++++
> >  tests/qemu-iotests/150.out |  1 +
> >  tests/qemu-iotests/160     |  4 ++++
> >  tests/qemu-iotests/175     | 19 +++++++++++++------
> >  tests/qemu-iotests/175.out |  8 ++++----
> >  tests/qemu-iotests/221.out | 12 ++++++++----
> >  tests/qemu-iotests/253.out | 12 ++++++++----
> >  7 files changed, 63 insertions(+), 18 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index b9c33c8f6c..3964dd2021 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void *opaque)
> >      return ret;
> >  }
> >
> > +/*
> > + * Help alignment detection by allocating the first block.
> > + *
> > + * When reading with direct I/O from unallocated area on Gluster backe=
d
> by XFS,
> > + * reading succeeds regardless of request length. In this case we
> fallback to
> > + * safe aligment which is not optimal. Allocating the first block
> avoids this
> > + * fallback.
> > + *
> > + * Returns: 0 on success, -errno on failure.
> > + */
> > +static int allocate_first_block(int fd)
> > +{
> > +    ssize_t n;
> > +
> > +    do {
> > +        n =3D pwrite(fd, "\0", 1, 0);
>
> This breaks when fd has been opened with O_DIRECT.
>

It seems that we always open images without O_DIRECT when creating an image
in qemu-img create, or when creating a target image in qemu-img convert.

Here is a trace of qemu-img create:

$ strace -f -tt -o /tmp/create.trace ./qemu-img create -f raw -o
preallocation=3Dfalloc /tmp/gv1/src.raw 1g
Formatting '/tmp/gv1/src.raw', fmt=3Draw size=3D1073741824 preallocation=3D=
falloc

1. open #1

17686 18:58:23.681921 openat(AT_FDCWD, "/tmp/gv1/src.raw",
O_RDONLY|O_NONBLOCK|O_CLOEXEC) =3D 9
17686 18:58:23.683753 fstat(9, {st_mode=3DS_IFREG|0600, st_size=3D107374182=
4,
...}) =3D 0
17686 18:58:23.683829 close(9)          =3D 0

2. open #2

17686 18:58:23.684146 openat(AT_FDCWD, "/tmp/gv1/src.raw",
O_RDONLY|O_NONBLOCK|O_CLOEXEC) =3D 9
17686 18:58:23.684227 fstat(9, {st_mode=3DS_IFREG|0600, st_size=3D107374182=
4,
...}) =3D 0
17686 18:58:23.684256 close(9)          =3D 0

3. open #3

17686 18:58:23.684339 openat(AT_FDCWD, "/tmp/gv1/src.raw",
O_RDWR|O_CREAT|O_CLOEXEC, 0644) =3D 9
...
17688 18:58:23.690178 fstat(9, {st_mode=3DS_IFREG|0600, st_size=3D107374182=
4,
...}) =3D 0
17688 18:58:23.690217 ftruncate(9, 0 <unfinished ...>
...
17688 18:58:23.700266 <... ftruncate resumed>) =3D 0
...
17688 18:58:23.700595 fstat(9,  <unfinished ...>
...
17688 18:58:23.700619 <... fstat resumed>{st_mode=3DS_IFREG|0600, st_size=
=3D0,
...}) =3D 0
...
17688 18:58:23.700651 fallocate(9, 0, 0, 1073741824 <unfinished ...>
...
17688 18:58:23.728141 <... fallocate resumed>) =3D 0
...
17688 18:58:23.728196 pwrite64(9, "\0", 1, 0) =3D 1
...
17686 18:58:23.738391 close(9)          =3D 0

Here is convert trace:

$ strace -f -tt -o /tmp/convert.trace ./qemu-img convert -f raw -O raw -t
none -T none /tmp/gv1/src.raw /tmp/gv1/dst.raw

1. open #1

18175 19:07:23.364417 openat(AT_FDCWD, "/tmp/gv1/dst.raw",
O_RDONLY|O_NONBLOCK|O_CLOEXEC) =3D 10
18175 19:07:23.365282 fstat(10, {st_mode=3DS_IFREG|0600, st_size=3D10737418=
24,
...}) =3D 0
18175 19:07:23.365323 close(10)         =3D 0

2. open #2

18175 19:07:23.365660 openat(AT_FDCWD, "/tmp/gv1/dst.raw",
O_RDONLY|O_NONBLOCK|O_CLOEXEC) =3D 10
18175 19:07:23.365717 fstat(10, {st_mode=3DS_IFREG|0600, st_size=3D10737418=
24,
...}) =3D 0
18175 19:07:23.365742 close(10)         =3D 0

3. open #3

18175 19:07:23.365839 openat(AT_FDCWD, "/tmp/gv1/dst.raw",
O_RDWR|O_CREAT|O_CLOEXEC, 0644) =3D 10
...
18177 19:07:23.372112 fstat(10, {st_mode=3DS_IFREG|0600, st_size=3D10737418=
24,
...}) =3D 0
18177 19:07:23.372138 ftruncate(10, 0)  =3D 0
...
18177 19:07:23.375760 fstat(10, {st_mode=3DS_IFREG|0600, st_size=3D0, ...})=
 =3D 0
18177 19:07:23.375788 ftruncate(10, 1073741824) =3D 0
18177 19:07:23.376383 pwrite64(10, "\0", 1, 0) =3D 1
...
18175 19:07:23.390989 close(10)         =3D 0

4. open #4

18175 19:07:23.391429 openat(AT_FDCWD, "/tmp/gv1/dst.raw",
O_RDONLY|O_NONBLOCK|O_CLOEXEC) =3D 10
18175 19:07:23.392433 fstat(10, {st_mode=3DS_IFREG|0600, st_size=3D10737418=
24,
...}) =3D 0
18175 19:07:23.392483 close(10)         =3D 0

5. open #5

18175 19:07:23.392743 openat(AT_FDCWD, "/tmp/gv1/dst.raw",
O_RDWR|O_DIRECT|O_CLOEXEC) =3D 10
...
18175 19:07:23.393731 ioctl(10, BLKSSZGET, 0x7ffe75ead334) =3D -1 ENOSYS
(Function not implemented)
18175 19:07:23.393784 pread64(10, 0x558796451000, 1, 0) =3D -1 EINVAL
(Invalid argument)
18175 19:07:23.395362 pread64(10,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512,
0) =3D 512
18175 19:07:23.395905 pread64(10,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096, 0) =3D 4096
...

(Which happens when you open some file with cache.direct=3Don, and then
> use e.g. QMP=E2=80=99s block_resize.)
>

What would be a command triggering this? I can add a test.

It isn=E2=80=99t that bad because eventually you simply ignore the error.  =
But
> it still makes me wonder whether we shouldn=E2=80=99t write like the bigg=
est
> power of two that does not exceed the new file length or MAX_BLOCKSIZE.
>

It makes sense if there is a way to cause qemu-img to use O_DIRECT when
creating an image.

> +    } while (n =3D=3D -1 && errno =3D=3D EINTR);
> > +
> > +    return (n =3D=3D -1) ? -errno : 0;
> > +}
> > +
> >  static int handle_aiocb_truncate(void *opaque)
> >  {
> >      RawPosixAIOData *aiocb =3D opaque;
> > @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void *opaque)
> >                  /* posix_fallocate() doesn't set errno. */
> >                  error_setg_errno(errp, -result,
> >                                   "Could not preallocate new data");
> > +            } else if (current_length =3D=3D 0) {
> > +                allocate_first_block(fd);
>
> Should posix_fallocate() not take care of precisely this?
>

Only if the filesystem does not support fallocate() (e.g. NFS < 4.2).

In this case posix_fallocate() is doing:

  for (offset +=3D (len - 1) % increment; len > 0; offset +=3D increment)
    {
      len -=3D increment;
      if (offset < st.st_size)
        {
          unsigned char c;
          ssize_t rsize =3D __pread (fd, &c, 1, offset);
          if (rsize < 0)
            return errno;
          /* If there is a non-zero byte, the block must have been
             allocated already.  */
          else if (rsize =3D=3D 1 && c !=3D 0)
            continue;
        }
      if (__pwrite (fd, "", 1, offset) !=3D 1)
        return errno;
    }

https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.html=
#96

So opening a file with O_DIRECT will break preallocation=3Dfalloc on such
filesystems,
and writing one byte in allocate_first_block() is safe.

> >              }
> >          } else {
> >              result =3D 0;
>
> [...]
>
> > diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
> > index df89d3864b..ad2d054a47 100755
> > --- a/tests/qemu-iotests/160
> > +++ b/tests/qemu-iotests/160
> > @@ -57,6 +57,10 @@ for skip in $TEST_SKIP_BLOCKS; do
> >      $QEMU_IMG dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out" skip=3D"$skip" =
-O
> "$IMGFMT" \
> >          2> /dev/null
> >      TEST_IMG=3D"$TEST_IMG.out" _check_test_img
> > +
> > +    # We always write the first byte of an image.
> > +    printf "\0" > "$TEST_IMG.out.dd"
> > +
> >      dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out.dd" skip=3D"$skip" status=
=3Dnone
>
> Won=E2=80=99t this dd completely overwrite $TEST_IMG.out.dd (especially g=
iven
> the lack of conv=3Dnotrunc)?
>

There is an issue only if dd open the file with O_TRUNC. I will test this
again.

>
> >      echo
> > diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> > index 51e62c8276..c6a3a7bb1e 100755
> > --- a/tests/qemu-iotests/175
> > +++ b/tests/qemu-iotests/175
> > @@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> >  # the file size.  This function hides the resulting difference in the
> >  # stat -c '%b' output.
> >  # Parameter 1: Number of blocks an empty file occupies
> > -# Parameter 2: Image size in bytes
> > +# Parameter 2: Minimal number of blocks in an image
> > +# Parameter 3: Image size in bytes
> >  _filter_blocks()
> >  {
> >      extra_blocks=3D$1
> > -    img_size=3D$2
> > +    min_blocks=3D$2
> > +    img_size=3D$3
> >
> > -    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocate=
d/"
> \
> > -        -e "s/blocks=3D$((extra_blocks + img_size /
> 512))\\(\$\\|[^0-9]\\)/everything allocated/"
> > +    sed -e "s/blocks=3D$((extra_blocks +
> min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
>
> I don=E2=80=99t think adding extra_blocks to min_blocks makes sense.  Jus=
t
> min_blocks alone should be what we want here.
>

We had failing tests (in vdsm) showing that filesystem may return more
blocs than
expected even for non-empty files, so this may be needed. I did not test
it yet with a filesystem that show this issue, but I found your instruction=
s
how to create it.

Thanks for reviewing.

Nir
