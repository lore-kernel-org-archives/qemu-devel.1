Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE1C46470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2A321655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2A321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFRy-0003NC-O8
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:49:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOFQO-0002XV-Ee
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOFQN-0006BB-GL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hOFQK-0006A2-Sg; Wed, 08 May 2019 01:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B368F30833B4;
	Wed,  8 May 2019 05:47:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 164EC5EDE4;
	Wed,  8 May 2019 05:47:12 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-7-thuth@redhat.com>
	<87ef5acsce.fsf@dusky.pond.sub.org>
	<b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
	<3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <44a3ebee-c717-d953-8e89-c24da99209a6@redhat.com>
Date: Wed, 8 May 2019 07:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oofwSk5dChTzFIDezetwnwpvwVUhyhtMI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 08 May 2019 05:47:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oofwSk5dChTzFIDezetwnwpvwVUhyhtMI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/05/2019 17.50, Eric Blake wrote:
> On 5/7/19 10:22 AM, Thomas Huth wrote:
>> On 07/05/2019 15.22, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> Currently, all tests are in the "auto" group. This is a little bit p=
ointless.
>>>> OTOH, we need a group for the tests that we can automatically run du=
ring
>>>> "make check" each time, too. Tests in this new group are supposed to=
 run
>>>> with every possible QEMU configuration, for example they must run wi=
th every
>>>> QEMU binary (also non-x86), without failing when an optional feature=
s is
>>>> missing (but reporting "skip" is ok), and be able to run on all kind=
 of host
>>>> filesystems and users (i.e. also as "nobody" or "root").
>>>> So let's use the "auto" group for this class of tests now. The initi=
al
>>>> list has been determined by running the iotests with non-x86 QEMU ta=
rgets
>>>> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. incl=
uding
>>>> macOS and FreeBSD).
>>>
>>> I wonder whether we should additionally limit "make check" to "quick"=

>>> tests.  How slow are the non-quick auto tests for you?
>>
>> I already sorted out some of the tests that run veeeery long, since th=
e
>> run time on gitlab, cirrus-ci and travis is limited. "make check-block=
"
>> currently takes 3 minutes on my laptop, I think that's still ok?
>>
>> When I run the tests from the auto group that are not in the quick
>> group, I currently get:
>>
>=20
> My personal threshold is about 5 seconds for quick, so:
>=20
>> 003 1s ...
>> 007 2s ...
>=20
> Should these be moved to quick?

I'll leave that decision up to the blocklayer folks ... I thought that
there might have been a different reason that these have not been put
into "quick" yet...?

>> 013 5s ...
>=20
> this one is borderline
>=20
>> 014 15s ...
>> 015 9s ...
>=20
> Definitely not quick, but if you think they are still okay for auto, I
> can live with that.
>=20
>> 022 1s ...
>=20
> Another candidate for quick?
>=20
>> 023 18s ...
>=20
> Even longer than 14. Okay for auto?

I think I'd give it a try. If people are complaining later that "make
check" is running now way too long, we still can refine the list later.

 Thomas


--oofwSk5dChTzFIDezetwnwpvwVUhyhtMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJc0m1gAAoJEC7Z13T+cC21pOMP/RK/KujTbVDtx4jW4kC+bvUW
mjcyQIDy9I8ZCuR5G/Xyjr4YWPvCvZ19CHEdLt/b14KHTECHmHkYN8xkocs48dkP
Iec2m/t9jlGpCVKirtWxttcmbW9PhzpuNFJIOO0Vr0WtsiDs5GycEF0ebqt+3dOu
lcYkdITnc8tl9Arsb5+HPvCovafPZKHfZ+dNPzD10Hz75lClZuilU/8uMtlfJaUq
dnvHR49LDO834uuOOh2YEEnuDVATVTuEU6N40hn86oabpdghhdgyKE7ZM9z1v5fX
u4d+deXEvjRbrDdHdBuBDTlK7u3mhZiFR+Zg9j4RufmIGSeWNdSeXVPSqERDTjg3
flbOYO0yQF8FkgTDO1ECwlJc22BOo1CEw9uldiM2xqCY/k5yklZpzdC/Nq33O5Np
dpYSkRE9rL4Syb+VF25xwZ6ApjhDpILOET9JvBCOP5aNVyr8eQmMNxAGe8UoeJ4l
QEf1ze2bE3YE9YwY/asAP+6qoShNfDUbsNDdwspUvZQBdxeGaUO7tzKKnM0u7hQn
kpHlYHsKc+B8boeA3DwyTvG2bQSFzkJCZgBijvfiApjzmhILl7QX50M9PwrUUlvc
AXxag1oyxRagCvUKfCQUJX9yEvJFP1opBTfvj8/0yItSxXqH7yBzL2tjItwfdnWc
86pMWetd/uEXpEUaLY5r
=8776
-----END PGP SIGNATURE-----

--oofwSk5dChTzFIDezetwnwpvwVUhyhtMI--

