Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0280F21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0280F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CpI-0001zv-6f
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i1CkI-0005xl-Aj
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i1Ck8-0002C8-SQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i1Ck7-0002Ax-Sz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:48:52 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D68ED7BDAE
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 16:48:49 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id t10so5212919otb.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2XDLXgKbHva+whS2MATV+3vUqfh3Ys2NS4q1kMHv/S0=;
 b=YoVVHwlyXpwLgN8vN5DOZtguFLNHbFg2DLZ4eNuT1PzUYOHEkZyYwfHmSFOF4oN0Wo
 xya89UE/gDp5g5Tycaw8gABaGJM/VaB4dVN9oZ/6DgP15LWgLMjPkTD+xpefH/it5C8M
 Xb+TDiJ1IE8Ey912qNjXYLFkl5f6VC9iGHZBq1RHZWE8BEin8IA5TSYMlI+f2tCRxZUp
 umRKj38c64qYhNCdC1iw3fGggyfOHH5QPnfMHNcVbaWAtFRT+7MTZy5q3Xx6Wdt/Nc0n
 4RPzfG3qRl6TwWRMZYLVxXaqSLpYwRlVzp2h1awuCXelpAZjt0MDk7/+UqrhmFC3RvyX
 /ggw==
X-Gm-Message-State: APjAAAVDHV5Tilz4izOY6olA/IDLqJ5p/pVwEuHbRKhMUyHmxU/oIGlR
 dmRTlvXXgA0I1acsMdrFMRW8+jVH4yd1s0fFVBP20oDhnfm5R9YYl6FKWRu60XpcoWoKMv9Gv6v
 BDqxp9JyurjswxCnWCmdwn5+M8M1RgAo=
X-Received: by 2002:aca:1714:: with SMTP id j20mr3557720oii.135.1566578929039; 
 Fri, 23 Aug 2019 09:48:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAXt91jhKd4HNpPgwBQgj3BxbdLq2OJhbRynGUgXHGCve+S7Yb4347j1+mZNGQpxkxLq09CSra8VpfWVIlL6o=
X-Received: by 2002:aca:1714:: with SMTP id j20mr3557701oii.135.1566578928747; 
 Fri, 23 Aug 2019 09:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
In-Reply-To: <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 23 Aug 2019 19:48:37 +0300
Message-ID: <CAMRbyytObKSo+spkrQsTurybGJEndDTWP4UJgieP0nVw=CLmag@mail.gmail.com>
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

On Fri, Aug 23, 2019 at 4:58 PM Max Reitz <mreitz@redhat.com> wrote:

> On 22.08.19 21:01, Nir Soffer wrote:
> > On Thu, Aug 22, 2019 at 9:11 PM Max Reitz <mreitz@redhat.com
> > <mailto:mreitz@redhat.com>> wrote:
> >
> >     On 22.08.19 18:39, Nir Soffer wrote:
> >     > On Thu, Aug 22, 2019 at 5:28 PM Max Reitz <mreitz@redhat.com
> >     <mailto:mreitz@redhat.com>
> >     > <mailto:mreitz@redhat.com <mailto:mreitz@redhat.com>>> wrote:
> >     >
> >     >     On 16.08.19 23:21, Nir Soffer wrote:
> >     >     > When creating an image with preallocation "off" or "falloc"=
,
> >     the first
> >     >     > block of the image is typically not allocated. When using
> >     Gluster
> >     >     > storage backed by XFS filesystem, reading this block using
> >     direct I/O
> >     >     > succeeds regardless of request length, fooling alignment
> >     detection.
> >     >     >
> >     >     > In this case we fallback to a safe value (4096) instead of
> >     the optimal
> >     >     > value (512), which may lead to unneeded data copying when
> >     aligning
> >     >     > requests.  Allocating the first block avoids the fallback.
> >     >     >
> >     >     > When using preallocation=3Doff, we always allocate at least=
 one
