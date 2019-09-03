Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66113C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A931215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A931215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58k3-0006qI-DZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i58j7-0006DD-Vu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i58j6-0006Nb-R1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i58j3-0006MF-BW; Tue, 03 Sep 2019 09:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EA603064FD3;
 Tue,  3 Sep 2019 13:20:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-51.ams2.redhat.com [10.36.117.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383A85DD6F;
 Tue,  3 Sep 2019 13:19:57 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190823133552.11680-1-thuth@redhat.com>
 <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <9a627de1-dd69-9e12-05cf-2baca8025f9c@redhat.com>
Date: Tue, 3 Sep 2019 15:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jt15zPbfOxPNjpeh523sgkUJPNt1xarZZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 03 Sep 2019 13:20:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Check for enabled drivers
 before testing them
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
--jt15zPbfOxPNjpeh523sgkUJPNt1xarZZ
Content-Type: multipart/mixed; boundary="Wx3yVnk0MCBBrjbwZ3Mkiql2bg27ZkqbN";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9a627de1-dd69-9e12-05cf-2baca8025f9c@redhat.com>
Subject: Re: [PATCH v2] iotests: Check for enabled drivers before testing them
References: <20190823133552.11680-1-thuth@redhat.com>
 <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>
In-Reply-To: <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>

--Wx3yVnk0MCBBrjbwZ3Mkiql2bg27ZkqbN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/09/2019 14.55, Max Reitz wrote:
> On 23.08.19 15:35, Thomas Huth wrote:
>> It is possible to enable only a subset of the block drivers with the
>> "--block-drv-rw-whitelist" option of the "configure" script. All other=

>> drivers are marked as unusable (or only included as read-only with the=

>> "--block-drv-ro-whitelist" option). If an iotest is now using such a
>> disabled block driver, it is failing - which is bad, since at least th=
e
>> tests in the "auto" group should be able to deal with this situation.
>> Thus let's introduce a "_require_drivers" function that can be used by=

>> the shell tests to check for the availability of certain drivers first=
,
>> and marks the test as "not run" if one of the drivers is missing.
>>
>> This patch mainly targets the test in the "auto" group which should
>> never fail in such a case, but also improves some of the other tests
>> along the way. Note that we also assume that the "qcow2" and "file"
>> drivers are always available - otherwise it does not make sense to
>> run "make check-block" at all (which only tests with qcow2 by default)=
=2E
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Update the check in _require_drivers() according to Max' suggestion=

>>  - Remove superfluous check in test 081
>>  - Mark 120 to require "raw"
>>  - Replaced the check in 162 to use the new _require_drivers() functio=
n
>>  - Mark 186 to require "null-co"
>>
>>  tests/qemu-iotests/071       |  1 +
>>  tests/qemu-iotests/081       |  4 +---
>>  tests/qemu-iotests/099       |  1 +
>>  tests/qemu-iotests/120       |  1 +
>>  tests/qemu-iotests/162       |  4 +---
>>  tests/qemu-iotests/184       |  1 +
>>  tests/qemu-iotests/186       |  1 +
>>  tests/qemu-iotests/common.rc | 14 ++++++++++++++
>>  8 files changed, 21 insertions(+), 6 deletions(-)
>=20
> This patch breaks these iotests when $DISPLAY is not set.  It does work=

> with =E2=80=9Ciotests: Add -display none to the qemu options=E2=80=9D.
>=20
> Hm.  You reviewed that one, so I suppose I=E2=80=99ll just take it into=
 v2 of my
> pull request as well.

Sounds like the righ way to go, thanks!

> (I=E2=80=99m not going to say having added the iotests to make check gi=
ves me as
> a maintainer more trouble than I had before, but, you know.)

I expected some initial trouble, since the iotests now get exposed to
much more different systems. But I hope it will pay off in the long run!
(Remember the 4.1 development cycles? The iotests have been completely
broken in the master branch by accident two or three times ... I hope at
least those days will now be gone or at least not happen that often anymo=
re)

 Thomas


--Wx3yVnk0MCBBrjbwZ3Mkiql2bg27ZkqbN--

--jt15zPbfOxPNjpeh523sgkUJPNt1xarZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1uaHgACgkQLtnXdP5w
LbUdxA/9GgKnbgvKKw9fyxLNwtlXXFp6exbbdZJjxvlWmy87DOGjNOBJzgqU0q++
XRvQC5yzNZf1MZb09Kq/1jjGK1X79kYG1kJw1tIynNw85PF3E7dXRBdD0jjbpHD0
4u7AaweQ10MmLvtjcaNMc83/eVZ+BVCBmbrJBO8WS3RVBqQOvxAU3MOgi3MXQvie
tWXqB+R6M/Kp/U+iazcVgwl3WIAkAPRF7xZI+G9xPlYBvrOc+k1TYwM0IqZAz1Bs
Gh1cF0/I6LlKz4f9zTAP0ITl0eKFIvz+FsqEHW/2DY8imSPtS+loPOmDMvSkWOam
DUITiGS2hAjOecmL5VuU/qndUqU/PG2eYc9A4/C1xICHiOmrBNePxKVeY9Tmu+9O
/xQdJQt9NxATPF6yJevPs7rjdHusDB9mN0qLoPFAyReB4s7UrKUsb7w0SVHjq5RM
FwxyqEo10LtgmkU7Soc4qiDfF79StG3OC7r/7CJBbJUWQpMGqt/Q7cPvBQ2Au9dc
AKr83Dqz9hZFF8+SMIb/3US7bZGy/40s8uHQLe43h8piv9BR8t9UXY5+qriDkkc8
1AgDha+JbO3ioRZbe9xAJLGyMFoctSDln1BH4/cfCzvacdt0JzGedhG5IHE8LVTG
KjbJFv+VXqT8vJYjCLrcenvi8Z5cUJcVcvWfMXlDLMd2uSVpxhQ=
=g3hb
-----END PGP SIGNATURE-----

--jt15zPbfOxPNjpeh523sgkUJPNt1xarZZ--

