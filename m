Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B83C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE21520674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE21520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBF5F-0002Jr-46
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBF4K-0001sD-0q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBF4I-0002Yw-In
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57280
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBF4I-0002Yf-C7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0299pMxb029951
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 05:51:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8c8yw6f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:51:24 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 09:51:09 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 09:51:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0299p64F43188546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 09:51:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30E75A4053;
 Mon,  9 Mar 2020 09:51:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE02DA4057;
 Mon,  9 Mar 2020 09:51:05 +0000 (GMT)
Received: from dyn-9-152-224-87.boeblingen.de.ibm.com (unknown [9.152.224.87])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 09:51:05 +0000 (GMT)
Subject: Re: [PATCH v6 17/18] docs: Add protvirt docs
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-18-frankja@linux.ibm.com>
 <4ec64421-da11-626c-400d-207cc7511e0f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Mon, 9 Mar 2020 10:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4ec64421-da11-626c-400d-207cc7511e0f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="etKGzoFdV9A37sd6p7gHjNc57GtnzW0jp"
X-TM-AS-GCONF: 00
x-cbid: 20030909-0028-0000-0000-000003E23A87
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030909-0029-0000-0000-000024A77781
Message-Id: <3aabce7d-f908-3e99-308b-bea96babd967@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_02:2020-03-06,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=3
 impostorscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090070
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
--etKGzoFdV9A37sd6p7gHjNc57GtnzW0jp
Content-Type: multipart/mixed; boundary="TEjDXQTh13Bb9bKGlJEkA13xcMmWTLJ9h"

--TEjDXQTh13Bb9bKGlJEkA13xcMmWTLJ9h
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 8:09 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> Lets add some documentation for the Protected VM functionality.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  docs/system/index.rst    |  1 +
>>  docs/system/protvirt.rst | 57 +++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 58 insertions(+)
>>  create mode 100644 docs/system/protvirt.rst
>>
>> diff --git a/docs/system/index.rst b/docs/system/index.rst
>> index 1a4b2c82ac..d2dc63b973 100644
>> --- a/docs/system/index.rst
>> +++ b/docs/system/index.rst
>> @@ -16,3 +16,4 @@ Contents:
>> =20
>>     qemu-block-drivers
>>     vfio-ap
>> +   protvirt
>> diff --git a/docs/system/protvirt.rst b/docs/system/protvirt.rst
>> new file mode 100644
>> index 0000000000..a1902cc47c
>> --- /dev/null
>> +++ b/docs/system/protvirt.rst
>> @@ -0,0 +1,57 @@
>> +Protected Virtualization on s390x
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The memory and most of the register contents of Protected Virtual
>=20
> s/register contents/registers/

Ack

>=20
>> +Machines (PVMs) are inaccessible to the hypervisor, effectively
>=20
> s/inaccessible/encrypted or even inaccessible/ ?
>=20
>> +prohibiting VM introspection when the VM is running. At rest, PVMs ar=
e
>> +encrypted and can only be decrypted by the firmware of specific IBM Z=

>> +machines.
>=20
> maybe "(a.k.a. the Ultravisor)"

At rest, PVMs are
encrypted and can only be decrypted by the firmware, represented by an
entity called Ultravisor, of specific IBM Z machines.

>=20
>> +
>> +
>> +Prerequisites
>> +-------------
>> +
>> +To run PVMs, you need to have a machine with the Protected
>=20
> "a machine with the Protected Virtualization feature is required"

Ack

>=20
>> +Virtualization feature, which is indicated by the Ultravisor Call
>> +facility (stfle bit 158). This is a KVM only feature, therefore you
>=20
> ", therefore, "
>=20
> I don't understand the "KVM only" feature part. Just say that an update=
d
> KVM + right HW is required and how it is to be updated.

The KVM only part is mostly messaging that this can't be run under TCG

>=20
>> +need a KVM which is able to support PVMs and activate the Ultravisor
>=20
> "a KVM version"
>=20
>> +initialization by setting `prot_virt=3D1` on the kernel command line.=


To run PVMs a machine with the Protected Virtualization feature
which is indicated by the Ultravisor Call facility (stfle bit
158) is required. The Ultravisor needs to be initialized at boot by
setting `prot_virt=3D1` on the kernel command line.



