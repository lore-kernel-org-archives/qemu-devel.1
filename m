Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35367C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9A3205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9A3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CWG-0004Ov-5f
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i1CSg-0002Gu-11
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i1CSe-0007I9-7Q
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i1CSd-0007HF-UH
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:48 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32C3F83F3C
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 16:30:46 +0000 (UTC)
Received: by mail-oi1-f197.google.com with SMTP id v133so3725968oia.18
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N8lZ15All/JYFj/jpjk4ZlS3i3bVH6ZGlavACvnTTQY=;
 b=lZKboY2F45/RB1Z0OCKyjVZC+OR0yQ1jGc5EwuTrZNlyGYjF1A8GNCvgQ7iQ8KuTBj
 meKerH5/cht58U4KecAMecBayQW4Y/h/BpIyPIeQ1WPJaLez5skBOdq3DnalmfurbUeO
 SbhBEENXfpP7dPOzVAK7SrgW1MvVRth5ysAYgVauzoKpYgT9xBFbqwi3W4MTCDIgC1X9
 znupmoGIiXOaRPyquPzClQqR00ohxeeDiMpgRZjTKROzFjYb2nifIyKy/IqjsvO7GSQL
 IPBe1F65OLg1I0rja10iImjoURS2HRhfPmdytMEH7bOIPOayjecy2JcrRRn7vbfcGyed
 axhg==
X-Gm-Message-State: APjAAAUvmBsJ8gb0UqJWRBdLjsgG773ugRUR9+PhkZuzwFZRFDWoQUXa
 lS/vq+UvZuSs0NM8Ec2C/D0o54+3cupT/27KeL/zVTxDFJyY14/2MpFQHyk7wTKWx6qCRoif3Br
 nK0puEKMc/xdTDF5Emvhyt7YU3874BUk=
X-Received: by 2002:a9d:77c4:: with SMTP id w4mr5109567otl.40.1566577845682;
 Fri, 23 Aug 2019 09:30:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwS/MfEKW9qKRj1ZyJf7dwIqp/BoXsRFID4w3NcDb2/5XDDoclgIJhsgSrNaW4oxPhdM5kb0ox7XtW2H87Ss0Q=
X-Received: by 2002:a9d:77c4:: with SMTP id w4mr5109538otl.40.1566577845383;
 Fri, 23 Aug 2019 09:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
In-Reply-To: <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 23 Aug 2019 19:30:33 +0300
Message-ID: <CAMRbyyt5gAOzY7sTQc7_XE20-O4XunVjne2_2_1jmZtButc1eg@mail.gmail.com>
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
>
...

> >     >     > @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void
> >     *opaque)
> >     >     >                  /* posix_fallocate() doesn't set errno. */
> >     >     >                  error_setg_errno(errp, -result,
> >     >     >                                   "Could not preallocate ne=
w
> >     data");
> >     >     > +            } else if (current_length =3D=3D 0) {
> >     >     > +                allocate_first_block(fd);
> >     >
> >     >     Should posix_fallocate() not take care of precisely this?
> >     >
> >     >
> >     > Only if the filesystem does not support fallocate() (e.g. NFS <
> 4.2).
> >     >
> >     > In this case posix_fallocate() is doing:
> >     >
> >     >   for (offset +=3D (len - 1) % increment; len > 0; offset +=3D
> increment)
> >     >     {
> >     >       len -=3D increment;
> >     >       if (offset < st.st_size)
> >     >         {
> >     >           unsigned char c;
> >     >           ssize_t rsize =3D __pread (fd, &c, 1, offset);
> >     >           if (rsize < 0)
> >     >             return errno;
> >     >           /* If there is a non-zero byte, the block must have bee=
n
> >     >              allocated already.  */
> >     >           else if (rsize =3D=3D 1 && c !=3D 0)
> >     >             continue;
> >     >         }
> >     >       if (__pwrite (fd, "", 1, offset) !=3D 1)
> >     >         return errno;
> >     >     }
> >     >
> >     >
> >
> https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.ht=
ml#96
> >     >
> >     > So opening a file with O_DIRECT will break preallocation=3Dfalloc=
 on
> >     such
> >     > filesystems,
> >
> >     But won=E2=80=99t the function above just fail with EINVAL?
> >     allocate_first_block() is executed only in case of success.
> >
> >
> > Sure, but if posix_fallocate() fails, we fail qemu-img create/convert.
>
> Exactly.  But if posix_fallocate() works, it should have allocated the
> first block.
>

Only if the file system does not support fallocate(). posix_fallocate()
first try
fallocate(), and fall back to manual preallocation:
https://code.woboq.org/userspace/glibc/sysdeps/unix/sysv/linux/posix_falloc=
ate.c.html#27

Here is an example using fallocate --posix:

$ sudo mount -t glusterfs gluster1:/gv0 /tmp/gv0

(gv0 is gluster volume backed by XFS on top of VDO device with 4k sector
size)

$ fallocate -l 1g --posix empty.raw
$ dd if=3Dempty.raw bs=3D1 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone

$ dd if=3D/dev/zero bs=3D1 count=3D1 of=3Dempty.raw conv=3Dnotrunc status=
=3Dnone
$ dd if=3Dempty.raw bs=3D1 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone
dd: error reading 'empty.raw': Invalid argument

$ dd if=3Dempty.raw bs=3D512 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone
dd: error reading 'empty.raw': Invalid argument

$ dd if=3Dempty.raw bs=3D4096 count=3D1 of=3D/dev/null iflag=3Ddirect statu=
s=3Dnone

Here is example using gluster storage with sector size of 512 bytes.

$ sudo mount -t glusterfs gluster1:/gv1 /tmp/gv1

$ fallocate -l 1g --posix empty.raw
$ dd if=3Dempty.raw bs=3D1 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone

$ dd if=3D/dev/zero bs=3D1 count=3D1 of=3Dempty.raw conv=3Dnotrunc status=
=3Dnone

$ dd if=3Dempty.raw bs=3D1 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone
dd: error reading 'empty.raw': Invalid argument

$ dd if=3Dempty.raw bs=3D512 count=3D1 of=3D/dev/null iflag=3Ddirect status=
=3Dnone

So we must allocated using write() after calling posix_fallocate().

Nir
