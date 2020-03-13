Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19853206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19853206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkDQ-0005FJ-BP
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCkCo-0004iH-16
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCkCl-0005bz-OM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:18:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCkCl-0005Ym-FX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:18:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DD32tD184928
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:18:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yquep0bpv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:18:22 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 13 Mar 2020 13:18:19 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:18:17 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DDIGQE48169004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:18:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2DFF42041
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:18:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79A5142047
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:18:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.48.117])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:18:16 +0000 (GMT)
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
To: qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
 <20200313140057.0c5d90c4@p-imbrenda>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 13 Mar 2020 14:18:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200313140057.0c5d90c4@p-imbrenda>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GhNjGN0I6SHYwW2cRkFITb6Ai9clKPEl0"
X-TM-AS-GCONF: 00
x-cbid: 20031313-0012-0000-0000-000003907904
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0013-0000-0000-000021CD4E96
Message-Id: <1d901ba3-a25f-218e-d619-f6f24c0dd842@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=1 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130069
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GhNjGN0I6SHYwW2cRkFITb6Ai9clKPEl0
Content-Type: multipart/mixed; boundary="LJRVeLP2cSd93MFovfDZqXQNlhIFP43yN"

--LJRVeLP2cSd93MFovfDZqXQNlhIFP43yN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/13/20 2:00 PM, Claudio Imbrenda wrote:
> On Wed, 11 Mar 2020 09:21:50 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Lets add some documentation for the Protected VM functionality.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  docs/system/index.rst    |  1 +
>>  docs/system/protvirt.rst | 56
>> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 57
>> insertions(+) create mode 100644 docs/system/protvirt.rst
>>
>> diff --git a/docs/system/index.rst b/docs/system/index.rst
>> index 6e5f20fa1333ce23..74afbd7cc3fc0296 100644
>> --- a/docs/system/index.rst
>> +++ b/docs/system/index.rst
>> @@ -34,3 +34,4 @@ Contents:
>>     deprecated
>>     build-platforms
>>     license
>> +   protvirt
>> diff --git a/docs/system/protvirt.rst b/docs/system/protvirt.rst
>> new file mode 100644
>> index 0000000000000000..6c8cf0f7910eae86
>> --- /dev/null
>> +++ b/docs/system/protvirt.rst
>> @@ -0,0 +1,56 @@
>> +Protected Virtualization on s390x
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The memory and most of the registers of Protected Virtual Machines
>> +(PVMs) are encrypted or inaccessible to the hypervisor, effectively
>> +prohibiting VM introspection when the VM is running. At rest, PVMs
>> are +encrypted and can only be decrypted by the firmware, represented
>> by an +entity called Ultravisor, of specific IBM Z machines.
>> +
>> +
>> +Prerequisites
>> +-------------
>> +
>> +To run PVMs a machine with the Protected Virtualization feature
>> +which is indicated by the Ultravisor Call facility (stfle bit
>> +158) is required. The Ultravisor needs to be initialized at boot by
>> +setting `prot_virt=3D1` on the kernel command line.
>=20
> I'd add "of the host" just to make it extra clear

How about:
=2E..on the host kernel command line

>=20
>> +
>> +If those requirements are met, the capability
>> `KVM_CAP_S390_PROTECTED` +will indicate that KVM can support PVMs on
>> that LPAR. +
>> +
>> +QEMU Settings
>> +-------------
>> +
>> +To indicate to the VM that it can transition into protected mode, the=

>> +`Unpack facility` (stfle bit 161 represented by the feature
>> +`S390_FEAT_UNPACK`) needs to be part of the cpu model of the VM.
>> +
>> +All I/O devices need to use the IOMMU.
>> +Passthrough (vfio) devices are currently not supported.
>> +
>> +Host huge page backings are not supported. However guests can use
>> huge +pages as indicated by its facilities.
>> +
>> +
>> +Boot Process
>> +------------
>> +
>> +A secure guest image can either be loaded from disk or supplied on
>> the +QEMU command line. Booting from disk is done by the unmodified
>> +s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
>> +are read into memory and control is transferred to one of the
>> +components (zipl stage3). Stag3 does some fixups and then transfers
>> +control to some program residing in guest memory, which is normally
>> +the OS kernel. The secure image has another component prepended
>> +(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
>> +transition into secure mode.
>> +
>> +Booting from the image supplied via the QEMU command line requires
>> +that the file passed via -kernel has the same memory layout as would
>> +result from the disk boot. This memory layout includes the encrypted
>> +components (kernel, initrd, cmdline), the stage3a loader and
>> +metadata. In case this boot method is used, the command line
>> +options -initrd and -cmdline are ineffective. The preparation of a
>> PVM +image is done by genprotimg of the s390-tools package.
>=20
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks!



--LJRVeLP2cSd93MFovfDZqXQNlhIFP43yN--

--GhNjGN0I6SHYwW2cRkFITb6Ai9clKPEl0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5riBgACgkQ41TmuOI4
ufiOPhAAyqS2Q87qFgpjMxxfdECIcjB0idvKFgxRuKewsVyByrp4yzQ/0jGh8Zrh
fzmPB0XjCAueaj36iWhvtE37bZBqV5+5W7DOpyyqWsTBwYT2C2QMmBdCk90KUFaz
B+u6Zq/o7kYLzdeicm65C1Rrs1EgKzkt+i4tmpDMmFyHIlgexAaBXaQbNxlmfIpL
4tIZIFJESsNJTQAfXDvFLtTlH9kMCznySgm7/aeieC64KhdZRftkXLBcplJ1RhFA
XF2ZfqhryLQt8dkQtr8y6gbjopIx0qMGvvlJL+VshtlwhhSM2VCtPz21sWC8IkDh
FxPDLsHE4S4GAxDU3Qr+/6SAQPRLgu1h+yi0uahl4BqwQ1h1QAsirKe7e0hg9odt
gwfSLRHPPPWM1BneRP6VbVOk7suva1mEIhhyB84PohCRNpKuIc85NK4wGXQjYDxO
tSzQCG1JYjhC2iCOFNaYHHf89o4mLqaGC1YiTuOYeOVEsjXa7xu0im5c+B/JmUa3
C59Ue/sUTOp9rWdoQXwaplI6IQOnrcXlvWE2asQYJNyxcINzA3IWrSaCKQH2Wmc7
fU3ZOzFVGhUwpPLHcCPW8qW6cAQjgI3E0O3RViIoDfrs2bIsYdyi60ilGxeM8koe
1Fz9BCvdVVfaSNzxXTRCGwBNfHQ0bPxfBFLQ0VOmA8whQ47gOSE=
=Z+ZC
-----END PGP SIGNATURE-----

--GhNjGN0I6SHYwW2cRkFITb6Ai9clKPEl0--


