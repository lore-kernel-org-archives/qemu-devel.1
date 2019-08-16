Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEA4C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE1F21721
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylEB-0003gG-Pu
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylDS-0003Bs-Q3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylDR-0008Jj-CB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylDN-0008Hk-L7; Fri, 16 Aug 2019 19:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64CBA301A892;
 Fri, 16 Aug 2019 23:00:56 +0000 (UTC)
Received: from [10.18.17.187] (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9089D842A4;
 Fri, 16 Aug 2019 23:00:55 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <b24959b4-f2b2-d720-f8b5-4adc25b89278@redhat.com>
 <CAMRbyytThpP1KXPmJLpA_i3JLot7j9UshjcqRerkFtmN_T5Seg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c9805bc4-232b-aa72-2f48-878a7d1a55bb@redhat.com>
Date: Fri, 16 Aug 2019 19:00:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytThpP1KXPmJLpA_i3JLot7j9UshjcqRerkFtmN_T5Seg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 23:00:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: posix: Always allocate
 the first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/16/19 6:45 PM, Nir Soffer wrote:
> On Sat, Aug 17, 2019 at 12:57 AM John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>> wrote:
>=20
>     On 8/16/19 5:21 PM, Nir Soffer wrote:
>     > When creating an image with preallocation "off" or "falloc", the =
first
>     > block of the image is typically not allocated. When using Gluster
>     > storage backed by XFS filesystem, reading this block using direct=
 I/O
>     > succeeds regardless of request length, fooling alignment detectio=
n.
>     >
>     > In this case we fallback to a safe value (4096) instead of the op=
timal
>     > value (512), which may lead to unneeded data copying when alignin=
g
>     > requests.=C2=A0 Allocating the first block avoids the fallback.
>     >
>=20
>     Where does this detection/fallback happen? (Can it be improved?)
>=20
>=20
> In=C2=A0raw_probe_alignment().
>=20
> This patch explain the issues:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00568.html
>=20
> Here Kevin and me discussed ways to improve it:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00426.html
>=20

Thanks for the reading!
That does help explain this patch better.

>     > When using preallocation=3Doff, we always allocate at least one
>     filesystem
>     > block:
>     >
>     >=C2=A0 =C2=A0 =C2=A0$ ./qemu-img create -f raw test.raw 1g
>     >=C2=A0 =C2=A0 =C2=A0Formatting 'test.raw', fmt=3Draw size=3D107374=
1824
>     >
>     >=C2=A0 =C2=A0 =C2=A0$ ls -lhs test.raw
>     >=C2=A0 =C2=A0 =C2=A04.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16=
 23:48 test.raw
>     >
>     > I did quick performance tests for these flows:
>     > - Provisioning a VM with a new raw image.
>     > - Copying disks with qemu-img convert to new raw target image
>     >
>     > I installed Fedora 29 server on raw sparse image, measuring the t=
ime
>     > from clicking "Begin installation" until the "Reboot" button appe=
ars:
>     >
>     > Before(s)=C2=A0 After(s)=C2=A0 =C2=A0 =C2=A0Diff(%)
>     > -------------------------------
>     >=C2=A0 =C2=A0 =C2=A0 356=C2=A0 =C2=A0 =C2=A0 =C2=A0 389=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +8.4
>     >
>     > I ran this only once, so we cannot tell much from these results.
>     >
>=20
>     That seems like a pretty big difference for just having pre-allocat=
ed a
>     single block. What was the actual command line / block graph for
>     that test?
>=20
>=20
> Having the first block allocated changes the alignment.
>=20
> Before this patch, we detect request_alignment=3D1, so we fallback to 4=
096.
> Then we detect buf_align=3D1, so we fallback to value of request alignm=
ent.
>=20
> The guest see a disk with:
> logical_block_size =3D 512
> physical_block_size =3D 512
>=20
> But qemu uses:
> request_alignment =3D 4096
> buf_align =3D 4096
>=20
> storage uses:
> logical_block_size =3D 512
> physical_block_size =3D 512
>=20
> If the guest does direct I/O using 512 bytes aligment, qemu has to copy
> the buffer to align them to 4096 bytes.
>=20
> After this patch, qemu detects the alignment correctly, so we have:
>=20
> guest
> logical_block_size =3D 512
> physical_block_size =3D 512
>=20
> qemu
> request_alignment =3D 512
> buf_align =3D 512
>=20
> storage:
> logical_block_size =3D 512
> physical_block_size =3D 512
>=20
> We expect this to be more efficient because qemu does not have to emula=
te
> anything.
>=20
>     Was this over a network that could explain the variance?
>=20
>=20
> Maybe, this is complete install of Fedora 29 server, I'm not sure if th=
e
> installation=C2=A0
> access the network.
>=20
>     > The second test was cloning the installation image with qemu-img
>     > convert, doing 10 runs:
>     >
>     >=C2=A0 =C2=A0 =C2=A0for i in $(seq 10); do
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f dst.raw
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 10
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time ./qemu-img convert -f raw -=
O raw -t none -T none
>     src.raw dst.raw
>     >=C2=A0 =C2=A0 =C2=A0done
>     >
>     > Here is a table comparing the total time spent:
>     >
>     > Type=C2=A0 =C2=A0 Before(s)=C2=A0 =C2=A0After(s)=C2=A0 =C2=A0 Dif=
f(%)
>     > ---------------------------------------
>     > real=C2=A0 =C2=A0 =C2=A0 530.028=C2=A0 =C2=A0 469.123=C2=A0 =C2=A0=
 =C2=A0 -11.4
>     > user=C2=A0 =C2=A0 =C2=A0 =C2=A017.204=C2=A0 =C2=A0 =C2=A010.768=C2=
=A0 =C2=A0 =C2=A0 -37.4
>     > sys=C2=A0 =C2=A0 =C2=A0 =C2=A0 17.881=C2=A0 =C2=A0 =C2=A0 7.011=C2=
=A0 =C2=A0 =C2=A0 -60.7
>     >
>     > Here we see very clear improvement in CPU usage.
>     >
>=20
>     Hard to argue much with that. I feel a little strange trying to for=
ce
>     the allocation of the first block, but I suppose in practice "almos=
t no
>     preallocation" is indistinguishable from "exactly no preallocation"=
 if
>     you squint.
>=20
>=20
> Right.
>=20
> The real issue is that filesystems and block devices do not expose the
> alignment
> requirement for direct I/O, so we need to use these hacks and assumptio=
ns.
>=20
> With local XFS we use xfsctl(XFS_IOC_DIOINFO) to get request_alignment,
> but this does
> not help for XFS filesystem used by Gluster on the server side.
>=20
> I hope that Niels is working on adding similar ioctl for Glsuter, os it
> can expose the properties
> of the remote filesystem.
>=20
> Nir

That sounds quite a bit less hacky, but I agree we still have to do what
we can in the meantime.

(It looks like you've been hashing this out with Kevin for a while, so
I'm going to sheepishly defer to his judgment on this patch. While I
think it's probably a fine trade-off, I can't really say off-hand if
there's a better, more targeted way to accomplish it.)

--js

