Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E470C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4372F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4372F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEQQ-0008NH-AJ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jJEP6-0006kC-Jx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jJEP5-0001Ni-4q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:45:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jJEP4-0001Lp-RA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:45:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02VAWcib189988
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 06:45:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrw2mux-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 06:45:53 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 31 Mar 2020 11:45:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 31 Mar 2020 11:45:35 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02VAjlTj54395040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 10:45:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE9C152057;
 Tue, 31 Mar 2020 10:45:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.158.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A4E275204F;
 Tue, 31 Mar 2020 10:45:46 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
To: Cornelia Huck <cohuck@redhat.com>
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
 <20200331071456.3302-1-frankja@linux.ibm.com>
 <20200331113535.6bbd434d.cohuck@redhat.com>
 <107d86c4-fa6d-2e6f-6050-5ad6018a5be8@linux.ibm.com>
 <20200331121600.11858d5c.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 31 Mar 2020 12:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200331121600.11858d5c.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sI49CeuAdYFeWQ2dL58F97ryuXU7CL1if"
X-TM-AS-GCONF: 00
x-cbid: 20033110-0016-0000-0000-000002FB95CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033110-0017-0000-0000-0000335F5473
Message-Id: <1939aaae-506b-d6e2-4fc1-2dece638d8c1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_04:2020-03-30,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310096
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sI49CeuAdYFeWQ2dL58F97ryuXU7CL1if
Content-Type: multipart/mixed; boundary="tBM8Fuj7UNdofEAyM8069xajwzARoPeMN"

--tBM8Fuj7UNdofEAyM8069xajwzARoPeMN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/31/20 12:16 PM, Cornelia Huck wrote:
> On Tue, 31 Mar 2020 11:46:53 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 3/31/20 11:35 AM, Cornelia Huck wrote:
>>> On Tue, 31 Mar 2020 03:14:56 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
>>>> a bit more thorough. =20
>>>
>>> s/thorough/thoroughly/ ?
>>>  =20
>>>>
>>>> In this test we set a custom name and uuid through the QEMU command
>>>> line. Both parameters will be passed to the guest on a stsi subcode
>>>> 3.2.2 call and will then be checked.
>>>>
>>>> We also compare the configured cpu numbers against the smp reported
>>>> numbers and if the reserved + configured add up to the total number
>>>> reported.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>
>>>> * Tabify on struct
>>>> * Moved prefix_push up a bit
>>>> * Replaced returns with goto out to pop prefix
>>>>
>>>> ---
>>>>  s390x/stsi.c        | 73 ++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>  s390x/unittests.cfg |  1 +
>>>>  2 files changed, 74 insertions(+)
>>>> =20
>>>
>>> (...)
>>>  =20
>>>> +static void test_3_2_2(void)
>>>> +{
>>>> +	int rc;
>>>> +	/* EBCDIC for "kvm-unit" */
>>>> +	const uint8_t vm_name[] =3D { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, =
0x89,
>>>> +				    0xa3 };
>>>> +	const uint8_t uuid[] =3D { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
>>>> +				 0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
>>>> +				 0x00, 0x03 };
>>>> +	/* EBCDIC for "KVM/" */
>>>> +	const uint8_t cpi_kvm[] =3D { 0xd2, 0xe5, 0xd4, 0x61 };
>>>> +	const char *vm_name_ext =3D "kvm-unit-test";
>>>> +	struct stsi_322 *data =3D (void *)pagebuf;
>>>> +
>>>> +	report_prefix_push("3.2.2");
>>>> +
>>>> +	/* Is the function code available at all? */
>>>> +	if (stsi_get_fc(pagebuf) < 3) {
>>>> +		report_skip("Running under lpar, no level 3 to test.");
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	rc =3D stsi(pagebuf, 3, 2, 2);
>>>> +	report(!rc, "call");
>>>> +
>>>> +	/* For now we concentrate on KVM/QEMU */
>>>> +	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm))) {
>>>> +		report_skip("Not running under KVM/QEMU.");
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
>>>> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # c=
onfigured");
>>>> +	report(data->vm[0].total_cpus =3D=3D
>>>> +	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
>>>> +	       "cpu # total =3D=3D conf + reserved");
>>>> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
>>>> +	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)=
),
>>>> +	       "VM name =3D=3D kvm-unit-test");
>>>> +
>>>> +	if (data->vm[0].ext_name_encoding !=3D 2) {
>>>> +		report_skip("Extended VM names are not UTF-8."); =20
>>>
>>> Do we expect this to be anything other than UTF-8? =20
>>
>> With the current QEMU no.
>=20
> I don't really see a reason to change this in QEMU, though; and as you
> check already whether we're running under QEMU, maybe make this a
> failure?

David has requested it and already queued the patch.
If it bothers you, you can provide a fixpatch. :-)

