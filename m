Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA74ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E230B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1Jc7F57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E230B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9fl-0006Nk-VH
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8qq-0003cS-1m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8ql-00044e-Rx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:42:09 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL8qk-000436-9V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:42:07 -0400
Received: by mail-ot1-x336.google.com with SMTP id g13so2445251otp.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ImJuusDGi4eR4FFrZ4o4A9dfQALm/qiGsIeX8RySX70=;
 b=P1Jc7F57aRloPO67hH8E8EcT5KvpOLHFeGTZ4tFmjUHUCntCs4TXleKuu2TAYXphK6
 Ngfv2yq4Co0HFssej1IVGUV7JhUOqhkFHwjBMbfqFivDTSnwX995vuRWu70krOlTAaTl
 Zk4utvitS1AOo7dHi+8YApsiqFoJHqp6huUxgGDtybbeYNaf4p+zpo/UXOYE2sVhLUvM
 CEpBYnP79yKr5v8UY6xpBDwcrYDLm9WSRfypFl7lGLJC/kA3RsYix4TZmkZw1L8edE0M
 jB75Nm96xLfQPekLNHruMl7qVUGtSGWyVLUXSQsMcW8OfsTmjdVD5q7Ba2QqD1Biw2JS
 v6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ImJuusDGi4eR4FFrZ4o4A9dfQALm/qiGsIeX8RySX70=;
 b=QzqxxsIjAVUTcIUuYjeZ4G4GZ0U+1LH/59r9KeI7GRtMId3ukWtnXGaEaz/ptTxzSI
 68v6g+k2Xkph5P1ABbmMhRTZdmfpapqoaK4ch0gAFezX6oR1QdIv6WGREcZG1LjKWVTu
 mXEPxUwJ0oWKGma7zovrp/rvyadCnH29Y7QIUR0gGQ1evCDwHKqSLUgmro4hNxozipcx
 3IcX2+9C9emmpSkIpfEq62UM8FzEO51+zHQ66CCAVo83yZMAZO9Gio604OWyyvyoriMC
 Lr6v/s72Ai9Kb5iYcmKLmyLqQg1GpKTXJHdplWMHlIcL2UJ8YNZr82bbhbXzO6CiUwCi
 pxzw==
X-Gm-Message-State: APjAAAXNT8blZ9UCIOk2KuAL33CqTpgXnBVYxZ0ekGuDs39/7mtOL4Pu
 EDsrG3eUEFSWUVRbgvJj6zytuYA9Ifr4wAtjQ0h/Sv9Vcj0=
X-Google-Smtp-Source: APXvYqzHl6wyFTieJCowF9JuU1i4ho2TZoVn96b588uhp0aH4zJw78zcUrWqMqf6x5SuV+0D4zyZGCqDiQ0aBwD/6qw=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr3638814oto.221.1571330521865; 
 Thu, 17 Oct 2019 09:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8fwM03PXzkMvLdOWAL0R1Mq8hLmt8O-+NFSri6oHun1w@mail.gmail.com>
 <010553d9-9dc6-907f-fc74-4cd5614f4a0e@redhat.com>
In-Reply-To: <010553d9-9dc6-907f-fc74-4cd5614f4a0e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 17:41:50 +0100
Message-ID: <CAFEAcA89CTV2jfv5chWH3fdCFS55CqMjqQ4MwFGwFumaqig6RA@mail.gmail.com>
Subject: Re: iotest failure -- test possibly not using sufficiently unique
 temp filename?
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 17:44, Max Reitz <mreitz@redhat.com> wrote:
>
> On 27.09.19 18:39, Peter Maydell wrote:
> > Hi; I just saw this iotest failure (on an s390x box, as it happens):
> >
> >   TEST    iotest-qcow2: 130 [fail]
> > QEMU          --
> > "/home/linux1/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/qem=
u-system-s390x"
> > -nodefaults -display none -machine accel=3Dqtest
> > QEMU_IMG      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../=
qemu-img"
> > QEMU_IO       --
> > "/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-io"
> > --cache writeback -f qcow2
> > QEMU_NBD      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../=
qemu-nbd"
> > IMGFMT        -- qcow2 (compat=3D1.1)
> > IMGPROTO      -- file
> > PLATFORM      -- Linux/s390x lxub05 4.15.0-58-generic
> > TEST_DIR      -- /home/linux1/qemu/build/all/tests/qemu-iotests/scratch
> > SOCKET_SCM_HELPER --
> > /home/linux1/qemu/build/all/tests/qemu-iotests/socket_scm_helper
> >
> > --- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
> > 12:27:16.948075733 -0400
> > +++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
> > 2019-09-27 12:01:23.649722655 -0400
> > @@ -18,20 +18,22 @@
> >  QEMU X.Y.Z monitor - type 'help' for more information
> >  (qemu) commit testdisk
> >  (qemu)
> > -image: TEST_DIR/t.IMGFMT
> > -file format: IMGFMT
> > -virtual size: 64 MiB (67108864 bytes)
> > -backing file: TEST_DIR/t.IMGFMT.orig
> > -backing file format: raw
> > +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "wr=
ite" lock
> > +Is another process using the image [TEST_DIR/t.IMGFMT]?
> >
> >  =3D=3D=3D Marking image dirty (lazy refcounts) =3D=3D=3D
> >
> > +qemu-img: TEST_DIR/t.IMGFMT: Failed to get "write" lock
> > +Is another process using the image [TEST_DIR/t.IMGFMT]?
> >  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> > -wrote 4096/4096 bytes at offset 0
> > -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +qemu-io: can't open device
> > /home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2: Failed
> > to get "write" lock
> > +Is another process using the image
> > [/home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2]?
> > +no file open, try 'help open'
> >  image: TEST_DIR/t.IMGFMT
> >  file format: IMGFMT
> >  virtual size: 64 MiB (67108864 bytes)
> > +backing file: TEST_DIR/t.IMGFMT.orig
> > +backing file format: raw
> >  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> > backing_file=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
> >  wrote 4096/4096 bytes at offset 0
> >  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >
> >
> >
> > This looks suspiciously like the test isn't using a unique
> > filename for its disk image: "qemu-iotests/scratch/t.qcow2"
> > in the build directory, and so perhaps it has collided with
> > another iotest ?
> >
> > If we run 'make check' with a -j<something> option do the
> > iotests all get run serially anyway, or do they run in
> > parallel against each other ?
>
> As far as I know, all iotests are executed serially.  Anything else
> would not work with the same scratch directory.
>
> The only thing I suspect is that some tool has been accidentally left
> running by some previous test that still accesses its own image.  But I
> don=E2=80=99t know.

Just saw this one again with the same iotest 130 on the same
s390 box; only difference is that the log this time around
has the first part where qemu-img fails, but not the second part
where qemu-io fails:

--- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
12:27:16.948075733 -0400
+++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
2019-10-17 11:56:43.450750873 -0400
@@ -18,11 +18,8 @@
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)
-image: TEST_DIR/t.IMGFMT
-file format: IMGFMT
-virtual size: 64 MiB (67108864 bytes)
-backing file: TEST_DIR/t.IMGFMT.orig
-backing file format: raw
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "write"=
 lock
+Is another process using the image [TEST_DIR/t.IMGFMT]?

 =3D=3D=3D Marking image dirty (lazy refcounts) =3D=3D=3D

On the host machine there don't seem to be any stray
processes which might have held the file open, and
indeed the file doesn't exist at all, so it got removed
by some cleanup or other.

thanks
-- PMM

