Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42556C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5D2206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYm44-000591-6P
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 03:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jYm3Q-0004VY-3b; Wed, 13 May 2020 03:43:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7902
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jYm3P-0006XX-2d; Wed, 13 May 2020 03:43:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04D7VvCI109346; Wed, 13 May 2020 03:43:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxh1yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 03:43:44 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D7YEFJ129762;
 Wed, 13 May 2020 03:43:44 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxh1xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 03:43:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D7eUwY018508;
 Wed, 13 May 2020 07:43:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 3100ub937w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 07:43:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04D7hdBF60686406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 07:43:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48105A404D;
 Wed, 13 May 2020 07:43:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B16E9A4055;
 Wed, 13 May 2020 07:43:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.14.159])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2020 07:43:38 +0000 (GMT)
Subject: Re: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-3-walling@linux.ibm.com>
 <58bc496c-28bb-26f8-ab46-aba6ad141717@linux.ibm.com>
 <737869a8-13b2-1831-00c6-629d5a109d9c@redhat.com>
 <05ab2e59-10c0-c7df-c014-b54883ddccd3@linux.ibm.com>
 <9a39a948-91a1-7cfe-f2a5-d30e5564f318@redhat.com>
 <20200512180140.4be69d60.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5ed5bc04-e4e3-21ca-057f-a978ef411ad8@linux.ibm.com>
Date: Wed, 13 May 2020 09:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200512180140.4be69d60.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="54Ko7dESBoJ92ls0nJaYmy2kxEyCBCE5F"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_02:2020-05-11,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:43:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Collin Walling <walling@linux.ibm.com>, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--54Ko7dESBoJ92ls0nJaYmy2kxEyCBCE5F
Content-Type: multipart/mixed; boundary="gMqlXQViMdHCPD8fA00C88VEVAUSyoV1s"

--gMqlXQViMdHCPD8fA00C88VEVAUSyoV1s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/12/20 6:01 PM, Cornelia Huck wrote:
> On Mon, 11 May 2020 17:02:06 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 11.05.20 16:50, Janosch Frank wrote:
>>> On 5/11/20 4:44 PM, David Hildenbrand wrote: =20
>>>> On 11.05.20 16:36, Janosch Frank wrote: =20
>>>>> On 5/9/20 1:08 AM, Collin Walling wrote: =20
>>>>>> The SCCB must be checked for a sufficient length before it is fill=
ed
>>>>>> with any data. If the length is insufficient, then the SCLP comman=
d
>>>>>> is suppressed and the proper response code is set in the SCCB head=
er.
>>>>>>
>>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com> =20
>>>>>
>>>>> Fixes tag?
>=20
> Probably
>=20
> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
>=20
> ?
>=20
>>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com> =20
>>>>
>>>> This is not a fix AFAIKs.
>>>> sclp_service_call()/sclp_service_call_protected() always supplies a =
full
>>>> SCCB of exactly 4k size.
>>>> =20
>>>
>>> We don't check for QEMU's 4k buffer here, but for the length that was=

>>> specified by the guest.
>>>
>>> It's valid for the guest to request cpu info and state that its buffe=
r
>>> is only 1k. We can't write everything in 1k if we have ~200 cpus, so
>>> we'll report the insufficient length rc.
>>>
>>> What he fixes here is the time of the length check, it should be done=

>>> before any changes are being done to the work_sccb. =20
>>
>> I don't have access to the spec, especially, if the guest can expect
>> nothing else in the sccb to change in case we report an error code. So=

>> whatever you tell me, I have to trust you :)
>=20
> Same here. Sounds plausible, but I have to trust the folks with the
> documentation :)
>=20

The AR states that:
* Command validity check (has prio over length, as length is dependent
on command)
* boundary (if extended-length is not available)
* Sufficient length check

are done before "any other command action is taken".
If a test fails the command is suppressed.





--gMqlXQViMdHCPD8fA00C88VEVAUSyoV1s--

--54Ko7dESBoJ92ls0nJaYmy2kxEyCBCE5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl67pSoACgkQ41TmuOI4
ufgkCw//cMC3uNJ5TiAQ3A07dP+oroL5YF9IkXTLZ9I+Mn6lKLgMmdv4RJnVut1X
eGQcKvqdyiwpScMNbMXWI5a/uIBkDLjP9N/yyhseUNVuQaf9pty1bkC1DdaOFdw/
dUpVmEqCWgeZKn3hp0eL5avUZSQ4sNDbVZPC0dAqFuW4/nEXwEwa/+tT4v/rLs8C
AdK1C3//GViH092CoSNSH0IGTjnLClsi7EqH/89AASDh0DnDzMVCUycpkgh0KRkF
GUb7z6vvIV748qHhpbghio221u1BS0FtRYFFjwO/45Krpine/zS2/rtVKYBFfXf7
b/MVZPjo/RAX2/aSQ0jTSFQzrIoOVatCO0AmT/Xn4wputeKLQoLihCVsHY2SwYHT
lJAjVfvcqMpo16S7r2lhL+V1tARii01aMLtv/Zs8vzJCznGoMmtpFJYAr9g73tps
iinhvIHXb2HML3k9BdZVnoJyEFUGlYD8trB7TQgBvj49CHWeJsEEP2GlY3vIicfR
tOMMA9RlhB55EU48+PkpHH8ihDgMrS3ZcjoNbebeXgyL1yy25oAeueTEQNz/nLrE
9AihffwfRvbBJX/xEvAI2dfjRKzD+ScHcyMF96ZSvpPu96sHAeSdTE7Iefb91m5j
jrIntRRCj8Jw1nX/x9cFlrlyJp0QXLmcZ/oXO9qCnZrm5Rq9sKA=
=VvwJ
-----END PGP SIGNATURE-----

--54Ko7dESBoJ92ls0nJaYmy2kxEyCBCE5F--


