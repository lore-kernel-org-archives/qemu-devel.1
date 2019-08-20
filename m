Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CFC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E3922DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E3922DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09l5-0003Ek-C0
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i09fl-0000hk-Cx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i09fj-0004F9-Ds
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i09fe-0004Dd-VY; Tue, 20 Aug 2019 15:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5291D3175283;
 Tue, 20 Aug 2019 19:19:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 130A360BFB;
 Tue, 20 Aug 2019 19:19:52 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
 <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>
Date: Tue, 20 Aug 2019 21:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="466FIDHMHmV7e4ff6GTLb5dCOo04CNZIl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 20 Aug 2019 19:19:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Check for enabled drivers before
 testing them
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
--466FIDHMHmV7e4ff6GTLb5dCOo04CNZIl
Content-Type: multipart/mixed; boundary="1VNHbQNIxOdDwEXMICO0nzDx2pnW5aWGn";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>
Subject: Re: [PATCH] iotests: Check for enabled drivers before testing them
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
 <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
In-Reply-To: <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>

--1VNHbQNIxOdDwEXMICO0nzDx2pnW5aWGn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 8:48 PM, Max Reitz wrote:
> On 20.08.19 18:01, Thomas Huth wrote:
[...]
>> Well, we disable blkverify in our downstream RHEL version of QEMU - so=

>> it would be great if the iotests could at least adapt to that missing
>> driver.
>=20
> I would like to say that RHEL is not a gold standard

Well, let's put it this way: The less changes we have to carry along
downstream (and thus review each time we rebase the downstream tree),
the more time we have to work on upstream.

> It feels a bit weird to me to say =E2=80=9Cblkverify is not essential, =
because
> RHEL disables it, but null-co is=E2=80=9D =E2=80=93 even though there i=
s no reason why
> anyone would need null-co except for testing either.

Ok, fine for me, too, if we also declare "null-co" as optional for the
iotests - let's make sure that the tests in the "auto" group also work
without them.

>>> Of course, that no longer works as an argument now that we
>>> unconditionally run some iotests in make check.
>>>
>>> But still, the question is how strict you want to be.  If blkdebug
>>> cannot be assumed to be present, what about null-co?  What about raw?=

>>
>> I tried to disable everything beside qcow2 - but that causes so many
>> things to fail that it hardly makes sense to try to get that working.
>=20
> Hm, really?  I just whitelisted qcow2 and file and running the auto
> group worked rather well (except for the failing tests you address here=
,
> and the two others I mentioned).

IIRC I tried to run all qcow2 tests when I disabled null-co and saw lots
of failures ... but anyway, let's just focus on the "auto" tests right
now, that should be doable.

 Thomas


--1VNHbQNIxOdDwEXMICO0nzDx2pnW5aWGn--

--466FIDHMHmV7e4ff6GTLb5dCOo04CNZIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1cR9MACgkQLtnXdP5w
LbW39Q//Yuxc/WN5oyZpZHLMzwS1sno4Gm+RpLVi8Ht4qubaR+x/nHO72nKsI+iZ
6bZdjGVk7gg9wRVjJg4RKAa/un3vxQHdOpl6TWFDIXcQkCgFOcRnrQiNpUz1Hs4e
6AOfyRRE43xlU467mxqGPzArjRrCEaPl36X3dgpJmnveSaHvBFVBZLevG/0ubYHO
mAs6B7lHu9r7br6Kyrc/4nvAiNI5p4IhyTDD6SoLUWEjmiaCrZKk3IjCiMv5lLri
TQdgkQ6xlm8hoc3m5LGtfWVFEbYMUYzjR/RTzttVHQLbLt4AFwnuFm5CYp2AK081
NcTSyx8lRppfbjg7yPNxe5OpCB+CPS2fDkECahYzTwJUVqt3Nq4JXb21DA1oKHBn
e4KGxKz9G+AleUHLYEbifDfUXenBn4QuWhnYwAasF6Sc8HbxVF/LDa1IXDEmQHPd
FqPSt9GKqMNZ9bA8IcyS5I4E0hMmeqOelcbW7rS9tyogUYJo7ND8/DZBwh9h34UU
9t6j485We41jAIMkT9qhIxyvgL7KTFvzmKe6FN9sg8kBBzt9Ps3QibD/lvzppxYF
8TYFyhDamuwQf089PeiMVnfLJRjcfDWPdfEVPZXgQVy9cn3fi7I6/IAaJtGHrtme
lwzu/7XDudNeAzZjA4BSSWhKfO3s6DqKrkf8AKmoKp7qt66KP60=
=qjn9
-----END PGP SIGNATURE-----

--466FIDHMHmV7e4ff6GTLb5dCOo04CNZIl--

