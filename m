Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE2C606C5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96D12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tzCZiG/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96D12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkXY5-0003Zz-2h
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 13:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hkXV6-0001dN-0u
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hkXV5-0002cV-0U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:32:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hkXV2-0002VB-C3; Mon, 08 Jul 2019 13:32:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68HTIdF070612;
 Mon, 8 Jul 2019 17:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=TbNAHlRjxIbp2SEP53b193hmruioVlsOFpGoXJN5pzs=;
 b=tzCZiG/PNinL6MC4jgtwivQmeuhXIELlr0MRUQwNe2jAROkwF476x3RmjBTsorB8arI2
 6ExkGjurq8OW9QJIBT8HzESEyMgL2yZMPVWYU90yiCqCR1jaYxtqU7UQbpMa4DvF/xde
 9BrtLVdLg3kC+9NBSeBR1QGH/Okpg3QPqf9VujrtlQLpNheX+oFIZduhTTTpmy6x0+94
 iiKbuIVDaFbgkDKMKNt9ae6vWSjSTWF5Rh6N/RyZtpDNnDCg2s6i5qVC+sU1g8zh6IMK
 bChrJzNX6j/cTeHlqYEdNLIVsDmbcfeLQvAgomwPstybr1tvzQTdM1LaY/QRosTXdADq mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2tjkkpfsmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 17:32:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68HRbj5147563;
 Mon, 8 Jul 2019 17:30:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2tjhpcm125-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 17:30:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x68HUBIk012018;
 Mon, 8 Jul 2019 17:30:12 GMT
Received: from [10.0.0.38] (/79.181.134.95)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 08 Jul 2019 10:30:11 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
Date: Mon, 8 Jul 2019 20:30:06 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <424BE97C-7EAF-4B28-B580-AC2B5261197C@oracle.com>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080215
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080215
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 0/8] Add Qemu to SeaBIOS LCHS
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
Cc: kwolf@redhat.com, Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 Liran Alon <liran.alon@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Gerd,

Gentle ping on this.

Sam

> On 1 Jul 2019, at 10:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Wed, Jun 26, 2019 at 03:39:40PM +0300, Sam Eiderman wrote:
>> v1:
>>=20
>> Non-standard logical geometries break under QEMU.
>>=20
>> A virtual disk which contains an operating system which depends on
>> logical geometries (consistent values being reported from BIOS INT13
>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has =
non-standard
>> logical geometries - for example 56 SPT (sectors per track).
>> No matter what QEMU will guess - SeaBIOS, for large enough disks - =
will
>> use LBA translation, which will report 63 SPT instead.
>>=20
>> In addition we can not enforce SeaBIOS to rely on phyiscal geometries =
at
>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
>> report more than 16 physical heads when moved to an IDE controller, =
the
>> ATA spec allows a maximum of 16 heads - this is an artifact of
>> virtualization.
>>=20
>> By supplying the logical geometies directly we are able to support =
such
>> "exotic" disks.
>>=20
>> We will use fw_cfg to do just that.
>>=20
>> v2:
>>=20
>> Fix missing parenthesis check in
>>    "hd-geo-test: Add tests for lchs override"
>>=20
>> v3:
>>=20
>> * Rename fw_cfg key to "bios-geometry".
>> * Remove "extendible" interface.
>> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
>> * Fix last qtest commit - automatic docker tester for some reason =
does not have qemu-img set
>>=20
>> v4:
>>=20
>> * Change fw_cfg interface from mixed textual/binary to textual only
>>=20
>> v5:
>>=20
>> * Fix line > 80 chars in tests/hd-geo-test.c
>=20
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> cheers,
>  Gerd
>=20


