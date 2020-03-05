Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A1C3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E720620732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50121 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rRh-0006GC-TZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rQU-0004AM-3g
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9rQS-00050v-Ul
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29492
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9rQS-00050W-Pc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:24:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025ELOce028072
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 09:24:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhr4kawmg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:24:32 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 14:24:29 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 14:24:27 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 025ENRoh46596536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 14:23:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E4625204F;
 Thu,  5 Mar 2020 14:24:26 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D983C52052;
 Thu,  5 Mar 2020 14:24:25 +0000 (GMT)
Subject: Re: [PATCH v6 03/18] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-4-frankja@linux.ibm.com>
 <2a93ff2e-4955-67c4-e7af-766a49fc8b32@redhat.com>
 <8fcf6bcf-137c-b488-64b3-4c0bce48b909@linux.ibm.com>
 <8018f651-8800-3c9f-0764-188472a41dae@redhat.com>
 <91a4bd8b-6c88-a9d8-42a4-154df21a0c08@linux.ibm.com>
 <5afa8775-5382-f128-7bfd-39643a02c454@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 5 Mar 2020 15:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5afa8775-5382-f128-7bfd-39643a02c454@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eLehlj1AUqemYQZuTcH5UR46iSCMaGdUd"
X-TM-AS-GCONF: 00
x-cbid: 20030514-0016-0000-0000-000002ED7BA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030514-0017-0000-0000-00003350CFAB
Message-Id: <c83b417c-158e-da67-5ed1-24e788f78314@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_04:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=3 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050093
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
--eLehlj1AUqemYQZuTcH5UR46iSCMaGdUd
Content-Type: multipart/mixed; boundary="kOs6XMsTlozJuiI5bsczO6D0qUdvdTGjY"

--kOs6XMsTlozJuiI5bsczO6D0qUdvdTGjY
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/5/20 3:23 PM, David Hildenbrand wrote:
> On 05.03.20 15:20, Janosch Frank wrote:
>> On 3/5/20 3:15 PM, David Hildenbrand wrote:
>>>>>> =20
>>>>>> +static void s390_machine_unprotect(S390CcwMachineState *ms)
>>>>>> +{
>>>>>> +    CPUState *t;
>>>>>> +
>>>>>> +    if (!ms->pv)
>>>>>> +        return;
>>>>>
>>>>> How can this ever happen? g_assert(ms->pv) ?
>>>>
>>>> Currently not, that's only used in the follow up patches with the ba=
llon
>>>> and migration blocker
>>>
>>> Even then, why should we unprotect when not protected. That looks wro=
ng
>>> to me and has to be fixed in the other patches,
>>
>> I fixed it this morning :)
>>
>>>
>>>>
>>>>>
>>>>> Also, i don't see this function getting called from anywhere else e=
xcept
>>>>> when s390_machine_protect() fails. That looks wrong. This has to be=

>>>>> called when going out of PV mode.
>>>>
>>>> Yes, but that's in the diag308 1-4 patch.
>>>
>>> The way patches were split up is somewhat sub-optimal for review.
>>
>> Thanks
>> I'll try to find a better split up of the code
>>
>>>
>>> [...]
>>>
>>>>>> +        break;
>>>>>> +    case S390_RESET_PV: /* Subcode 10 */
>>>>>> +        subsystem_reset();
>>>>>> +        s390_crypto_reset();
>>>>>> +
>>>>>> +        CPU_FOREACH(t) {
>>>>>> +            if (t =3D=3D cs) {
>>>>>> +                continue;
>>>>>> +            }
>>>>>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL=
);
>>>>>> +        }
>>>>>> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>>>>>> +
>>>>>> +        if (s390_machine_protect(ms)) {
>>>>>> +            s390_machine_inject_pv_error(cs);
>>>>>
>>>>> Ah, so it's not an actual exception. BUT: All other guest cpus were=

>>>>> reset, can the guest deal with that?
>>>>
>>>> Well, all other CPUs should be stopped for diag308, no?
>>>> Also it's done by the bootloader and not a OS which just stops its c=
pus
>>>> and goes into protected mode.
>>>>
>>>>>
>>>>> (run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL) should go after=
 the
>>>>> s390_machine_protect() I assume - the change you had in the other p=
atch)
>>>>
>>>> That's not a good idea, I want to reset before we automatically call=
 the
>>>> UV routines on a reset.
>>>
>>> But how can s390_machine_inject_pv_error(cs) be any effective if you
>>> already reset the CPU?
>>>
>>
>> Because a normal cpu reset does not clear out the registers.
>=20
> Okay, so a guest (e.g., Linux) can deal with some other things getting
> reset I assume?

At this point in time only the bootloader runs, which survives a normal
reset.



--kOs6XMsTlozJuiI5bsczO6D0qUdvdTGjY--

--eLehlj1AUqemYQZuTcH5UR46iSCMaGdUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5hC5kACgkQ41TmuOI4
ufjrHA//fa3acQWpR51P1LH6ZGnsx6PoAs+btv6DLoTPU3a84GaLXbpIU08wUmU3
HVLAoWb2dXp85o/WM2+Wf/XpOF5nS27pUz/CWPpfPDuBR9VDdKeIbf+mHif7+qDd
XaK+JLzw5HRprkjhS7zwnqM/ijSm3YUZqnvzzZo4LhgCM9ek0Y4a6TA4wxcWwMhh
6Nl+RWVd+Y8D19v69HzHQc/qXIIhtSypi9fP8bOppBe3v0qARGr/G++U2LsjUL9U
Mpktb0XbivPkRmk7scyBUIiIk/9s5Dr4mmqfxWupneOiW6EunpTVOga++apRqZab
AkUYxZF8ks74TPr+/AHEGEPgbtII4nrQGlC5QWTPN0FgcwLulZt8rkhVwBcxP8Kc
1aU0shzsqdKO7KPkoYANsasl7Ec6eLcYzZp3Ze392rIA4K0DdggLqiFynkRxFGPr
ealj1Daidy6GRYVJ78LkMBYQzJKRAuEq3gspt09NXI38YS+lxjC+C6xWQoBdxul0
rLwESBFHCI+ddgPj7kGkD7TMf/StmKLSscxi8N7zyyL8B/bwLWyNFELT3Z2Xx6yP
86wKl6+CJBcsm7lTxkYqvE8tJ2WpSYqpJYPTUgWhQXBdOOE/iWQtlIXttt0IzooR
YyfSUBNqtQ4ZvaKjui9E6hMBEQJDgirHn0QyG09evmwZ2WXDvH0=
=9XgG
-----END PGP SIGNATURE-----

--eLehlj1AUqemYQZuTcH5UR46iSCMaGdUd--