>> +
>> +If those requirements are met, the capability `KVM_CAP_S390_PROTECTED=
`
>> +will indicate that KVM can support PVMs on that LPAR.
>> +
>> +
>> +QEMU Settings
>> +-------------
>> +
>> +To indicate to the VM that it can move into protected mode, the
>=20
> s/move/transition/ ?

Ack
I also took most of the suggestions below with some forms of modification=
=2E

>=20
>> +`Unpack facility` (stfle bit 161) needs to be part of the cpu model o=
f
>> +the VM.
>=20
> Maybe mention the CPU feature name here.
>=20
>> +
>> +All I/O devices need to use the IOMMU.
>> +Passthrough (vfio) devices are currently not supported.
>> +
>> +Host huge page backings are not supported. The guest however can use
>=20
> "However, the guest can ..."
>=20
>> +huge pages as indicated by its facilities.
>> +
>> +
>> +Boot Process
>> +------------
>> +
>> +A secure guest image can be both booted from disk and using the QEMU
>=20
> "either be loaded from disk or supplied on the QEMU command line" ?
>=20
>> +command line. Booting from disk is done by the unmodified s390-ccw
>> +BIOS. I.e., the bootmap is interpreted and a number of components is
>=20
> "interpreted, multiple components are"
>=20
>> +read into memory and control is transferred to one of the components
>> +(zipl stage3), which does some fixups and then transfers control to
>> +some program residing in guest memory, which is normally the OS
>=20
> to many ", which". Better split that up for readability.
>=20
>> +kernel. The secure image has another component prepended (stage3a)
>> +which uses the new diag308 subcodes 8 and 10 to trigger the transitio=
n
>> +into secure mode.
>> +
>> +Booting from the command line requires that the file passed
>=20
> "from the image supplied on the QEMU command line" ?
>=20
>> +via -kernel has the same memory layout as would result from the disk
>> +boot. This memory layout includes the encrypted components (kernel,
>> +initrd, cmdline), the stage3a loader and metadata. In case this boot
>> +method is used, the command line options -initrd and -cmdline are
>> +ineffective.  The preparation of secure guest image is done by a
>=20
> s/of secure/of a PMV image/
>=20
>> +program (name tbd) of the s390-tools package.
>>
>=20
>=20
> General: secure guest -> PMV
>=20



--TEjDXQTh13Bb9bKGlJEkA13xcMmWTLJ9h--

--etKGzoFdV9A37sd6p7gHjNc57GtnzW0jp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5mEYkACgkQ41TmuOI4
ufhSKw//eViQA2oN73CMTcZlK8UVQFCKErb8zKUvqqM7Z90CibInsh6LnefzWqVd
ll28VvAvqK4dkXO+BcRJKSPTi7oKX6rRMUyk6/ncGSF06LMExG3rKZeA5bPZgJeJ
LoNJvm0g2QOjkSDzVcluKy3DsfoSXuG+/8t8YaEiUP51JAcZc3u/717tjCZBs3aE
DEblHzcpSIpsbhs5CLd9yJToZnuAhVkgSMzJTMwQZi/arI6jrYCqhjnVnhhSpszh
FG574ERRNU3YwiG+++gmUgrcb7lrDT+MTJfxyvRR87ZG2EokdePtAgh8MSmMe1+O
ZqHkthV5Dn6awv9jJxf/UuEUyugFBu0ICgkMdff0KNQMEtwSfdHxcX9qW7GIr9Xg
7iRltRj9Xr4dFayBdvLLk1nNbiSGVNgGXJ+pOYWvc+yH+aUY2J8cAk/jDEv8D4zt
beR5lmxNGmlXxAr3/jLIAWDM9/VVNFvArGXRwDm4x16ww8hO5toq3QNbgVDYNYW0
nEtmGgWUpcZevtxXZ1EpGWtUsYsT680EHu+XBhIQ5rK+/bpqXqsSB/EiNJ61CoVM
GWQB+6WQe3ATcnhfUTlHrdEVTWmb8IhtNqB+f4WiZpFY6q2jvbS/ZKmZ7YILXTCx
mpRzcfpbKYP2gn8SR2pd0p3JUEPA32X85hSBQ3l7zD+Gxe5K2AQ=
=CAfL
-----END PGP SIGNATURE-----

--etKGzoFdV9A37sd6p7gHjNc57GtnzW0jp--


