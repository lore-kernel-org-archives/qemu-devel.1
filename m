Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8642DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC9D2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC9D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAkk-0002w5-Gd
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdAkA-0002Uy-Ol; Mon, 25 May 2020 06:54:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdAk9-0004Ak-Ne; Mon, 25 May 2020 06:54:06 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04PAWqDv187833; Mon, 25 May 2020 06:54:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316yga88ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 06:54:03 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04PAX8oK188460;
 Mon, 25 May 2020 06:54:03 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316yga88kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 06:54:03 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PAkPXp010923;
 Mon, 25 May 2020 10:54:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 316uf81jr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 10:54:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04PArwTw3932524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2020 10:53:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C5511C04A;
 Mon, 25 May 2020 10:53:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8248D11C04C;
 Mon, 25 May 2020 10:53:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.30.189])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2020 10:53:57 +0000 (GMT)
Subject: Re: [PATCH v2 3/8] s390/sclp: rework sclp boundary and length checks
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-4-walling@linux.ibm.com>
 <2fcd0d94-12c7-e3b8-d6a6-3c512ae25150@linux.ibm.com>
 <e8dd0421-0db6-ff92-43af-6fd082d76e7e@linux.ibm.com>
 <20200519151936.1071fa14.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aab9d660-7368-709b-7ef6-9634aeba86a5@linux.ibm.com>
Date: Mon, 25 May 2020 12:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200519151936.1071fa14.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eRln5ziRD2q6Rn1DegXOXUkRvoqM4u0Vr"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-25_05:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 cotscore=-2147483648 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:50:15
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eRln5ziRD2q6Rn1DegXOXUkRvoqM4u0Vr
Content-Type: multipart/mixed; boundary="e5s5OZqfvRUhatcbhJPVtjYtw4xlFloM4"

--e5s5OZqfvRUhatcbhJPVtjYtw4xlFloM4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/19/20 3:19 PM, Cornelia Huck wrote:
> On Mon, 18 May 2020 11:15:07 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
>=20
>> On 5/18/20 4:50 AM, Janosch Frank wrote:
>>> On 5/16/20 12:20 AM, Collin Walling wrote: =20
>>>> Rework the SCLP boundary check to account for different SCLP command=
s
>>>> (eventually) allowing different boundary sizes.
>>>>
>>>> Move the length check code into a separate function, and introduce a=

>>>> new function to determine the length of the read SCP data (i.e. the =
size
>>>> from the start of the struct to where the CPU entries should begin).=

>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/sclp.c | 57 ++++++++++++++++++++++++++++++++++++++++++----=
---
>>>>  1 file changed, 49 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index 2bd618515e..987699e3c4 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32=
_t code)
>>>>      return false;
>>>>  }
>>>> =20
>>>> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t co=
de,
>>>> +                                    SCCBHeader *header)
>>>> +{
>>>> +    uint64_t current_len =3D sccb_addr + be16_to_cpu(header->length=
);
>>>> +    uint64_t allowed_len =3D (sccb_addr & PAGE_MASK) + PAGE_SIZE;  =

>>>
>>> Those are addresses not length indications and the names should refle=
ct
>>> that. =20
>>
>> True
>>
>>> Also don't we need to use PAGE_SIZE - 1?
>>>  =20
>>
>> Technically we need to -1 on both sides since length denotes the size =
of
>> the sccb in bytes, not the max address.
>>
>> How about this:
>>
>> s/current_len/sccb_max_addr
>> s/allowed_len/sccb_boundary
>=20
> +1, like the names.
>=20
>>
>> -1 to sccb_max_addr
>>
>> Change the check to: sccb_max_addr < sccb_boundary
>>
>> ?
>>
>>> I'm still trying to wake up, so take this with a grain of salt.
>>>  =20
>>
>> No worries. I appreciate the review nonetheless :)
>>
>>>> +
>>>> +    switch (code & SCLP_CMD_CODE_MASK) {
>>>> +    default:
>>>> +        if (current_len <=3D allowed_len) {
>>>> +            return true;
>>>> +        }
>>>> +    }
>>>> +    header->response_code =3D cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIO=
LATION);
>>>> +    return false;
>>>> +}
>>>> +
>>>> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU r=
esponse */
>>>> +static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int d=
ata_len)
>>>> +{
>>>> +    int required_len =3D data_len + num_cpus * sizeof(CPUEntry);
>>>> +
>>>> +    if (be16_to_cpu(sccb->h.length) < required_len) {
>>>> +        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_=
SCCB_LENGTH);
>>>> +        return false;
>>>> +    }
>>>> +    return true;
>>>> +} =20
>>>
>>> Hm, from the function name alone I'd not have expected it to also set=

