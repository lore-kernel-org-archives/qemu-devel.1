Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9DEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC1E20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mjR-0005Q7-0Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mih-0004wh-PJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mig-0002Wf-F8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:23:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18734
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9mig-0002WL-91
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:23:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0259KVYf102727
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 04:23:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj6nk9220-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:23:05 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 09:23:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 09:23:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0259N1xl50331734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 09:23:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F343242041;
 Thu,  5 Mar 2020 09:23:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C37744203F;
 Thu,  5 Mar 2020 09:23:00 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 09:23:00 +0000 (GMT)
Subject: Re: [PATCH v6 08/18] s390x: Add SIDA memory ops
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-9-frankja@linux.ibm.com>
 <0cfa4651-dc80-05de-94ce-78cccf7cd903@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 10:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0cfa4651-dc80-05de-94ce-78cccf7cd903@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e6h5eEXZ1LHep1auWx5GtixycjK5EsNtz"
X-TM-AS-GCONF: 00
x-cbid: 20030509-4275-0000-0000-000003A891C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030509-4276-0000-0000-000038BDA12B
Message-Id: <949848d6-4145-106d-ece8-6bbcf7fe9e7d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_02:2020-03-04,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=3
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050059
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e6h5eEXZ1LHep1auWx5GtixycjK5EsNtz
Content-Type: multipart/mixed; boundary="dZJmC133M7nZemRb2gjHczZxQlXGwlEJI"

--dZJmC133M7nZemRb2gjHczZxQlXGwlEJI
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 6:39 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> Protected guests save the instruction control blocks in the SIDA
>> instead of QEMU/KVM directly accessing the guest's memory.
>>
>> Let's introduce new functions to access the SIDA.
>=20
> "The new memops are available with KVM_CAP_S390_PROTECTED, so let's
> check for that."

Ack

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  linux-headers/linux/kvm.h |  2 ++
>>  target/s390x/cpu.h        |  7 ++++++-
>>  target/s390x/kvm.c        | 25 +++++++++++++++++++++++++
>>  target/s390x/kvm_s390x.h  |  2 ++
>>  target/s390x/mmu_helper.c | 14 ++++++++++++++
>>  5 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index e36f761194..c30344ab00 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -483,6 +483,8 @@ struct kvm_s390_mem_op {
>>  /* types for kvm_s390_mem_op->op */
>>  #define KVM_S390_MEMOP_LOGICAL_READ	0
>>  #define KVM_S390_MEMOP_LOGICAL_WRITE	1
>> +#define KVM_S390_MEMOP_SIDA_READ	2
>> +#define KVM_S390_MEMOP_SIDA_WRITE	3
>>  /* flags for kvm_s390_mem_op->flags */
>>  #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>>  #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>=20
> This should go into the header sync.

Ack

>=20
> [...]
>=20
>> index 7e4d9d267c..2578c838f8 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -824,7 +824,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr ladd=
r, uint8_t ar, void *hostbuf,
>>  #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
>>          s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
>>  void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
>> -
>> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset,  void *host=
buf,
>=20
> double space after "offset,"

Ack

>=20
> [...]
>=20
>> =20
>> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostb=
uf,
>> +                       int len, bool is_write)
>> +{
>> +    int ret;
>> +
>> +    if (kvm_enabled()) {
>> +        ret =3D kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_writ=
e);
>> +    } else {
>> +        /* Protected Virtualization is a KVM/Hardware only feature */=

>> +        g_assert_not_reached();
>> +    }
>> +    return ret;
>> +}
>=20
>=20
> I suspect nobody will ever check the return value, correct?
>=20
> With the things changed
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

>=20



--dZJmC133M7nZemRb2gjHczZxQlXGwlEJI--

--e6h5eEXZ1LHep1auWx5GtixycjK5EsNtz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5gxPQACgkQ41TmuOI4
ufi/Nw//Wb+dOElT4L5NdOdw4zUS8SOPtyptqRK2o88aCtbQGorMCea9A6cVM2T4
Ytq4KSZghLIpl3cA3exK1kg1iKxHPVCpKtqBv2fBrXOn6lUGG5s0SsAN1oLhd+en
SVl4Yl9GdJ5+5M7AZNf8BywWvCpIU/+FymKSCCM+9DFAFOpq8hYfZTEgwXuKWzfI
F6pjJJN226qPSrHkyVgg2PReNUyalDsermmHKgz7jnHGW4S84eZ5yCIt/6SY/r2E
myxhJGzLuVSd8Zxr7CFZQ1x0jiJQa+g2VefTa3i1chQcO8Pp5x3vyoK5BfI4Vkzv
qu2QGLf2d+iEPvsvXpojGzGNlgap/oV9VqOw0QRNTjSZDY6qH6VTMmR800w9OrGn
QauqtkR9insb3d0IW566kw8qk5bdu5TUbsCZ+npud+H0RSJdmVRdwFbl/BIfQDKC
NBMOm27OEbRaZDM3MucQMRxFHFi6tdkn1N67zhO9U4/F1UiP71MGeRUIpAmlSXIb
6tCtcRI0uWJDrpYcEOVLZGiEOcnQ3C1q9GjW3F+dLNWH0ubHbI9lMF73i54qCMfa
g3Sf0AwupveDP6CXyWQpAJdIdK30KUQnOJFOMWGstMm7G1JJ/GtxvRhbBeWP2eSV
FTdEkwKPqDOztqLA2jdaALw+vhgZ0e7ZLaTeSUiCafq1K3RdRyM=
=cUbY
-----END PGP SIGNATURE-----

--e6h5eEXZ1LHep1auWx5GtixycjK5EsNtz--


