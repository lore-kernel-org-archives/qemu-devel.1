Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508042076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508042076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojMc-0007lW-It
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jojLx-0007Ie-FX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:04:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54864
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jojLv-000665-JC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:04:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05Q81wB9029073
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:04:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31vtt41thp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:04:50 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05Q827ag030101
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:04:50 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31vtt41tg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 04:04:49 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05Q82AWc002724;
 Fri, 26 Jun 2020 08:04:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 31uuspsag2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2020 08:04:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05Q83Q4r61669712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2020 08:03:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B98B24C050;
 Fri, 26 Jun 2020 08:04:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 616804C04E;
 Fri, 26 Jun 2020 08:04:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.93])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2020 08:04:45 +0000 (GMT)
Subject: Re: [RFC v5 12/12] pc-bios: s390x: Cleanup jump to ipl code
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-13-frankja@linux.ibm.com>
 <48329294-4c31-a1fa-20fb-ef6bb13e8550@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Message-ID: <e7481a5a-fe2d-1823-011e-8b80d309a3fa@linux.ibm.com>
Date: Fri, 26 Jun 2020 10:04:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <48329294-4c31-a1fa-20fb-ef6bb13e8550@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4RiNxcns1J4ZxNs0vFjrsPBtRw2BGXIdS"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-26_04:2020-06-26,
 2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 cotscore=-2147483648
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 04:02:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4RiNxcns1J4ZxNs0vFjrsPBtRw2BGXIdS
Content-Type: multipart/mixed; boundary="G4QBJ8MnS5frcwvlovnRBbPjqXTiESwtV"

--G4QBJ8MnS5frcwvlovnRBbPjqXTiESwtV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/20 2:58 PM, Thomas Huth wrote:
> On 24/06/2020 09.52, Janosch Frank wrote:
>> jump_to_IPL_code takes a 64 bit address, masks it with the short psw
>> address mask and later branches to it using a full 64 bit register.
>>
>> * As the masking is not necessary, let's remove it
>> * Without the mask we can save the ipl address to a static 64 bit
>>    function ptr as we later branch to it
>> * Let's also clean up the variable names and remove the now unneeded
>>    ResetInfo
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/jump2ipl.c | 27 +++++++++++----------------
>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index 767012bf0c..aef37cea76 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -13,20 +13,15 @@
>>   #define KERN_IMAGE_START 0x010000UL
>>   #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>>  =20
>> -typedef struct ResetInfo {
>> -    uint64_t ipl_psw;
>> -    uint32_t ipl_continue;
>> -} ResetInfo;
>> -
>> -static ResetInfo save;
>> +static void (*ipl_continue)(void);
>> +static uint64_t psw_save;
>=20
> I wonder whether there was a reason for having ipl_continue in the=20
> lowcore instead of using a simple static function pointer... Christian,=
=20
> do you remember?
>=20
>>   static void jump_to_IPL_2(void)
>>   {
>> -    ResetInfo *current =3D 0;
>> +    uint64_t *psw_current =3D 0;
>=20
> Mhh, what about using uint64_t *psw_current =3D (uint64_t *)lowcore=20
> instead, to make it more more explicit?

Sure, that would make it way better to read.

>=20
>> -    void (*ipl)(void) =3D (void *) (uint64_t) current->ipl_continue;
>> -    *current =3D save;
>> -    ipl(); /* should not return */
>> +    *psw_current =3D psw_save;
>> +    ipl_continue(); /* should not return */
>>   }
>>  =20
>>   void jump_to_IPL_code(uint64_t address)
>> @@ -46,15 +41,15 @@ void jump_to_IPL_code(uint64_t address)
>>        * content of non-BIOS memory after we loaded the guest, so we
>>        * save the original content and restore it in jump_to_IPL_2.
>>        */
>> -    ResetInfo *current =3D 0;
>> +    uint64_t *psw_current =3D 0;
>=20
> dito.
>=20
>> -    save =3D *current;
>> +    psw_save =3D *psw_current;
>>  =20
>> -    current->ipl_psw =3D (uint64_t) &jump_to_IPL_2;
>> -    current->ipl_psw |=3D RESET_PSW_MASK;
>> -    current->ipl_continue =3D address & PSW_MASK_SHORT_ADDR;
>> +    *psw_current =3D (uint64_t) &jump_to_IPL_2;
>> +    *psw_current |=3D RESET_PSW_MASK;
>> +    ipl_continue =3D (void *)address;
>>  =20
>> -    debug_print_int("set IPL addr to", current->ipl_continue);
>> +    debug_print_int("set IPL addr to", (uint64_t)ipl_continue);
>>  =20
>>       /* Ensure the guest output starts fresh */
>>       sclp_print("\n");
>>
>=20
> The patch sounds like a good idea to me ... but since this code proofed=
=20
> to be very fragile in the past, let's wait for Christian to say whether=
=20
> there was a good reason for ipl_continue in the lowcore or not.

This is a RFC and will need a lot of testing.
I guess I'll move patch 11 and 12 of this series into a new one and also
fix some more boot related stuff so this becomes less maze like.

>=20
>   Thomas
>=20
>=20



--G4QBJ8MnS5frcwvlovnRBbPjqXTiESwtV--

--4RiNxcns1J4ZxNs0vFjrsPBtRw2BGXIdS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl71rBwACgkQ41TmuOI4
ufiJzhAArYPLNmmr18DRyGEhE84hG8SDfsM8h8thT5hqrr18fm5deuqxRs1rEw8j
Ca9al3alw0O88ao0QOYJdcY/PK0dr60eEGaVQ0VrLwBBWw/zjsbANYYrNifvuYqz
SFe7Lm4ZLslbEEQHILKRp9NckbKv8+nFfe2UJ3pfeUKqKpHtNoXmBBuDHwAwFT1t
cWVlRKcK2OAdv+i7OHxcA7EBpAaow/hcBUes8C6+7DWKZHaodPik0qJ1mbNoqM+X
r1VRB643iYGgrTaqfLg00TTKGfNMyOcgvvSCJSHe4QTAyX1IewM9OeoHqRy6XWRs
E0djNu3Ta1VZldIXsrBjB7hQqoH6zs2yl5PigYZZkMvWBc7dVM/2UYEId1aLWurg
9SJBJupx476oMX7kpVUtXTsKt/m5isBwFzSGGIwx5d/YzmD+4RDVApKM2w4IL94B
ABwiyCcG89Lnl+jtwMehPCPf5fru3xaCT2zpDR2OLvqCBx68RkdoJsoPsZ2pq29q
SKw9pocvLyGzzQeI0FUsphu2wQqNa+Q2o45wG7OH1a6GWv4j4r19zk7VGfdzpNVA
sa6odX7YxqinMUZXbd7khueyrLiTwpCgJ2ScRYsPr2eVB3my5nCwDHm+VtCrFnD/
lGwjc5EPIXuDiAJobVGyHXBEkqrnO8yeXblEy1z6xVmJC1ru9Vo=
=GPc6
-----END PGP SIGNATURE-----

--4RiNxcns1J4ZxNs0vFjrsPBtRw2BGXIdS--