>=20
>> When I find time to test this under z/VM (as a guest 2, no KVM) maybe.=

>=20
> Would it make sense to check (different) expected values for z/VM and
> QEMU, then?

I'm not sure what z/VM reports here, so I can't answer that.
But testing firmware, lpar and z/VM in addition to KVM has been proven
increasingly useful over time.

I'll add it to my low prio todo list.

>=20
>>
>>>  =20
>>>> +		goto out;
>>>> +	}
>>>> +	report(!memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext=
)),
>>>> +		       "ext VM name =3D=3D kvm-unit-test");
>>>> +
>>>> +out:
>>>> +	report_prefix_pop();
>>>> +}
>>>> +
>>>>  int main(void)
>>>>  {
>>>>  	report_prefix_push("stsi");
>>>>  	test_priv();
>>>>  	test_specs();
>>>>  	test_fc();
>>>> +	test_3_2_2();
>>>>  	return report_summary();
>>>>  } =20
>>>
>>> (...)
>>>  =20
>>
>>
>=20



--tBM8Fuj7UNdofEAyM8069xajwzARoPeMN--

--sI49CeuAdYFeWQ2dL58F97ryuXU7CL1if
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6DH1oACgkQ41TmuOI4
ufjsDA/+NkJkT6N3gNOFoMSrtnfjoky/KDN2/D1Fr82NIM+3zpEBSwTpNxA7oeyc
YEEXLze/DSgo0FMZTQLgj/Qrul5OB1UMIdZvRry0/w2Rcl991tVgpb8rx5HyeomJ
8rDz6gZ5SUT+bIDniT5zlmHie9CFeNW8PNCM/5T4fQf79cF5TkwO88seYustvM6w
nlsmSWtYzzwbOw25YInWwAGG1VqS24reFN/rQWIp0mrZWXL4pUZWNlQm7Kr+2CdN
iMflYhHAKJAKjUUErSh4ZijwqO7N7X0fhfImeLledPuyt133QKud4rs19gTEb5X+
lnARQZUgAdmsZZ43e1A/DNbDRhAxzPrtGJ1PFuafuO0PpAlADhbtk/3NaTZNcNKJ
HMffhz75nLpKHIUxN+a/ufYJ0hXSsRjSgui9Hz4EixtCpuE1EawUBzbR0LZPJd9C
rGL1D2bP/PRaTYwL9Re44xNAf88UtceIkl9rrBuZ6/rBSyQOSZHqZn/mBVhzTlEd
5oJZmB0/xFNlNoHm8E91GQ8Wo68HMUJJmi0w3Nmrwl9m98gSyw6SkrNSeRFSFBtI
YnyusXPQwLUnD7zaBILhexjffoHR8lnjeOoDwXpQQfLLc0M1oqRMjwTEucdPAZmE
FgZqy+dq6KwYb4+O5UWhGdnPCWVldrBQfj/0hxXFvJK/MeNaeKc=
=Xh82
-----END PGP SIGNATURE-----

--sI49CeuAdYFeWQ2dL58F97ryuXU7CL1if--


