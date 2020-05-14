Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1D020722
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1D020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZC75-0004ge-Hg
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jZC62-0003jk-Tf; Thu, 14 May 2020 07:32:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jZC60-0007q9-Bz; Thu, 14 May 2020 07:32:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04EB3LOK113662; Thu, 14 May 2020 07:32:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310tjp276p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 07:32:10 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EBG2l8150821;
 Thu, 14 May 2020 07:32:09 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310tjp275d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 07:32:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EBPUhC022721;
 Thu, 14 May 2020 11:32:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 3100ubbhh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 11:32:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04EBW4ap62062786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 11:32:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2F3EA404D;
 Thu, 14 May 2020 11:32:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EC43A4053;
 Thu, 14 May 2020 11:32:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.183.194])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 14 May 2020 11:32:04 +0000 (GMT)
Subject: Re: [PATCH 7/8] pc-bios: s390x: Replace 0x00 with 0x0 or 0
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <20200324150847.10476-8-frankja@linux.ibm.com>
 <d15ab683-b1eb-22b8-fb77-fcaf1d1f318e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bf072c40-2a37-a587-297a-c2a1109498e1@linux.ibm.com>
Date: Thu, 14 May 2020 13:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d15ab683-b1eb-22b8-fb77-fcaf1d1f318e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TjCBNvkwWXNX1Kx5HQbYyGRQQcB66HOgq"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_02:2020-05-14,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 mlxlogscore=880 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 07:20:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TjCBNvkwWXNX1Kx5HQbYyGRQQcB66HOgq
Content-Type: multipart/mixed; boundary="52YKfomd4LeFskzUd795Wg10cup4M2o5G"

--52YKfomd4LeFskzUd795Wg10cup4M2o5G
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/30/20 5:36 PM, David Hildenbrand wrote:
> On 24.03.20 16:08, Janosch Frank wrote:
>> 0x00 looks odd, time to replace it with 0 or 0x0 (for pointers).
>=20
> s/0x0/NULL/ ?

I'd like to avoid NULL if I refer to offset 0 of the memory and only use
it to indicate that I purposely do not assign any specific value to a
pointer.


>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/dasd-ipl.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c=

>> index b932531e6f838405..764ee89e92e3ae8d 100644
>> --- a/pc-bios/s390-ccw/dasd-ipl.c
>> +++ b/pc-bios/s390-ccw/dasd-ipl.c
>> @@ -98,18 +98,18 @@ static int run_dynamic_ccw_program(SubChannelId sc=
hid, uint16_t cutype,
>> =20
>>  static void make_readipl(void)
>>  {
>> -    Ccw0 *ccwIplRead =3D (Ccw0 *)0x00;
>> +    Ccw0 *ccwIplRead =3D (Ccw0 *)0x0;
>> =20
>>      /* Create Read IPL ccw at address 0 */
>>      ccwIplRead->cmd_code =3D CCW_CMD_READ_IPL;
>> -    ccwIplRead->cda =3D 0x00; /* Read into address 0x00 in main memor=
y */
>> +    ccwIplRead->cda =3D 0x0; /* Read into address 0x00 in main memory=
 */
>>      ccwIplRead->chain =3D 0; /* Chain flag */
>>      ccwIplRead->count =3D 0x18; /* Read 0x18 bytes of data */
>>  }
>> =20
>>  static void run_readipl(SubChannelId schid, uint16_t cutype)
>>  {
>> -    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
>> +    if (do_cio(schid, cutype, 0x0, CCW_FMT0)) {
>>          panic("dasd-ipl: Failed to run Read IPL channel program\n");
>>      }
>>  }
>> @@ -133,10 +133,10 @@ static void check_ipl2(uint32_t ipl2_addr)
>>  {
>>      Ccw0 *ccw =3D u32toptr(ipl2_addr);
>> =20
>> -    if (ipl2_addr =3D=3D 0x00) {
>> +    if (ipl2_addr =3D=3D 0) {
>>          panic("IPL2 address invalid. Is this disk really bootable?\n"=
);
>>      }
>> -    if (ccw->cmd_code =3D=3D 0x00) {
>> +    if (ccw->cmd_code =3D=3D 0) {
>>          panic("IPL2 ccw data invalid. Is this disk really bootable?\n=
");
>>      }
>>  }
>> @@ -161,7 +161,7 @@ static void ipl1_fixup(void)
>>      memcpy(ccwRead, (void *)0x08, 16);
>> =20
>>      /* Disable chaining so we don't TIC to IPL2 channel program */
>> -    ccwRead->chain =3D 0x00;
>> +    ccwRead->chain =3D 0;
>> =20
>>      ccwSeek->cmd_code =3D CCW_CMD_DASD_SEEK;
>>      ccwSeek->cda =3D ptr2u32(seekData);
>> @@ -206,7 +206,7 @@ static void run_ipl2(SubChannelId schid, uint16_t =
cutype, uint32_t addr)
>>   */
>>  void dasd_ipl(SubChannelId schid, uint16_t cutype)
>>  {
>> -    PSWLegacy *pswl =3D (PSWLegacy *) 0x00;
>> +    PSWLegacy *pswl =3D (PSWLegacy *) 0x0;
>>      uint32_t ipl2_addr;
>> =20
>>      /* Construct Read IPL CCW and run it to read IPL1 from boot disk =
*/
>>
>=20
>=20



--52YKfomd4LeFskzUd795Wg10cup4M2o5G--

--TjCBNvkwWXNX1Kx5HQbYyGRQQcB66HOgq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl69LDQACgkQ41TmuOI4
ufiOhxAAn4bz3QPMl+T+wK6btvllC6VGRA5RIlnaMdUSbmPKoeOGwvXzdUb55lGn
RlvksbSuE8yuBgPR1zQ6ipwaM9UwxmQRm11rrV/q+hTKiOuIg0Uttrb0zv6HN8ay
KexaY92VhVXP2Q7wa9Xb3BEOSMqeC8PvSgMKfVXm9H8F+rMBzVZ3w3qydc2P7lhb
P0zuIV4+f/BBEUsQWwRGSS6vA4yO1uA6ma7KYUfrW+jpSYWwjvSdXWS001nTRcQG
gmqwC640snIh1JRbaMzONjyPHD6fYF1y+ZkAUKONRZ4Yu2mylJbOC/C8bK5q9YhO
gTixWHiHDrbyM5U/VVVZnk/8OwF9UePijD0MT3ezJRlVa91XrLMU/MffYh5k6Jiq
GGiMsobj1aCiUBZMp9GgzVfca+Isff8pyGtf0CKn7FZge8xX/dT0ZasX7MqSZmX/
CfB+OlOVTjeSCBo6XHA82nxCjDVoJ54xTzVkwOUIJI3FI2DtGHtb/CIXSSSddWCL
XHGZrTsNOXVwj2uS6yttqaHn8OrvHx65OUTpzDttJUFbWQI9me3D/MIdKYVhshRE
d3ntMd53muVAwVSlQiQ0+z0X4iUdANkbwKAGhoV4pkf6wHr3zHpyDHVhvln4Qylo
NRn//IUgUmC2ewurQDtRT2w4F2c8dwLHAe7Xaw9bIhyBRcPsS8Y=
=PVjs
-----END PGP SIGNATURE-----

--TjCBNvkwWXNX1Kx5HQbYyGRQQcB66HOgq--


