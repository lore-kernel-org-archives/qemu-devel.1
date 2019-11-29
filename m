Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D5AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEC02084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEC02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeoZ-0003MM-Qr
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iaeFe-0004Wk-Ul
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iaeFc-0007OO-Rc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:15:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58754
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iaeFb-0007K1-Sk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:15:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATBCTXe018574
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:15:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wjwqx8ka2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:15:46 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 11:15:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 11:15:41 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xATBFe2e35061860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 11:15:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1AA74203F;
 Fri, 29 Nov 2019 11:15:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BE484205C;
 Fri, 29 Nov 2019 11:15:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 11:15:39 +0000 (GMT)
Subject: Re: [PATCH v2 07/13] s390x: protvirt: SCLP interpretation
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-8-frankja@linux.ibm.com>
 <e2e732cb-dafd-5038-abc6-bd273ceec062@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 29 Nov 2019 12:15:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e2e732cb-dafd-5038-abc6-bd273ceec062@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7qYSiI5mzXdVEzR9JrxlxceVy7YvSQAkL"
X-TM-AS-GCONF: 00
x-cbid: 19112911-0028-0000-0000-000003C19615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112911-0029-0000-0000-00002484A478
Message-Id: <009ff19d-9674-4694-9c5b-243198d3766a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_03:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qYSiI5mzXdVEzR9JrxlxceVy7YvSQAkL
Content-Type: multipart/mixed; boundary="OJbywjEWdHYIi0bNG0We0g30tvgbzBMjE"

--OJbywjEWdHYIi0bNG0We0g30tvgbzBMjE
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 11:43 AM, David Hildenbrand wrote:
> On 29.11.19 10:48, Janosch Frank wrote:
>> SCLP for a protected guest is done over the SIDAD, so we need to use
>> the s390_cpu_virt_mem_* functions to access the SIDAD instead of guest=

>> memory when reading/writing SCBs.
>=20
> ... Can you elaborate a bit more how that is going to be used? Did you
> hack in special memory access to something called "SIDAD" via
> s390_cpu_virt_mem_*?

For secure guests we can't ever access virtual guest memory, since we
have no access to the guest translation tables.

Hence we have the satellite block (SIDA) as a bounce buffer. SIE will
bounce referenced blocks of data (like the SCCB) over the SIDA.

The virt_mem functions go through the KVM mem op API. A KVM patch
reroutes mem op access to the SIDA. The alternative would be to map the
SIDA into vcpu_run.

>=20
> I'd suggest a different access path ... especially because
>=20
> a) it's confusing

Granted, there's a lot of inherent knowledge behind these patches.
And looking at my past answers to the KVM intercept patch I already
forgot lots of it.

> b) it's unclear how exceptions apply

There are no PGM exceptions, as they are pre-checked and reported by
SIE. There are however errors that the mem op API can return.

>=20
> ...
>=20
>>
>> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
>> since the function that injects the sclp external interrupt would
>> reject a zero sccb address.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c         | 17 +++++++++++++++++
>>  include/hw/s390x/sclp.h |  2 ++
>>  target/s390x/kvm.c      |  5 +++++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index f57ce7b739..ca71ace664 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -193,6 +193,23 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *=
sccb, uint32_t code)
>>      }
>>  }
>> =20
>> +#define SCLP_PV_DUMMY_ADDR 0x4000
>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>> +                                uint32_t code)
>> +{
>> +    SCLPDevice *sclp =3D get_sclp_device();
>> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>> +    SCCB work_sccb;
>> +    hwaddr sccb_len =3D sizeof(SCCB);
>> +
>> +    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_l=
en);
>> +    sclp_c->execute(sclp, &work_sccb, code);
>> +    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
>> +                            be16_to_cpu(work_sccb.h.length));
>=20
> this access itself without handling exceptions looks dangerous as it is=

> completely unclear what's happening here.

See above

>=20
>> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>> +    return 0;
>> +}
>> +
>>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t cod=
e)
>>  {
>>      SCLPDevice *sclp =3D get_sclp_device();
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index c54413b78c..c0a3faa37d 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>>  void sclp_service_interrupt(uint32_t sccb);
>>  void raise_irq_cpu_hotplug(void);
>>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t cod=
e);
>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>> +                                uint32_t code);
>> =20
>>  #endif
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 3d9c44ba9d..b802d02ff5 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1174,6 +1174,11 @@ static void kvm_sclp_service_call(S390CPU *cpu,=
 struct kvm_run *run,
>>      sccb =3D env->regs[ipbh0 & 0xf];
>>      code =3D env->regs[(ipbh0 & 0xf0) >> 4];
>> =20
>> +    if (run->s390_sieic.icptcode =3D=3D ICPT_PV_INSTR) {
>=20
> isn't checking against env->pv easier and cleaner?

Hmm, I dislike checking a global state for a CPU icpt.

>=20
>=20



--OJbywjEWdHYIi0bNG0We0g30tvgbzBMjE--

--7qYSiI5mzXdVEzR9JrxlxceVy7YvSQAkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3g/doACgkQ41TmuOI4
ufjScg/9FD0WgxNrWANJiBY5MDRQWxDZEeX/XsNwd9SCcbANe8F9kmeNnbO16ZlQ
ASQtGVhMpJoupjfBuARXKH4y/mz6hUWmJu4EcgnKmSw7XMD15MLl7VmIElPkqOVt
I0jVfKgfB1Zag/o/Cvv+9hROYuwbWppoaZ/qCexJRE/j3B0dVq/2i5NwS9uIW9pE
Dl6+0c0yqmMpSt16KaFLw/jH5LEQk+2KAE38dYt+j06rMpWPz0JbIxV357cAMxCn
CKk4iIAbsIG+U+1WAdUma5CG5W3j9lG6BnWzNJHGqOBnHqpqA2OD+QjuwuqkvfWB
RBUF2tQ5L6WhqSYULHHbnIfuit+f0XG77iVTfu0A556Bao3w/E105fTk7KCSB5td
faM8J6xiHIzZfbE7t6pMNTELglDDrZkB/epVqpjlB+dRK+7IsJDLK+IW7KGjdL88
Q5KNMjLP2ocumVoO3lE3PNd/mgg1e0AoeSmQxRvY4626661g91g0E9qVw4HD8Dxq
6C/c7JGwyBIrmswOD2pPgqMKSWNVacJvQZP4Fr1CSnuwRlE1VPuFAw9qNJssQRd4
X4slBwU0CVkvdCEglTbADiSzyM/0fHiAXFxACd8Z4wu4vN4fmwW5MreYg3U1fAsP
wbgdIkegqlUmXORtddOxmpuR1iPutq/JMt2ooijEdzOE9epn0bk=
=qJ1w
-----END PGP SIGNATURE-----

--7qYSiI5mzXdVEzR9JrxlxceVy7YvSQAkL--


