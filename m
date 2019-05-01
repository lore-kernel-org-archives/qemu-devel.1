Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01AC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E58620866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 13:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLpQc-0006SN-G6
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 09:37:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpPl-00067a-Dd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLpPi-0003ez-8w
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hLpPY-0003b1-GX; Wed, 01 May 2019 09:36:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82ABD37E79;
	Wed,  1 May 2019 13:36:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-251.ams2.redhat.com [10.36.116.251])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6B6460148;
	Wed,  1 May 2019 13:36:27 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
	<alex.bennee@linaro.org>
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
	<3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <733e7c9b-fc1a-b2f3-89b0-084424f7e56b@redhat.com>
Date: Wed, 1 May 2019 15:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 01 May 2019 13:36:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501133621.vPV-UjadaF1QKYw73v2ue9ojKTiI--08A6qyHs2gQ9M@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/05/2019 14.06, Eric Blake wrote:
> On 5/1/19 6:08 AM, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> "check -raw 005" fails when running on ext4 filesystems - these do no=
t
>>> support such large sparse files. Use the same check as in test 220 to=

>>> skip the test in this case.
>>>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/qemu-iotests/005 | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>>> index 2fef63af88..6136ced5c8 100755
>>> --- a/tests/qemu-iotests/005
>>> +++ b/tests/qemu-iotests/005
>>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>>      _notrun "image protocol $IMGPROTO does not support large image s=
izes"
>>>  fi
>>>
>>> +# Sanity check: For raw, we require a file system that permits the c=
reation
>>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>>
>> Is this comment correct? Running on my ext4 home partition this test
>> seems to be running fine and not skipping. Indeed:
>=20
>>> +if [ "$IMGFMT" =3D "raw" ]; then
>>> +    if ! truncate --size=3D5T "$TEST_IMG"; then
>=20
> 5T fits on ext4 but not ext3.

It fails for me on my ext4 partition. Anyway, I'll change the comment.

 Thomas


--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcyaDaAAoJEC7Z13T+cC216V4P/iTblcQBu/eJww3rw4zdlckX
gZ7GH31BIqMzHPCcJnt5twBpU2Hv668Gn2It1NNcUXW32wcAJwEjC6BAsTxwif+Y
b+n9UdPKQiNB+QREiIoUTAR8ex4CKqpV9SII0fnBqvOkRrD+CLc3wZXHiG6GhnX9
wvnh5KrUpkL4kEPV++62D7L22t7foMTupk1zYvqVDTn37AnrIdH5ZaY4q6TkFXs5
yaMJ8J8v27zP7Rd8VIpJySFcUnpx4+DcUeKWzhSkeeD3i35VGKRvNsHLlZpJF3QM
FUvT2nAeFiZrJIFa/lVpyrAoNz1U2WX3ZgGO/poHJbfIBfSaEcxf7AApc903A34w
opvtSJTAGNoMRZPXiOaLMfTniB/gbWghlTnVAy18djSwOxcGaD80yX8pTLzC9GW/
xq628+j9zzZA4BUDkZgTwy5/eJ8gV/orrLMaXwnupSt//85CpN7BX3Sg8kmY0sGt
zc6DmP5aIDsI4RTzMJdFESW2ueSp5Hwor9bgbdnl2TIxLwisSAjGdMY5UiQuuDfn
deu7z8aOlK52fseeustGFZluCqnJC5ZzET+8wuFAAfmEC3xQso9L34uAa7qyDwWJ
JFaYRtR12qMA/5Do0Q45K5tQFwmjhVShjl85iSffzbngTVBA6MYzKC4KNA9D03Qo
/L+chBfqAhj+ZguG2e+D
=Ca84
-----END PGP SIGNATURE-----

--0EnEvVOShwj0KiD4K0ofBcvkzvPZTNZRL--

