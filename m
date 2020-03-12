Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D0C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2698206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2698206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMmX-0006zp-SS
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCMlv-0006Ze-23
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCMlt-0000He-RH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:17:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36332
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCMlt-0000HY-MP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:17:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02CCFHVH107674
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 08:17:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yqksa2xvc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 08:17:04 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 12 Mar 2020 12:10:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 12:10:37 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02CCAa9f54591550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 12:10:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1AD75204F;
 Thu, 12 Mar 2020 12:10:36 +0000 (GMT)
Received: from dyn-9-152-224-122.boeblingen.de.ibm.com (unknown
 [9.152.224.122])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A20785204E;
 Thu, 12 Mar 2020 12:10:36 +0000 (GMT)
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
 <569575c9-5819-f890-e218-99f3a23bee99@redhat.com>
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
Date: Thu, 12 Mar 2020 13:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <569575c9-5819-f890-e218-99f3a23bee99@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WJeSFAj8zKvlqpRPsLVXVQUJ016gI75WN"
X-TM-AS-GCONF: 00
x-cbid: 20031212-0008-0000-0000-0000035C1109
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031212-0009-0000-0000-00004A7D5AA8
Message-Id: <f3e18afe-9cb2-7bd4-38f9-e4d176d0cc3a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_03:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=3 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120067
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
--WJeSFAj8zKvlqpRPsLVXVQUJ016gI75WN
Content-Type: multipart/mixed; boundary="fg5bB5KB6S80vBk2oQjKxUXC6Rgcnh2y7"

--fg5bB5KB6S80vBk2oQjKxUXC6Rgcnh2y7
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/11/20 5:16 PM, David Hildenbrand wrote:
>=20
> I don't have to warn you that I am not a native speaker ;)
>=20
>> +Prerequisites
>> +-------------
>> +
>> +To run PVMs a machine with the Protected Virtualization feature
>=20
> PVMs, a
>=20
>> +which is indicated by the Ultravisor Call facility (stfle bit
>=20
> , which ..., is required
>=20
>> +158) is required. The Ultravisor needs to be initialized at boot by
>> +setting `prot_virt=3D1` on the kernel command line.
>> +
>> +If those requirements are met, the capability `KVM_CAP_S390_PROTECTED=
`
>> +will indicate that KVM can support PVMs on that LPAR.
>> +
>> +
>> +QEMU Settings
>> +-------------
>> +
>> +To indicate to the VM that it can transition into protected mode, the=

>> +`Unpack facility` (stfle bit 161 represented by the feature
>> +`S390_FEAT_UNPACK`) needs to be part of the cpu model of the VM.
>=20
> maybe mention the feature name instead of S390_FEAT_UNPACK ? "unpack"
>=20
>> +
>> +All I/O devices need to use the IOMMU.
>=20
> need to/have to ?
>=20
>> +Passthrough (vfio) devices are currently not supported.
>=20
> Does that have to be fenced or will they simply not be detected/not wor=
k?

I guess they will lead to the VM being killed by the kernel, since it
can't access protected memory. I need to check that with Halil to
confirm though.

>=20
>> +
>> +Host huge page backings are not supported. However guests can use hug=
e
>> +pages as indicated by its facilities.
>=20
> Maybe mention what will happen if huge pages are used.

Currently we would fail the unpack process, which I dislike because it
would only log a cryptic error code. I will have a look if I can instead
print an error when the subcode 10 is issued and return an error.


>=20
>> +
>> +
>> +Boot Process
>> +------------
>> +
>> +A secure guest image can either be loaded from disk or supplied on th=
e
>> +QEMU command line. Booting from disk is done by the unmodified
>> +s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
>> +are read into memory and control is transferred to one of the
>> +components (zipl stage3). Stag3 does some fixups and then transfers
>> +control to some program residing in guest memory, which is normally
>> +the OS kernel. The secure image has another component prepended
>> +(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
>> +transition into secure mode.
>> +
>> +Booting from the image supplied via the QEMU command line requires
>=20
> via/on as above?

Sure

>=20
>> +that the file passed via -kernel has the same memory layout as would
>> +result from the disk boot. This memory layout includes the encrypted
>> +components (kernel, initrd, cmdline), the stage3a loader and
>> +metadata. In case this boot method is used, the command line
>> +options -initrd and -cmdline are ineffective. The preparation of a PV=
M
>=20
> Is there way we could warn if these would be set?

I'll have a look, but I'm unsure where I'll need to hook into to make
such a check and it the effort is worth it.

>=20
>> +image is done by genprotimg of the s390-tools package.
>>
>=20
>=20
> Acked-by: David Hildenbrand <david@redhat.com>
>=20

Thanks!


--fg5bB5KB6S80vBk2oQjKxUXC6Rgcnh2y7--

--WJeSFAj8zKvlqpRPsLVXVQUJ016gI75WN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5qJrwACgkQ41TmuOI4
ufgrbA//caHBGWzeZNGJr3+VQxKrW3BYZUYpeIAXztU+ibJln4FpuX5QsqCT+dvA
a3JA0JV5wNfUIkSxJ+VYUG7qOzEp8BfM/n/72E2kZ7zt7taBTDaqTecNuHwQ+TDz
JHsRBmyduq/sHPvy5PnhdGzzJxvy+x//rxkiy++OD+gRssQBw+jXh5KyHpw1te42
YCdS2z9M3+YtxN++RrakvUbzZJqwV2J0LOvVP4BGDmwcGKgz905OhqZi2BzWQlOa
z5h/UlinuKQOd+S0vcagO1bnMp6MUr/qw25+Gj6GovX+ASgXCxUwc7zFYBG6m++c
hPcGM0WJstPMCS3BqB2vmJcjsSAWQPTQBwygHZKy40UP0Ruqulw8t2B0GZLTOE3z
jGvHNlTxZin5H6+D5h/8GDO12kJC8+SoWdF7LkhUR3/FUPxirefrBtkfo0w/OauU
yQvCxk0oofIEeZxngqaXaK9D9P11TYoUKk3fnOc1Bc69O5osEC2vvcCRaTdra8UL
YeRkj/uPmkVE5LAI9+YvC8H9GD6cNAX/qI765ibPPJcuOgTsoRYwSp0jqs0RQxOH
EvEkfuNO5qhsB17pla7mwJopJwL08zIXoDUSP5wR+pPTmdW1+nKNxUmaRBSU1jLK
d+5nyaPiiLBhqnAZkoY6tGQPV6r7wfLlD7CMtctNfCFtA+MU9dY=
=OyOa
-----END PGP SIGNATURE-----

--WJeSFAj8zKvlqpRPsLVXVQUJ016gI75WN--


