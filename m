Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FC5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4BB2171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4BB2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvd3U-0007pV-Lp
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 03:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rjones@redhat.com>) id 1hvd2t-00073Y-Dm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1hvd2r-0007uJ-55
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1hvd2q-0007s3-Sf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:41:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4DD1309265B;
 Thu,  8 Aug 2019 07:41:06 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF93608A5;
 Thu,  8 Aug 2019 07:41:06 +0000 (UTC)
Date: Thu, 8 Aug 2019 08:41:05 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: ivo welch <ivo.welch@ucla.edu>
Message-ID: <20190808074105.GD3888@redhat.com>
References: <CAJrNScTufw-809ag5-DoqhDVJs4aRyYm9EQxSO4aqPVgT_+8gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJrNScTufw-809ag5-DoqhDVJs4aRyYm9EQxSO4aqPVgT_+8gA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 07:41:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Quick nbdkit question
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 02:30:18PM -0700, ivo welch wrote:
> hi richard---please forgive us.  another quickie.  we created an nbd
> device.  just a block device...no partitions, etc.  in the guest vm, we
> wrote a short C program that writes one sector (open file, fseek, fwrite,
> close file) and then does it again.  all is working just fine.  the host
> console (filter) prints out the write requests, as it should.  (we added
> some more print code.)
>=20
> but we are confused about that after the first [but not the second] write,
> we see about 30 (4096b) sector reads, starting from 4096, 12288, ... .
> (the file below has both the C code and the nbdkit messages.)

I guess it's happening because of readahead in the qemu NBD driver, or
generally in the QEMU block layer.  Eric or Kevin will probably have a
better idea.

> there is no file system layer here, just an nbdkit block device. what is
> reading sectors here?  is it the stdio.h library in the guest, something
> magic about access into an unformatted block device in the guest VM linux,
> or nbdkit itself?!     does this sound familiar?
>=20
> regards,
>=20
> /iaw
> --
> Ivo Welch (ivo.welch@ucla.edu)
> http://www.ivo-welch.info/

