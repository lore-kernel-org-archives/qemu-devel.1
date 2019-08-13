Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A820C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F9820665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F9820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxQiP-0004G8-Ed
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 02:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hxQhF-0003g3-Sr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hxQhE-0000wt-HR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:54:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hxQhC-0000tO-6w; Tue, 13 Aug 2019 02:54:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 679103090FC4;
 Tue, 13 Aug 2019 06:54:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-154.ams2.redhat.com [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 654A57EB90;
 Tue, 13 Aug 2019 06:54:09 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <c293e99d-331a-f3aa-eecb-d562554350f9@redhat.com>
 <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>
 <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <56e13788-f253-ec71-52b6-ad6eb5afe739@redhat.com>
Date: Tue, 13 Aug 2019 08:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PLE6Yh9yzcr7INPd9BfDKerG9YSYhzeZi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 06:54:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] qemu-iotest 059 fails with vmdk
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PLE6Yh9yzcr7INPd9BfDKerG9YSYhzeZi
Content-Type: multipart/mixed; boundary="Uj4jx2inhpeNbsiWGRgjNigUt1jBATWI2";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <56e13788-f253-ec71-52b6-ad6eb5afe739@redhat.com>
Subject: Re: [Qemu-block] qemu-iotest 059 fails with vmdk
References: <c293e99d-331a-f3aa-eecb-d562554350f9@redhat.com>
 <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>
 <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>
In-Reply-To: <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>

--Uj4jx2inhpeNbsiWGRgjNigUt1jBATWI2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/12/19 9:20 PM, Max Reitz wrote:
> On 12.08.19 21:14, John Snow wrote:
>>
>>
>> On 7/22/19 8:58 AM, Thomas Huth wrote:
>>> Not sure if it has been reported before, but test 059 currently fails=
:
>>>
>>> 059      fail       [14:55:21] [14:55:26]                    output
>>> mismatch (see 059.out.bad)
>>> --- /home/thuth/devel/qemu/tests/qemu-iotests/059.out	2019-07-19
>>> 10:19:18.000000000 +0200
>>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/059.out.bad	2019-07=
-22
>>> 14:55:26.000000000 +0200
>>> @@ -27,7 +27,7 @@
>>>  image: TEST_DIR/t.vmdk
>>>  file format: vmdk
>>>  virtual size: 0.977 TiB (1073741824000 bytes)
>>> -disk size: 16 KiB
>>> +disk size: 517 KiB
>>>  Format specific information:
>>>      cid: XXXXXXXX
>>>      parent cid: XXXXXXXX
>>> Failures: 059
>>> Failed 1 of 1 tests
>>>
>>> ... I think this was working fine for me a couple of weeks ago, so I
>>> assume this is a rather new bug?
>>>
>>>  Thomas
>>>
>>
>> I know this is a pretty late response, but "worksforme" -- did someone=

>> address this in the meantime? I don't see any commits to 059 in some
>> time. (Not since March.)
>=20
> I didn=E2=80=99t because I could never reproduce this failure.  (XFS/tm=
pfs here.)
>=20
> I have =E2=80=9Cvmdk: Misc fixes=E2=80=9D on list which came from runni=
ng the iotests
> with all possible subformats (which broke many things, but not 059 in
> this way).

FWIW, I now updated my system from RHEL7 to RHEL8 and I can now also not
reproduce the issue anymore. Must have been some other oddity with the
ext4 filesystem of my RHEL7 system, or maybe it has been fixed by
another patch in the meantime...?

 Thomas




--Uj4jx2inhpeNbsiWGRgjNigUt1jBATWI2--

--PLE6Yh9yzcr7INPd9BfDKerG9YSYhzeZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1SXpAACgkQLtnXdP5w
LbWSgQ//eEE03S0PGBxg+0yDPl+ViVOKzJXlQNGJypeFaZtzRqU8DEsNA2Eu21cW
X/C75pWNNMd//buj0x8Di9z+x7sCD6rNf1oTibLK/mcRSlKcP2V3Bjyez83ngFZP
YAGb0uG29n+xpXMMlblPiO2YtpwFmactJrQqePMC3BLtRASk0uGEx+j9Eg03dqDe
6nlEJWY4NIY7Nsywh3habvx3gJB7BtLypVBnkjI6iCq6vYBnhOQ0BtsCkOIoOMxR
e77SyrSIYafcCnGtIjQqxzl4+F8EfKfj2nEXyycp3W0r7LKY5c4sxeODEb7N0+Ga
4A/PRUrR80uicMgMoouHqjH6f6SuxgU3DDAU4mzaySauwg4OUcJwm+VaBYwSYgiw
CpmjO+XF9UUNLpOvSg7uSM3OvGWbnc8rFSxURDCo3uDR09N1O1UZOuY2CY/hx50H
FQpsbeW+Tpf9rpzGWhxMvI8N+V7dvLTh7d7voRIC3fMgoJ8cqbSP7zq3GoGPIeXB
XkSiQQCiu6ShGqM8D/7tMSWEC5z31Q02tZPsqQmINt/TGn7BGVeENllT3cmWbDHb
mNpESuFUzT7GlmHHvq1Az15toEDmDWWGrqIe6Gg/qP2BbobFBwN/AB33O/lpF3CA
MR7/VInBEbL8kg7bc11jPLUkPC3lCG1Yzy8N/kLsSg21N4nt1tg=
=rf09
-----END PGP SIGNATURE-----

--PLE6Yh9yzcr7INPd9BfDKerG9YSYhzeZi--

