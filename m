Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5A7C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A961206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A961206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnQE-0001hC-7N
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXnOt-0000e4-Ka
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXnOs-0005Sv-Bv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:25:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXnOs-0005R7-3S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:25:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xALEMH3i132754
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:25:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdqmyjf89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:25:36 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 21 Nov 2019 14:25:34 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 14:25:31 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xALEPUUU14352684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 14:25:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C68AAE051;
 Thu, 21 Nov 2019 14:25:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8484AE04D;
 Thu, 21 Nov 2019 14:25:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.70.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Nov 2019 14:25:29 +0000 (GMT)
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
 <8669fc89-c8a9-641d-d9aa-ee4aa011ac26@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 21 Nov 2019 15:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8669fc89-c8a9-641d-d9aa-ee4aa011ac26@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V2DSOjwH5S1oHPWE1yjCvgbKiwGKcKABT"
X-TM-AS-GCONF: 00
x-cbid: 19112114-0028-0000-0000-000003BD98E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112114-0029-0000-0000-00002480C15B
Message-Id: <7df881fe-46ec-2522-143e-929f4e3d2421@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V2DSOjwH5S1oHPWE1yjCvgbKiwGKcKABT
Content-Type: multipart/mixed; boundary="60kme51X3jrrT3DUydPwlM8XjTafjl5df"

--60kme51X3jrrT3DUydPwlM8XjTafjl5df
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/21/19 12:27 PM, David Hildenbrand wrote:
> On 20.11.19 12:43, Janosch Frank wrote:

>> @@ -357,6 +353,35 @@ static void s390_machine_reset(MachineState *mach=
ine)
>>           run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>>           run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>           break;
>> +    case S390_RESET_EXTERNAL:
>> +    case S390_RESET_REIPL: /* Subcode 4 */
>> +        qemu_devices_reset();
>> +        s390_crypto_reset();
>> +        /* configure and start the ipl CPU only */
>> +        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>> +        break;
>=20
> Is there a way to modify this patch to not change unrelated code that=20
> heavily? Makes it harder to review.

https://github.com/frankjaa/qemu/commit/8c53d5c8a6bbcc53496c7a2877c7cbffc=
435b708

And please trim your emails.

>=20
>> +    case S390_RESET_PV: /* Subcode 10 */
>> +        subsystem_reset();
>> +        s390_crypto_reset();
>> +
>> +        CPU_FOREACH(t) {
>> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>> +        }
>> +
>> +        /* Create SE VM */
>> +        s390_pv_vm_create();
>> +        CPU_FOREACH(t) {
>> +            s390_pv_vcpu_create(t);
>> +        }
>> +
>> +        /* Set SE header and unpack */
>> +        s390_ipl_prepare_pv_header();
>> +        /* Decrypt image */
>> +        s390_ipl_pv_unpack();
>> +        /* Verify integrity */
>> +        s390_pv_verify();
>> +        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> +        break;
>>       default:
>>           g_assert_not_reached();
>>       }
>> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_fe=
atures_def.inc.h
>> index 31dff0d84e..60db28351d 100644
>> --- a/target/s390x/cpu_features_def.inc.h
>> +++ b/target/s390x/cpu_features_def.inc.h
>> @@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, =
"Deflate-conversion facility (
>>   DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Pac=
ked-Decimal-Enhancement Facility")
>>   DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist=
-extension-9 facility (excluding subfunctions)")
>>   DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
>> +DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
>>  =20
>>   /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relativ=
e to byte-80) */
>>   DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-l=
imit-suppression facility")
>>
>=20
>=20



--60kme51X3jrrT3DUydPwlM8XjTafjl5df--

--V2DSOjwH5S1oHPWE1yjCvgbKiwGKcKABT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3WnlkACgkQ41TmuOI4
ufi1wBAAy9QY+TiubvwfASm5n/gDifJjAabsCdfBQq1iQ2NDO5eveqzNAE2dLvsP
HKoj9Igld7JYzMklK/ALT1hlGVrQvgq7E5aqtHswvgGPsUgG6xPCKRDkOzb2rjoE
wuR6/nzgzTxzL7MQAoSN7fsFJ44QomymC/TyXEir+918eMaX0/kfIs6hkO+BTjEg
Ob3Gla7coiBNzGTcFusqBpU1Q6arWGf+FgHro15LO0LDVb4nNHly7QHo9g156dWW
dTCR6nRzGiBTDnnD73LP2C4LZ8Kq3Be9qfkhghMZzfBA6LckD4qScMjUNysvg6rI
U6UALlcATyu+bDi6AKCzMHYlBHSYAqUAXR6tBMbAKV49S+oVOj7wFM+aBuh2SLoJ
DXmdbYsG7WpN+eyzOEgkaTErnhlS0oyYmJsvFa3boJX3fg82Iyenwy4LQ3GnFG+q
csyMKCyBsaDwEycHhdUExxjvOBOn1rL9Va8kJYm9dDD615Ht/ldMmnSi5+10CQk3
e2yZXBvOP1gW7RmR8IuxjZoVwxu2rDXIbJXI0dwKK3VuZi5dpI2LKr2V9+aE2p8M
XvmO7XcxFOdiLdZht6B0WN18r4zAdSDSOLnSBfqduRHXq0JNFIR5mwStgijUKo5i
te0g4fykWGm36sDUsUibpTnEO8ZBSQwUJo8xL3/J/DFY9zsRhQs=
=NDBA
-----END PGP SIGNATURE-----

--V2DSOjwH5S1oHPWE1yjCvgbKiwGKcKABT--


