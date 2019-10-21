Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E3CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DD820684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdIAJXIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DD820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSl8-0004qi-Me
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMSkP-0004HW-Oj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMSkO-0006OG-MH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:09:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41031
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMSkO-0006Nv-3s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571645338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp:autocrypt:autocrypt;
 bh=yV3JtOPuMqbtvgi8F0NrIFCVeg8RcDSTr7aH2h+IxiM=;
 b=bdIAJXIwUmWsN9vCNqynvpooWuAbn09nceiQ0raVOpVngBU7p3cR8NZaUvTSbGoKQGe6wG
 QfSB/7i+hO5rE7kNINtdRd6H+xu7MF673Mld1n8+McLOiC0DzFhb856UXkO4N5WOjOpNM6
 f3mhq2K98LPYai8gRqd+C3Dqrkf3Ap4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-XbsnZ-r0PFK2t6uDbqloEQ-1; Mon, 21 Oct 2019 04:08:57 -0400
X-MC-Unique: XbsnZ-r0PFK2t6uDbqloEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65BA61005516;
 Mon, 21 Oct 2019 08:08:56 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 414C05D6B7;
 Mon, 21 Oct 2019 08:08:52 +0000 (UTC)
Subject: Re: [PATCH 2/5] iotests: Test 041 does not work on macOS
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191011145047.19051-1-thuth@redhat.com>
 <20191011145047.19051-3-thuth@redhat.com>
 <cacfc0c2-cdb4-fded-e317-a51d38cc512c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <9cb10562-2ae7-596b-8a37-77e82759a8fd@redhat.com>
Date: Mon, 21 Oct 2019 10:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cacfc0c2-cdb4-fded-e317-a51d38cc512c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z6i4C8SLqxTZrQhVZ24iaI9p1DfU0KV49"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z6i4C8SLqxTZrQhVZ24iaI9p1DfU0KV49
Content-Type: multipart/mixed; boundary="XiglGpK8pCS35WjghW8SFmMKMl14WDQhc";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Message-ID: <9cb10562-2ae7-596b-8a37-77e82759a8fd@redhat.com>
Subject: Re: [PATCH 2/5] iotests: Test 041 does not work on macOS
References: <20191011145047.19051-1-thuth@redhat.com>
 <20191011145047.19051-3-thuth@redhat.com>
 <cacfc0c2-cdb4-fded-e317-a51d38cc512c@redhat.com>
In-Reply-To: <cacfc0c2-cdb4-fded-e317-a51d38cc512c@redhat.com>

--XiglGpK8pCS35WjghW8SFmMKMl14WDQhc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18/10/2019 18.19, Max Reitz wrote:
> On 11.10.19 16:50, Thomas Huth wrote:
>> 041 works fine on Linux, FreeBSD and OpenBSD, so let's mark it as
>> only supported on these systems.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/041 | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 8568426311..7211f1950a 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -1123,4 +1123,5 @@ class TestOrphanedSource(iotests.QMPTestCase):
>> =20
>>  if __name__ =3D=3D '__main__':
>>      iotests.main(supported_fmts=3D['qcow2', 'qed'],
>> -                 supported_protocols=3D['file'])
>> +                 supported_protocols=3D['file'],
>> +                 supported_platforms=3D['linux', 'freebsd', 'openbsd6']=
)
>=20
> Hmm, why not just =E2=80=9Copenbsd=E2=80=9D, or single out macOS as unsup=
ported?  (I
> suppose the latter would require an additional patch.)

Ah, right, John's patch uses "startswith(x)", so just using 'openbsd'
should work fine, too. (I initially thought that I have to use the exact
string here)

> There=E2=80=99s also the fact that I maybe wanted to let make check skip =
all
> tests on macOS and Windows =E2=80=93 though that doesn=E2=80=99t make thi=
s patch
> unnecessary, because that would only fix make check, not running the
> iotests explicitly.
>=20
> And I suppose maybe we even want to run the tests in macOS if it=E2=80=99=
s part
> of the CI anyway?

At least the current set of tests in the "auto" group works fine on
macOS (running on Cirrus-CI and Travis), so I think we should keep it
enabled in the CI for now (until it creates too much trouble and nobody
is able to debug it ... but we're not at that point yet).

 Thomas


--XiglGpK8pCS35WjghW8SFmMKMl14WDQhc--

--z6i4C8SLqxTZrQhVZ24iaI9p1DfU0KV49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2tZ5MACgkQLtnXdP5w
LbUhShAAsAOel/+nVE8Bx/sq3vdfaKaZ311Fh3E8xmJfgWuroZyMcXg9ogUrkFEA
aU+sy52UYTXHPeBg9TbNdlHo+Tpb3BXijlylI0FuCYpFPTscSh4rmS9EYLK7ECcQ
o/FF6auAQRgVpUz1yjhJ1ZoRNK95NdpmtREEV8ueiBaUCFmqA8Hk007DZt7crtRu
aXUy4B3LSq4Ci0Wza3UrYFtwWY/KrooLR6L8CdDTRFzhaz1LxiZ8nxvLGkZqkRv2
QFxwv8hN0WiNriM84r/WmPa4+rNq87FkOAzuYbxZJaKleYK3JHuChf07PEN9fBEP
suR3dlKNgnvy09uIoIaASNx9KXr30cD1S0HHjtjuy41/lKZJelV9gksqY6q7zt1s
h/1ieYWEIPQSZwQS8UYASHdvUPe+WSaxLummLXsXY+0orDPnxnoo4zJH+tPFYPGA
pSWxpCxkaAh25poaG7y5GbXdOKbvfB3/SCY7jgXWOIbqvcQfvqMAIbNNaKxUArzN
behDqmxwk+lvBRe7QvyaDigSzdLAUq9/V4Y72hdKwCAODTLWchctiHb4dFTkj8Aq
T/bW23h6XKgMg7G58gSYB7pgvzf8WNAIm5XJ94qVxlDf2bCEV5OmOCKY1BYezd6f
cYDjyKEfTHbTIIVoVYTGUwXi7YsI0HDQ3AC7xdQ8I8xnG1G/zvw=
=nk1g
-----END PGP SIGNATURE-----

--z6i4C8SLqxTZrQhVZ24iaI9p1DfU0KV49--


