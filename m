Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E6C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D077A2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D077A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIprr-00033x-22
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIpoQ-0000dB-1y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIpoO-0002x5-Qb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIpoB-0002pd-RG; Fri, 11 Oct 2019 03:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18E671DA3;
 Fri, 11 Oct 2019 07:57:55 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC4B60466;
 Fri, 11 Oct 2019 07:57:53 +0000 (UTC)
Subject: Re: [PATCH 04/23] iotests: Filter $SOCK_DIR
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
 <20191010152457.17713-5-mreitz@redhat.com>
 <a9930ccd-dcee-ef5f-20f0-a2a909b5cf86@redhat.com>
 <cbe205ec-536b-1f91-6a52-465155c34995@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <8235efed-8924-a774-10b8-2e7dc69e042d@redhat.com>
Date: Fri, 11 Oct 2019 09:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cbe205ec-536b-1f91-6a52-465155c34995@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kn2aPy80SGoawR6owJrZPKnl44HtcTq4L"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 11 Oct 2019 07:57:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kn2aPy80SGoawR6owJrZPKnl44HtcTq4L
Content-Type: multipart/mixed; boundary="81EVJxgqITVlvgsMbQlGEJlLDdBmsKgt2";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8235efed-8924-a774-10b8-2e7dc69e042d@redhat.com>
Subject: Re: [PATCH 04/23] iotests: Filter $SOCK_DIR
References: <20191010152457.17713-1-mreitz@redhat.com>
 <20191010152457.17713-5-mreitz@redhat.com>
 <a9930ccd-dcee-ef5f-20f0-a2a909b5cf86@redhat.com>
 <cbe205ec-536b-1f91-6a52-465155c34995@redhat.com>
In-Reply-To: <cbe205ec-536b-1f91-6a52-465155c34995@redhat.com>

--81EVJxgqITVlvgsMbQlGEJlLDdBmsKgt2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/10/2019 09.54, Max Reitz wrote:
> On 10.10.19 20:42, Eric Blake wrote:
>> On 10/10/19 10:24 AM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/common.filter | 8 ++++++--
>>> =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/common.filter
>>> b/tests/qemu-iotests/common.filter
>>> index 9f418b4881..cd42f5e7e3 100644
>>> --- a/tests/qemu-iotests/common.filter
>>> +++ b/tests/qemu-iotests/common.filter
>>> @@ -43,7 +43,8 @@ _filter_qom_path()
>>> =C2=A0 # replace occurrences of the actual TEST_DIR value with TEST_D=
IR
>>> =C2=A0 _filter_testdir()
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 $SED -e "s#$TEST_DIR/#TEST_DIR/#g"
>>> +=C2=A0=C2=A0=C2=A0 $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$SOCK_DIR/#SO=
CK_DIR/#g"
>>
>> Do we want to output a literal 'SOCK_DIR' (every test that uses it has=

>> to update their expected output), or can we make this also output a
>> literal 'TEST_DIR' (output is a bit more confusing on which dir to loo=
k
>> in, but fewer files to touch)?=C2=A0 Your preference.
>=20
> There=E2=80=99s another advantage to filtering it to be TEST_DIR, and t=
hat=E2=80=99s the
> fact that if $TEST_DIR and $SOCK_DIR are the same, we will always
> replace $SOCK_DIR by TEST_DIR.
>=20
> But I still preferred filtering it to be SOCK_DIR, because that seemed
> to me like we would have done it had we had a SOCK_DIR from the start.

I also think that using SOCK_DIR is the better choice. It's a little bit
more churn now, but in the long run, it will help to avoid confusion,
and I think that's more important.

 Thomas



--81EVJxgqITVlvgsMbQlGEJlLDdBmsKgt2--

--Kn2aPy80SGoawR6owJrZPKnl44HtcTq4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2gNgEACgkQLtnXdP5w
LbUzeQ//c9A17ElsbUE2LwMehCxqvyJM/kwcLy7TB3SZ7dxe2WAX4X5mVD497jo6
lvwARFxaozmwn3wdqMzRzjPeL6MqH2PE2fd1HG1UzpYlxipbNZlEyd8YflHiqrPC
I1XjVIB1i++2tX7sh2Fgdry+DIW7lIaQKHcCrWaBVHEpgZx3T3VtTU5U4VAOMXK+
G7xrQGqoLoZ6fhWI3LFD6fbi4hi525nmCtBk5gYx1r0HfpavfMLs+ghuHt+ipChj
QSqjD/LnnogNHyUi0GXUTB++yqWo6xywWqYFLg0weehkR7jXEGVTf/4EzGiVOafa
tlJwOWyGJFufzxwuRtLcvdAPEKs9kkaN+NS74bcSxkAVgRD2h3ix+NCIsJqYC2qr
fpjoeCZTxkvmL2IR9DPocHLURREG17Khxg3gGjVDKCnUNfwLv+iWKK/HuvqE/2m4
vjRevFssaO0pVrEG+zyI6J0CMn5DfQqe/7ZJ+dgOcRkYrDzAejazBnn4MGtFPeKA
nKL7PbV/WvW62zLdHnejJP21QgAv1lGThUV7Gpa3LY4KaudTpsIi6KkEvU4yfy/8
ffgrs4/KKINvfPFkId519qoaQE1GKLzVp0SmwKpG2rnVZxJa5LqeYI6chrUDXZJt
X17C7H5wBBykGvIzgUjFBJPSFDpIudvH+X47bGosbrFs9u/V3ug=
=Q6UQ
-----END PGP SIGNATURE-----

--Kn2aPy80SGoawR6owJrZPKnl44HtcTq4L--

