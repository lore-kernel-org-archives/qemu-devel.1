Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F9DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FD12173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FD12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42qe-0002I1-VX
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j42j0-0000nm-53
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j42iy-0007Ok-SQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:15:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j42iy-0007OQ-KA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:15:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01IDA8ZA074530
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:15:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2ff3fm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:15:39 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 18 Feb 2020 13:15:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 18 Feb 2020 13:15:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01IDFXBN52232224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2020 13:15:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C329AE053;
 Tue, 18 Feb 2020 13:15:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E00CFAE051;
 Tue, 18 Feb 2020 13:15:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.50.32])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 18 Feb 2020 13:15:32 +0000 (GMT)
Subject: Re: [PATCH v3 00/17] s390x: Protected Virtualization support
To: Cornelia Huck <cohuck@redhat.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200218141304.1c6f82b0.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 18 Feb 2020 14:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200218141304.1c6f82b0.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kDOFXwlPbB8LhI2KIv4tjbCS9kz99W2nj"
X-TM-AS-GCONF: 00
x-cbid: 20021813-0020-0000-0000-000003AB4882
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021813-0021-0000-0000-0000220343C9
Message-Id: <eb666097-dab1-c545-22ca-d270155bd752@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-18_02:2020-02-17,
 2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kDOFXwlPbB8LhI2KIv4tjbCS9kz99W2nj
Content-Type: multipart/mixed; boundary="JMEH5vsP2ClH1v29hr86zhOfNEU80BG2G"

--JMEH5vsP2ClH1v29hr86zhOfNEU80BG2G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/18/20 2:13 PM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 10:16:19 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Most of the QEMU changes for PV are related to the new IPL type with
>> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to=

>> IPL secure guests. Note that we can only boot into secure mode from
>> normal mode, i.e. stfle 161 is not active in secure mode.
>>
>> The other changes related to data gathering for emulation and
>> disabling addressing checks in secure mode, as well as CPU resets.
>=20
> Does it make sense to start looking at this series now, or I should I
> wait until review on the kernel side has settled? (I've lost track of
> the state of the interfaces...)

There won't be too many change because of KVM review.
Most noteworthy is the switch from vm/vcpu create to a global switch
through the VM, but that's just merging IOCTLs.

>=20
>>
>> V3:
>> 	* Use dedicated functions to access SIDA
>> 	* Smaller cleanups and segfault fixes
>> 	* Error reporting for Ultravisor calls
>> 	* Inject of RC of diag308 subcode 10 fails
>>
>> V2:
>> 	* Split out cleanups
>> 	* Internal PV state tracking
>> 	* Review feedback
>>
>> Janosch Frank (17):
>>   Header sync
>>   s390x: Add missing vcpu reset functions
>>   Sync pv
>>   s390x: protvirt: Add diag308 subcodes 8 - 10
>>   s390x: protvirt: Support unpack facility
>>   s390x: protvirt: Add migration blocker
>>   s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
>>   s390x: protvirt: KVM intercept changes
>>   s390: protvirt: Move STSI data over SIDAD
>>   s390x: Add SIDA memory ops
>>   s390x: protvirt: SCLP interpretation
>>   s390x: protvirt: Set guest IPL PSW
>>   s390x: protvirt: Move diag 308 data over SIDAD
>>   s390x: protvirt: Disable address checks for PV guest IO emulation
>>   s390x: protvirt: Move IO control structures over SIDA
>>   s390x: protvirt: Handle SIGP store status correctly
>>   s390x: For now add unpack feature to GA1
>>
>>  hw/s390x/Makefile.objs              |   1 +
>>  hw/s390x/ipl.c                      |  80 +++++++++++++-
>>  hw/s390x/ipl.h                      |  33 ++++++
>>  hw/s390x/pv.c                       | 160 +++++++++++++++++++++++++++=
+
>>  hw/s390x/pv.h                       |  40 +++++++
>>  hw/s390x/s390-virtio-ccw.c          | 136 ++++++++++++++++++++++-
>>  hw/s390x/sclp.c                     |  17 +++
>>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>  include/hw/s390x/sclp.h             |   2 +
>>  linux-headers/linux/kvm.h           |  48 ++++++++-
>>  target/s390x/cpu.c                  |  41 +++++--
>>  target/s390x/cpu.h                  |   8 +-
>>  target/s390x/cpu_features_def.inc.h |   1 +
>>  target/s390x/diag.c                 |  63 +++++++++--
>>  target/s390x/gen-features.c         |   1 +
>>  target/s390x/helper.c               |   4 +
>>  target/s390x/ioinst.c               | 113 ++++++++++++++------
>>  target/s390x/kvm-stub.c             |  10 +-
>>  target/s390x/kvm.c                  |  89 ++++++++++++++--
>>  target/s390x/kvm_s390x.h            |   6 +-
>>  target/s390x/mmu_helper.c           |   9 ++
>>  target/s390x/sigp.c                 |   1 +
>>  22 files changed, 789 insertions(+), 75 deletions(-)
>>  create mode 100644 hw/s390x/pv.c
>>  create mode 100644 hw/s390x/pv.h
>>
>=20
> -ENODOC; can you add something under docs/ that describes how you
> configure a pv guest and what the initialization/teardown flow is?

Sure, but could you give me a bit more detail?
What do you mean by configure?
Command line options?



--JMEH5vsP2ClH1v29hr86zhOfNEU80BG2G--

--kDOFXwlPbB8LhI2KIv4tjbCS9kz99W2nj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5L43QACgkQ41TmuOI4
ufiaCw/+OQm7lpUGmYFwESeQZvcmtfzM8CWJiCgBH5ELgtnRo+5F4RTssmJ2mbYE
EyCpHhv9MBTX70jbVAgVPYVjjYanej6L8MWzMzesxxbcClisbBsnrQ6KeKBOAH9N
1dBQ+lu+bmNibMQhVvIot7mcq06CC62c95+kg9tEk/I9F+eXK4GPNBXRliCguuZn
jUJX9z2q/qvVHHIlEH4QL/ZEEniavxt+YD8hkFkkpxPEuILMQpw4CAvIskN6HkSA
7Vpu6s38zfqqoKYgMKv1kYNTNwF6MSaeyQTmBXVMiLrcpTTcvbPOJat8GcqAzQ7R
f/5Ua2nKg4jm1csuax2+5H+6ovKeRsNofZP0AwDqn2dfPyp/NPlXdcqFa84km7SI
fExjZmEFA0H3AHgS4h9JU3r+B4Tjua+19b6tRRp1Y/nSWVPLdWd3cWRQpISxjCCk
occvQ65TFtXbwjywMVNDDBwWNmdRxV4euLvCpsH10zEC48ttrz0TCsvTu68WKO7h
J8fmFcxVxbDaWW5Ey7mAcfB4Fw6xmu+lgnTu+2t4qw4ACzi4PHFC9otNKkP1j0Nb
wXZRvn7BxKn14/ebANJ3nEegg2amW8KzFc7GHJfY+gZ4WifOY8HdYibda6XHHIPy
howXuSG5Y1vL633woudoA5qT0x82etzh6ocd12Gnut02hFQGKyk=
=fleo
-----END PGP SIGNATURE-----

--kDOFXwlPbB8LhI2KIv4tjbCS9kz99W2nj--


