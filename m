Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086AC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A822173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A822173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho143-0000XR-2q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 03:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1ho13s-0008UI-27
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ho13q-0003Th-QZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1ho13o-0003Pi-4s; Thu, 18 Jul 2019 03:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66E643082145;
 Thu, 18 Jul 2019 07:42:39 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF365D71D;
 Thu, 18 Jul 2019 07:42:37 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-3-thuth@redhat.com>
 <1832e90b-0fd2-19ac-f90e-572147e51f53@redhat.com>
 <62ec1243-3bb9-c18d-0ff6-4c4ad193620c@redhat.com>
 <03b260f7-b108-f035-2974-17b5ef74e4e6@redhat.com>
 <99ee850e-d9e0-1079-7fb2-64a1901009e6@redhat.com>
 <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
 <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
 <94a85c94-5758-0e09-1a34-127cb26fe115@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Organization: Red Hat
Message-ID: <ea58a04d-f67f-da36-2f05-315776187b0b@redhat.com>
Date: Thu, 18 Jul 2019 09:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <94a85c94-5758-0e09-1a34-127cb26fe115@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mr8BTshkkOlUm9ebQ1TZ6ynSGMSPKOPas"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 18 Jul 2019 07:42:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tests/qemu-iotests/group: Remove
 some more tests from the "auto" group
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
--mr8BTshkkOlUm9ebQ1TZ6ynSGMSPKOPas
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/07/2019 18.12, Max Reitz wrote:
> On 16.07.19 18:09, Eric Blake wrote:
>> On 7/16/19 10:58 AM, Max Reitz wrote:
[...]
>>>> Is there any way to create our sockets somewhere under /tmp instead =
of
>>>> inside tests/qemu-iotests, so that we have a shorter filename for
>>>> sockets no matter how deep in the file hierarchy the tests themselve=
s live?
>>>>
>>>> Also, at one point, we tossed around the idea of
>>>> s/qemu-iotests/iotests/, to shave off 5 characters that don't really=
 add
>>>> anything.
>>>
>>> I=E2=80=99d personally rather just skip the iotests if we detect such=
 a silly
>>> OS, but maybe that=E2=80=99s just me.
>>
>> It's a rather unfortunate limit, but it's not all that silly (the limi=
t
>> is based on the fact that struct sockaddr has to fit inside a nice
>> power-of-2 structure somewhere in the kernel, and enough else is used
>> that you really are left with just 104/108 bytes, or even 92 bytes if
>> you use HP-UX 11).  POSIX does not place a minimum length on sun_path,=

>> but I know of no system that does not allow at least 92 bytes, if you
>> are aiming for a portably-small name.
>=20
> It does come to me as a surprise that the sockaddr is a path instead of=
,
> say, an inode number.
>=20
> But shaving off the =E2=80=9Cqemu-=E2=80=9D seems like the wrong approa=
ch to me still.

Anyway, it would be great if someone who's familiar with the code could
find a proper fix for this problem. FWIW, it also happens on Linux:

mkdir /tmp/01234567890123456789012345678901234567890123456789012345678901=
23456789012345678901234567890123456789
cd /tmp/01234567890123456789012345678901234567890123456789012345678901234=
56789012345678901234567890123456789/
~/path/to/qemu/configure --target-list=3Dx86_64-softmmu
make -j8
cd tests/qemu-iotests/
=2E/check -g quick -qcow2
=2E..
058      fail       [09:29:33] [09:29:34]                    output misma=
tch (see 058.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/058.out	2019-04-23 16:43:12=
=2E000000000 +0200
+++ /tmp/0123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789/tests/qemu-iotests/058.out.bad	2019-=
07-18 09:29:34.305070819 +0200
@@ -17,18 +17,22 @@
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 8192
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-nbd: UNIX socket path '/tmp/012345678901234567890123456789012345678=
9012345678901234567890123456789012345678901234567890123456789/tests/qemu-=
iotests/scratch/qemu-nbd.sock' is too long
+Path must be less than 108 bytes
=2E..
065      fail       [09:29:38] [09:29:38]                    output misma=
tch (see 065.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/065.out	2019-04-23 16:43:12=
=2E000000000 +0200
+++ /tmp/0123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789/tests/qemu-iotests/065.out.bad	2019-=
07-18 09:29:38.568118520 +0200
@@ -1,5 +1,41 @@
-........
+....E..E
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_qmp (__main__.TestQCow3LazyQMP)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "065", line 75, in setUp
+    self.vm.launch()
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/mach=
ine.py", line 294, in launch
+    self._launch()
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/mach=
ine.py", line 311, in _launch
+    self._pre_launch()
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qtes=
t.py", line 103, in _pre_launch
+    super(QEMUQtestMachine, self)._pre_launch()
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/mach=
ine.py", line 262, in _pre_launch
+    server=3DTrue)
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qmp.=
py", line 60, in __init__
+    self.__sock.bind(self.__address)
+OSError: AF_UNIX path too long
=2E..

 Thomas


--mr8BTshkkOlUm9ebQ1TZ6ynSGMSPKOPas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJdMCLtAAoJEC7Z13T+cC210X4QAJGdu6mzArdHDXSVhefwL7Qt
9UBnWRnML+1NGwwEL4JneZaJ2YS1RlAyLbGk4Wk/yPvhm4mbCHoO6QcvTOg0/msI
UfteXRbYYSe9noZAfipNmsT8WesgM1pdgZIakz26pIImFy1m87Veqpopxz/nN5oZ
sf+h0FQP8F2CzPVkQeHRT3cAE9Xgy1fTCYYOSHeEOBiMTvLugM1J9skXqkfKMaiU
oHAItHlMpj+QrDsg7zHjICkVv3rII8gEL4g7BMSXGJrg9tCzSoRcX6CVI9vMVsnB
7rGp/ZfMI+1o1aSczVvn3mTaWyfZkWZs0E2S0bg2n486sYNmYzeOj9w9MVinuB5H
X/MJVGpwhewGEjSmb4LrFArwgjTgchTSE/t3Iqt7fP3xXaTHBrIFOKGeM2VrLHx0
b59z4M8oOZkxINdzm+ZBGbc5crEPf/FCwhIUx+u+sm+cpioxVOkKt5yw5reYEW1V
oyG2JGGCkgDEW5PZrPQpMy8wHkKNddQ3mYekf+L1SvVjiK8CpkD6++AB2Si3Y7e4
CPaGxJ5Xon3dL8opSY5lz/v/wPMso730VcDpRoPimtknzTy5+9sixhT0KZNXsLy4
5wMVwGcGCy/3BQgjaamOcfmGXPh04SQbUPk1wXq45Ei+7bWJhu9ugbcgemoqYIxF
6EV2iscOXKFI0khJWZ0o
=Ltg2
-----END PGP SIGNATURE-----

--mr8BTshkkOlUm9ebQ1TZ6ynSGMSPKOPas--