> >     >     filesystem
> >     >     > block:
> >     >     >
> >     >     >     $ ./qemu-img create -f raw test.raw 1g
> >     >     >     Formatting 'test.raw', fmt=3Draw size=3D1073741824
> >     >     >
> >     >     >     $ ls -lhs test.raw
> >     >     >     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48
> >     test.raw
> >     >     >
> >     >     > I did quick performance tests for these flows:
> >     >     > - Provisioning a VM with a new raw image.
> >     >     > - Copying disks with qemu-img convert to new raw target ima=
ge
> >     >     >
> >     >     > I installed Fedora 29 server on raw sparse image, measuring
> >     the time
> >     >     > from clicking "Begin installation" until the "Reboot" butto=
n
> >     appears:
> >     >     >
> >     >     > Before(s)  After(s)     Diff(%)
> >     >     > -------------------------------
> >     >     >      356        389        +8.4
> >     >     >
> >     >     > I ran this only once, so we cannot tell much from these
> results.
> >     >
> >     >     So you=E2=80=99d expect it to be fast but it was slower?  Wel=
l, you
> >     only ran it
> >     >     once and it isn=E2=80=99t really a precise benchmark...
> >     >
> >     >     > The second test was cloning the installation image with
> qemu-img
> >     >     > convert, doing 10 runs:
> >     >     >
> >     >     >     for i in $(seq 10); do
> >     >     >         rm -f dst.raw
> >     >     >         sleep 10
> >     >     >         time ./qemu-img convert -f raw -O raw -t none -T no=
ne
> >     >     src.raw dst.raw
> >     >     >     done
> >     >     >
> >     >     > Here is a table comparing the total time spent:
> >     >     >
> >     >     > Type    Before(s)   After(s)    Diff(%)
> >     >     > ---------------------------------------
> >     >     > real      530.028    469.123      -11.4
> >     >     > user       17.204     10.768      -37.4
> >     >     > sys        17.881      7.011      -60.7
> >     >     >
> >     >     > Here we see very clear improvement in CPU usage.
> >     >     >
> >     >     > Signed-off-by: Nir Soffer <nsoffer@redhat.com
> >     <mailto:nsoffer@redhat.com>
> >     >     <mailto:nsoffer@redhat.com <mailto:nsoffer@redhat.com>>>
> >     >     > ---
> >     >     >  block/file-posix.c         | 25 +++++++++++++++++++++++++
> >     >     >  tests/qemu-iotests/150.out |  1 +
> >     >     >  tests/qemu-iotests/160     |  4 ++++
> >     >     >  tests/qemu-iotests/175     | 19 +++++++++++++------
> >     >     >  tests/qemu-iotests/175.out |  8 ++++----
> >     >     >  tests/qemu-iotests/221.out | 12 ++++++++----
> >     >     >  tests/qemu-iotests/253.out | 12 ++++++++----
> >     >     >  7 files changed, 63 insertions(+), 18 deletions(-)
> >     >     >
> >     >     > diff --git a/block/file-posix.c b/block/file-posix.c
> >     >     > index b9c33c8f6c..3964dd2021 100644
> >     >     > --- a/block/file-posix.c
> >     >     > +++ b/block/file-posix.c
> >     >     > @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void
> >     *opaque)
> >     >     >      return ret;
> >     >     >  }
> >     >     >
> >     >     > +/*
> >     >     > + * Help alignment detection by allocating the first block.
> >     >     > + *
> >     >     > + * When reading with direct I/O from unallocated area on
> >     Gluster
> >     >     backed by XFS,
> >     >     > + * reading succeeds regardless of request length. In this
> >     case we
> >     >     fallback to
> >     >     > + * safe aligment which is not optimal. Allocating the firs=
t
> >     block
> >     >     avoids this
> >     >     > + * fallback.
> >     >     > + *
> >     >     > + * Returns: 0 on success, -errno on failure.
> >     >     > + */
> >     >     > +static int allocate_first_block(int fd)
> >     >     > +{
> >     >     > +    ssize_t n;
> >     >     > +
> >     >     > +    do {
> >     >     > +        n =3D pwrite(fd, "\0", 1, 0);
> >     >
> >     >     This breaks when fd has been opened with O_DIRECT.
> >     >
> >     >
> >     > It seems that we always open images without O_DIRECT when creatin=
g
> >     an image
> >     > in qemu-img create, or when creating a target image in qemu-img
> >     convert.
> >
> >     Yes.  But you don=E2=80=99t call this function directly from image =
creation
> code
> >     but instead from the truncation function.  (The former also calls t=
he
> >     latter, but truncating is also an operation on its own.)
> >
> >     [...]
> >
> >     >     (Which happens when you open some file with cache.direct=3Don=
,
> >     and then
> >     >     use e.g. QMP=E2=80=99s block_resize.)
> >     >
> >     >
> >     > What would be a command triggering this? I can add a test.
> >
> >     block_resize, as I=E2=80=99ve said:
> >
> >     $ ./qemu-img create -f raw empty.img 0
> >
> >
> > This is extreme edge case - why would someone create such image?
>
> Because it works?
>
> This is generally the fist step of image creation with blockdev-create,
> because you don=E2=80=99t care about the size of the protocol layer.
>
> If you have a format layer that truncates the image to a fixed size and
> does not write anything into the first block itself (say because it uses
> a footer), then (with O_DIRECT) allocate_first_block() will fail
> (silently, because while it does return an error value, it is never
> checked and there is no comment that explains why we don=E2=80=99t check =
it)


The motivation is that this is an optimization for the special case of usin=
g
empty image, so it does not worth failing image creation.
I will add a comment about that.


> and
> the first block actually will not be allocated.
>
> I could show you that with VPC (which supports a fixed subformat where
> it uses a footer), but unfortunately that=E2=80=99s a bit broken right no=
w
> (because of a bug in blockdev-create; I=E2=80=99ll send a patch).
>
> The test would go like this:
>
> $ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
> {"execute":"qmp_capabilities"}
>
> {"execute":"blockdev-create",
>  "arguments":{
>     "job-id":"create",
>     "options":{"driver":"file",
>                "filename":"test.img",
>                "size":0}}}
>
> [Wait until the job is pending]
>
> {"execute":"job-dismiss","arguments":{"id":"create"}}
>
> {"execute":"blockdev-add",
>  "arguments":{
>     "driver":"file",
>     "node-name":"protocol-node",
>     "filename":"test.img",
>     "cache":{"direct":true}}}
>
> {"execute":"blockdev-create",
>  "arguments":{
>     "job-id":"create",
>     "options":{"driver":"vpc",
>                "file":"protocol-node",
>                "subformat":"fixed",
>                "size":67108864,
>                "force-size":true}}}
>
> [Wait until the job is pending]
>
> {"execute":"job-dismiss","arguments":{"id":"create"}}
>
> {"execute":"quit"}
>
> And then:
>
> $ ./qemu-img map test.img
> Offset          Length          Mapped to       File
> 0x4000000       0x200           0x4000000       test.img
>
> The footer is mapped, but the first block is not allocated.
>

Thanks for the example.

I will need time to play with blockdev and understand the flows when image
are created. Do you think is would be useful to fix now only image creation
via qemu-img, and handle blockdev later?
...
