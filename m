Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F862C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0698C20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0698C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJNU-0007bF-9L
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hnJNI-00078X-2y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hnJNG-0005sg-Vu
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:03:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hnJNE-0005rB-DM; Tue, 16 Jul 2019 05:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A34BF307D847;
 Tue, 16 Jul 2019 09:03:47 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C73B6092D;
 Tue, 16 Jul 2019 09:03:46 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20190715145438.6880-1-thuth@redhat.com>
 <20190715145438.6880-2-thuth@redhat.com>
 <db02273f-24ea-5c90-a206-b8203db2c819@redhat.com>
 <d8430e47-3fe6-d3f4-bdbd-529b9cf31ae5@redhat.com>
 <d62de778-5e2a-c7c2-7dc7-4cb2f78b8552@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Organization: Red Hat
Message-ID: <a8e79f08-22ee-6adc-7de0-4f870d91eb12@redhat.com>
Date: Tue, 16 Jul 2019 11:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d62de778-5e2a-c7c2-7dc7-4cb2f78b8552@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xjWzcqW80prrO6oZIHc0e2dLWQFL3Xoam"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 16 Jul 2019 09:03:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/qemu-iotests/group: Remove some
 more tests from the "auto" group
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xjWzcqW80prrO6oZIHc0e2dLWQFL3Xoam
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/07/2019 19.17, Max Reitz wrote:
> On 15.07.19 17:18, Thomas Huth wrote:
>> On 15/07/2019 17.12, Eric Blake wrote:
>>> On 7/15/19 9:54 AM, Thomas Huth wrote:
>>>> Remove some more tests from the "auto" group that either have issues=

>>>> in certain environments (like macOS or FreeBSD, or on certain file s=
ystems
>>>> like ZFS or tmpfs), do not work with the qcow2 format, or that are s=
imply
>>>> taking too much time.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/group | 109 ++++++++++++++++++++----------------=
---
>>>>  1 file changed, 55 insertions(+), 54 deletions(-)
>>>
>>>>  251 rw auto quick
>>>>  252 rw auto backing quick
>>>> -253 rw auto quick
>>>> -254 rw auto backing quick
>>>> -255 rw auto quick
>>>> -256 rw auto quick
>>>> +253 rw o_direct quick
>>>
>>> Where is the new 'o_direct' group documented?  Is this a typo for
>>> something else?
>>
>> I needed a new group for test 142 since it would be without any group =
at
>> all otherwise:
>>
>> -142 auto
>> +142 o_direct
>>
>> Tests without a group are currently only possible if the line ends wit=
h
>> a space - which is quite error prone.
>=20
> Why not just fix that, then?

That's of course the even better solution :-)

>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index f925606cc5..c24874ff4a 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -488,7 +488,7 @@ testlist options
>>  BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t=
 }' \
>>          | while read id
>>          do
>> -            if grep -s "^$id " "$source_iotests/group" >/dev/null
>> +            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/=
null
>>              then
>>                  # in group file ... OK
>>                  echo $id >>$tmp.list
>> @@ -547,7 +547,7 @@ else
>>          touch $tmp.list
>>      else
>>          # no test numbers, do everything from group file
>> -        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_i=
otests/group" >$tmp.list

That old "[       ]" looks quite strange anyway! I guess there was a TAB
in here originally which got replaced by spaces at one point in time?

>> +        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source=
_iotests/group" >$tmp.list
>>      fi
>>  fi
>> =20
>=20
> looks to be enough for me.

Seems to work, thanks! I'll respin my series with your patch included.

 Thomas


--xjWzcqW80prrO6oZIHc0e2dLWQFL3Xoam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJdLZLxAAoJEC7Z13T+cC21WQkP/RGQEVS4tG5UBhKUu5uDQdS/
8KW35EDVocuBX42363QowfDs3X6sov35jsbMIMYzUItvF1g6cfCeYh30ajKd9Lfv
t7ZhnJ38WoZ8iaFWzW1I1hgUY03wYpR2yfUAEjbK2C/ZWEdfqJutFfvt8j37An8Y
cc1Pv48xVuTMDBDXxzWwxbfIYx3I+0F7D2qZKEDlih6mq5gyebALzh6HFEJUO5yh
LJJW/FMgPau6IlhfGifeFHIRvoAFpA0DlTfyW3bSeFcYCgumUGyM85RbhVzUjfak
xrfBb852Ebr2a+JpXHjNOOXj9RhpfXgIA9U5+ajXHocGh9rAqnwN2Zdqftjl93Td
2zqbl+30uYfRuywIDXuZJ4rUqGgqwgSseG4y57ThYHNaVYKSsTnLVrgGLdNoPDD+
ks2MySgjkgewsoSpjAWIe+NdqySc8hA6J6jFhVI+DlH2CMxThAwUuTWGjAzVEA+4
YbR1l+TWifhuk8JE+7fynfzxYrBc487MIw0nkLwCNWcPIYJGqpjE3+yPwyrKr8tB
w4wTslpAoB55QbiiwJG5MjXU1ho8H/c+AErDBW87FG6txg7hJ5+4pSN+nfRYEn4S
AHr+cyZHOAXmmlRy/mRrT0jqpsRoNcT68Z8tXxae6I8i0l7Nn9IhREFYZCLYu4Oj
RXweq15B7qKD2YwVQRz6
=Zf0o
-----END PGP SIGNATURE-----

--xjWzcqW80prrO6oZIHc0e2dLWQFL3Xoam--

