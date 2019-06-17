Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9198C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1D021993
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqdYLQl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1D021993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcmci-0003ye-Ub
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 04:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37419)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hcmaa-0003Lj-Vz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hcmaZ-0008IZ-C6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:02:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hcmaT-00081p-SH; Mon, 17 Jun 2019 04:01:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H7wunK031836;
 Mon, 17 Jun 2019 08:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=iAa9PNiKdS4XfDmgI/Xy7/jOJpyLN+tjtD4fXkkwFgY=;
 b=eqdYLQl/Z68iXjV/9NAHIcGxZChGVELf1LNifZwx4gWd4+dNAsjYRRdnAjcpPeajR1O0
 FQZlCcwiEEP1bSawhvoGnyLWCJgjI5Jl2FNFU7zFrfpWu2Scy07f4pa2EpKgpMmorKww
 ywSIjWDyj/WHtLxteEMv3GF+kdbGSFT7KJd1P32GAcHvY1jn8RPaoc93YVTDeKnF/tXw
 C7EXNRKMh2wicPDshORSX0n1EvXkpYhg+qLxhgR4EhjqBPZ5NC3/f8her+au7BeL8+0c
 YGoWcdqH89wykmDck8E2zFO5KtfHGMJuaingVdk4+iIexjfBPqtITHbL5NPHyr61Ocqm tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t4saq4vgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 08:01:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5H7xSNf122908;
 Mon, 17 Jun 2019 07:59:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2t5h5t0d19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 07:59:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5H7xhA1014974;
 Mon, 17 Jun 2019 07:59:43 GMT
Received: from [10.0.5.157] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 07:59:43 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <28D338C3-AF42-4145-94A6-8C8175A23949@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Mon, 17 Jun 2019 10:59:36 +0300
In-Reply-To: <20190617065050.nx76n6625tm3d2oo@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
 <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
 <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
 <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
 <730C65DE-A9B4-4553-B6A0-7A3B81A1FA12@oracle.com>
 <20190614044310.wxnkwxagr23d5cbt@sirius.home.kraxel.org>
 <985C60F2-999C-44C6-B8BC-B5603DD0F716@oracle.com>
 <20190617065050.nx76n6625tm3d2oo@sirius.home.kraxel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 0/8] Add Qemu to SeaBIOS LCHS
 interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Kevin O'Connor <kevin@koconnor.net>, liran.alon@oracle.com,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Jun 2019, at 9:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>>> Ok, given that seabios has no setup any manual configuration needs =
to be done via qemu.
>>>=20
>>> But why do we need a new interface for that?  IDE can pass the =
geometry
>>> to the guest.  virtio-blk has support too (VIRTIO_BLK_F_GEOMETRY).
>>> Likewise scsi (MODE_PAGE_HD_GEOMETRY).  So this should be doable =
without
>>> any qemu changes.
>>=20
>> This was indeed considered (all 3 methods) but it has the following =
issues:
>>=20
>> Physical geometries of devices must now also be logical geometries =
with translation=3Dnone.
>=20
> Yes.
>=20
>> When the OS will query these devices - It will now see different =
physical geometries, adapted to be logical geometries.
>=20
> Yes.
>=20
>> I=E2=80=99m not sure even how to implement this without breaking =
existing
>> compatibility - since we don=E2=80=99t want to affect logical =
geometries of
>> currently used guests.
>=20
> We can copy the logic which calculates lchs from seabios to qemu and =
use
> it for pchs.
>=20
> The tricky part of this is how to do the switch without requiring a
> lockstep update of seabios and qemu.  seabios can't easily know =
whenever
> it should use the current logic (current qemu) or whenever it should
> simply use pchs with translation=3Dnone (updated qemu).
>=20
> Hmm ...
>=20
>> MODE_PAGE_HD_GEOMETRY does not contain the spts, only cylinders (as 3
>> byte number) and heads (as 1 byte number) and computes the spts =
using:
>=20
> Well, there also is MODE_PAGE_FLEXIBLE_DISK_GEOMETRY.
>=20
>> Moving a scsi-hd/virtio-blk with 255 physical heads to ide-hd, we =
will
>> still need to report 255 heads - this is possible since a whole byte
>> can be used in the =E2=80=9Cide identify=E2=80=9D command, but goes =
against the spec
>> of a maximum of 16 heads for IDE.
>=20
> Why do you want migrate _to_ IDE?

Even without migration, now under SeaBIOS probably most IDE disks
report 255 heads and 63 spts due to LBA translation, while exposing
up to 16 physical heads (IDE spec).
So you can=E2=80=99t really report in ATA identify command your wanted =
logical
heads (255).

This can be solved in a very complicated way:

For virtio-blk disks - report bios geometries as physical geometries.
This might break current compatibility (showing different physical =
geometries)
For scsi disks - report bios geometries as physical geometries.
Implement MODE_PAGE_FLEXIBLE_DISK_GEOMETRY and translation=3Dnone - this =
new interface will help with compatibility
For IDE disks - specially craft valid physical geometries (heads <=3D =
16) with a specific translation,
This is super complicated, for example to make an IDE disk report lchs =
of 32 heads, 56 spts, you need a physical geometry of 16 heads, 56 spts =
and report 2046 cylinders with a "large" translation - which will =
effectively cut down the number of cylinders by 2 to 1023 and multiply =
the heads by 2 to 32, achieving the desired lchs. Also we can not even =
make an IDE report 255 heads with 56 spts with any translation (this is =
an actual value from production) - so the disk must be moved to =
scsi-hd/virtio-blk - which also breaks compatibility.

This implementation creates 3 different non conventional (PV) ways of =
reporting lchs directly between Qemu and SeaBIOS - which add a lot of =
technical depth for resolving a legacy issue. A fw-cfg value named =
=E2=80=9Cbootdevices=E2=80=9D (or =E2=80=9Cbios-geometry=E2=80=9D) is =
much more straightforward and makes it more readable/explicit.

WDYT?

>=20
>> Overall this approach is much more complicated.
>=20
> Well, adding new fw_cfg interfaces has a long term maintenance cost.
> So there should be a pretty good reason for them.
>=20
> cheers,
>  Gerd
>=20