> #include<stdio.h>
>=20
> int main() {
> 	FILE *fp;
> 	char str[4096] =3D "THIS IS A TEST";
> =09
> 	fp =3D fopen("/dev/sdb", "r+");
> 	fseek(fp, -4096, SEEK_END);
> 	fwrite(str, 1, sizeof(str), fp);
> 	fclose(fp);
>=20
> 	fp =3D fopen("/dev/sdb", "r+");
> 	fseek(fp, -8192, SEEK_END);
> 	fwrite(str, 1, sizeof(str), fp);
> 	fclose(fp);
> }
>=20
>=20
>=20
>=20
> nbdkit: file.2: debug: filter: pwrite count=3D4096 offset=3D8589930496 fl=
ags=3D0x0
> nbdkit: file.2: debug:=20
>=20
>=20
> WRITE [4096:8589930496:0:0]: 'THIS IS A TEST.............................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E....................................'
>=20
>=20
>=20
> nbdkit: file.2: debug: pwrite count=3D4096 offset=3D8589930496 fua=3D0
> nbdkit: file.13: debug: filter: pread count=3D4096 offset=3D0 flags=3D0x0
> nbdkit: file.13: debug: pread count=3D4096 offset=3D0
> nbdkit: file.13: debug: filter: pread count=3D4096 offset=3D4096 flags=3D=
0x0
> nbdkit: file.13: debug: pread count=3D4096 offset=3D4096
> nbdkit: file.13: debug: filter: pread count=3D4096 offset=3D12288 flags=
=3D0x0
> nbdkit: file.13: debug: pread count=3D4096 offset=3D12288
> nbdkit: file.13: debug: filter: pread count=3D4096 offset=3D8589869056 fl=
ags=3D0x0
> nbdkit: file.13: debug: pread count=3D4096 offset=3D8589869056
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D8589930496 fla=
gs=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D8589930496
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D8589799424 fla=
gs=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D8589799424
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D8589901824 fla=
gs=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D8589901824
> nbdkit: file.6: debug: filter: pread count=3D4096 offset=3D8589803520 fla=
gs=3D0x0
> nbdkit: file.6: debug: pread count=3D4096 offset=3D8589803520
> nbdkit: file.6: debug: filter: pread count=3D4096 offset=3D8589729792 fla=
gs=3D0x0
> nbdkit: file.6: debug: pread count=3D4096 offset=3D8589729792
> nbdkit: file.10: debug: filter: pread count=3D4096 offset=3D8589631488 fl=
ags=3D0x0
> nbdkit: file.10: debug: pread count=3D4096 offset=3D8589631488
> nbdkit: file.10: debug: filter: pread count=3D4096 offset=3D8589586432 fl=
ags=3D0x0
> nbdkit: file.10: debug: pread count=3D4096 offset=3D8589586432
> nbdkit: file.8: debug: filter: pread count=3D4096 offset=3D8589557760 fla=
gs=3D0x0
> nbdkit: file.8: debug: pread count=3D4096 offset=3D8589557760
> nbdkit: file.0: debug: filter: pread count=3D4096 offset=3D8589467648 fla=
gs=3D0x0
> nbdkit: file.0: debug: pread count=3D4096 offset=3D8589467648
> nbdkit: file.3: debug: filter: pread count=3D4096 offset=3D8589434880 fla=
gs=3D0x0
> nbdkit: file.3: debug: pread count=3D4096 offset=3D8589434880
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D8589426688 fla=
gs=3D0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D8589426688
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D8589447168 fla=
gs=3D0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D8589447168
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D8588353536 fla=
gs=3D0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D8588353536
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D16384 flags=3D=
0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D16384
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D32768 flags=3D=
0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D32768
> nbdkit: file.9: debug: filter: pread count=3D4096 offset=3D65536 flags=3D=
0x0
> nbdkit: file.9: debug: pread count=3D4096 offset=3D65536
> nbdkit: file.14: debug: filter: pread count=3D4096 offset=3D131072 flags=
=3D0x0
> nbdkit: file.14: debug: pread count=3D4096 offset=3D131072
> nbdkit: file.14: debug: filter: pread count=3D4096 offset=3D262144 flags=
=3D0x0
> nbdkit: file.14: debug: pread count=3D4096 offset=3D262144
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D524288 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D524288
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D1048576 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D1048576
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D2097152 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D2097152
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D4194304 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D4194304
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D28672 flags=3D=
0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D28672
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D61440 flags=3D=
0x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D61440
> nbdkit: file.1: debug: filter: pread count=3D4096 offset=3D8192 flags=3D0=
x0
> nbdkit: file.1: debug: pread count=3D4096 offset=3D8192
> nbdkit: file.1: debug: filter: pread count=3D8192 offset=3D20480 flags=3D=
0x0
> nbdkit: file.1: debug: pread count=3D8192 offset=3D20480
> nbdkit: file.1: debug: filter: pread count=3D24576 offset=3D36864 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D24576 offset=3D36864
> nbdkit: file.1: debug: filter: pread count=3D61440 offset=3D69632 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D61440 offset=3D69632
> nbdkit: file.1: debug: filter: pread count=3D126976 offset=3D135168 flags=
=3D0x0
> nbdkit: file.1: debug: pread count=3D126976 offset=3D135168
> nbdkit: file.12: debug: filter: pread count=3D258048 offset=3D266240 flag=
s=3D0x0
> nbdkit: file.12: debug: pread count=3D258048 offset=3D266240
> nbdkit: file.13: debug: filter: pread count=3D16384 offset=3D8589410304 f=
lags=3D0x0
> nbdkit: file.13: debug: pread count=3D16384 offset=3D8589410304
> nbdkit: file.13: debug: filter: pread count=3D4096 offset=3D8589430784 fl=
ags=3D0x0
> nbdkit: file.13: debug: pread count=3D4096 offset=3D8589430784
> nbdkit: file.13: debug: filter: pread count=3D8192 offset=3D8589438976 fl=
ags=3D0x0
> nbdkit: file.13: debug: pread count=3D8192 offset=3D8589438976
> nbdkit: file.13: debug: filter: pread count=3D16384 offset=3D8589451264 f=
lags=3D0x0
> nbdkit: file.13: debug: pread count=3D16384 offset=3D8589451264
> nbdkit: file.13: debug: filter: pread count=3D86016 offset=3D8589471744 f=
lags=3D0x0
> nbdkit: file.13: debug: pread count=3D86016 offset=3D8589471744
> nbdkit: file.6: debug: filter: pread count=3D24576 offset=3D8589561856 fl=
ags=3D0x0
> nbdkit: file.6: debug: pread count=3D24576 offset=3D8589561856
> nbdkit: file.15: debug: filter: pread count=3D40960 offset=3D8589590528 f=
lags=3D0x0
> nbdkit: file.15: debug: pread count=3D40960 offset=3D8589590528
> nbdkit: file.10: debug: filter: pread count=3D36864 offset=3D8589635584 f=
lags=3D0x0
> nbdkit: file.10: debug: pread count=3D36864 offset=3D8589635584
> nbdkit: file.8: debug: filter: pread count=3D57344 offset=3D8589672448 fl=
ags=3D0x0
> nbdkit: file.8: debug: pread count=3D57344 offset=3D8589672448
> nbdkit: file.0: debug: filter: pread count=3D65536 offset=3D8589733888 fl=
ags=3D0x0
> nbdkit: file.0: debug: pread count=3D65536 offset=3D8589733888
> nbdkit: file.3: debug: filter: pread count=3D61440 offset=3D8589807616 fl=
ags=3D0x0
> nbdkit: file.3: debug: pread count=3D61440 offset=3D8589807616
> nbdkit: file.2: debug: filter: pread count=3D28672 offset=3D8589873152 fl=
ags=3D0x0
> nbdkit: file.2: debug: pread count=3D28672 offset=3D8589873152
> nbdkit: file.7: debug: filter: pread count=3D20480 offset=3D8589905920 fl=
ags=3D0x0
> nbdkit: file.7: debug: pread count=3D20480 offset=3D8589905920
> nbdkit: file.11: debug: filter: pwrite count=3D4096 offset=3D8589926400 f=
lags=3D0x0
> nbdkit: file.11: debug:=20
>=20
>=20
> WRITE [4096:8589926400:0:0]: 'THIS IS A TEST.............................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E........................................................................=
=2E....................................'
>=20
>=20
>=20
> nbdkit: file.11: debug: pwrite count=3D4096 offset=3D8589926400 fua=3D0
>=20

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/