>>> the response code.
>>>  =20
>>
>> It also sets the required length in the header for an extended-length
>> sccb. Perhaps this function name doesn't hold up well.
>>
>> Does sccb_check_sufficient_len make more sense?
>=20
> To me it does.
>=20
>>
>> I think the same could be said of the boundary check function, which
>> also sets the response code.
>>
>> What about setting the response code outside the function, similar to
>> what sclp_comand_code_valid does?
>=20
> Whatever results in the least code churn to make it consistent ;)
>=20
>>
>>>> +
>>>>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, =
int *count)
>>>>  {
>>>>      uint8_t features[SCCB_CPU_FEATURE_LEN] =3D { 0 };
>>>> @@ -66,6 +94,16 @@ static void prepare_cpu_entries(MachineState *ms,=
 CPUEntry *entry, int *count)
>>>>      }
>>>>  }
>>>> =20
>>>> +/*
>>>> + * The data length denotes the start of the struct to where the fir=
st
>>>> + * CPU entry is to be allocated. This value also denotes the offset=
_cpu
>>>> + * field.
>>>> + */
>>>> +static int get_read_scp_info_data_len(void)
>>>> +{
>>>> +    return offsetof(ReadInfo, entries);
>>>> +} =20
>>>
>>> Not sure what the policy for this is, but maybe this can go into a
>>> header file?
>>> David and Conny will surely make that clear to me :)
>>>  =20
>>
>> Not sure either. If anything it might be a good candidate for an inlin=
e
>> function.
>=20
> If we don't process read info outside of this file, no need to move it
> to a header. The compiler is probably also smart enough to inline it on=

> its own, I guess.
>=20
>=20

I'm also ok with the names and the rest



--e5s5OZqfvRUhatcbhJPVtjYtw4xlFloM4--

--eRln5ziRD2q6Rn1DegXOXUkRvoqM4u0Vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7Lo8UACgkQ41TmuOI4
ufgCkA/+OifwRI4oHarwf1uIX9mj7OtworMePPwdPxfn5ul+OGX6ZmGhNQC197Zc
3cXQlcUehpCCWahBpzqZnYjYWgqwdhjHnTsTqXIrkvJsDVt+k6fOBW1rFFuWg+PE
d85AH06D0sxuIK+mU/ZPDNwCnSt7f9/B8DpwgYsnSooOEMfugjT0ods+rIO0uBiT
uPZFu3MfKYHGKF/5AdlfJh4VlrsMJ1xy+tAgbkG/e7hTf2WOBeSp6zahqVdPqblp
QTKgPlsGu/NEeykWy0lUlGtQG6v8NHfDE5143btFmT7qp1hGn2DqUPvuEdbvJqnz
P44Slmt0WjVbt7q3W1wsPPRIbC1PvaZebX76FHM+DvgELzLzGJ8p4CixBtva21OK
oeLVU8LptmJrsIkncL1MjzlhtOzfOOd4tDOvyIikwBeUP2PrmPQXmnbJ1fD76F6i
NW3xCu3KzL+FW5dwgw+ivPvp7NmPQVHUWBGim5EOHeLncDGB0c7cyVK+8ZnuTLTa
PNSmKXJGgh8xaZTj4JJTv4YxBORwqccNUflnlUCvWjd2D9Yz9ixjjeYMyNmHMX7u
Er8i2J/HpkqevTDo8YqUMnvRp6jM/Gleswo9JqIFY8eHLUrOPbEkXF9XhjHR5Lr0
ET05m9MD5ZIecdMwQrK/7DZ2uL+AGTY90Wj9Bu2jK2JbgQAW6sw=
=m4PZ
-----END PGP SIGNATURE-----

--eRln5ziRD2q6Rn1DegXOXUkRvoqM4u0Vr--


