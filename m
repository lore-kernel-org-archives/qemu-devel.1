Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25CECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A2C20872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A2C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xbn-0007eL-0y
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i7xZW-0006BS-JY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i7xZV-0005Zk-In
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i7xZS-0005W0-Ta; Wed, 11 Sep 2019 04:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12F03307D853;
 Wed, 11 Sep 2019 08:01:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-192.ams2.redhat.com [10.36.116.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F79919C6A;
 Wed, 11 Sep 2019 08:01:43 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20190910185839.19682-1-thuth@redhat.com>
 <4ce671ea-452b-39ac-ea2e-83b9d75a3b84@redhat.com>
 <20190911065857.GB4907@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <5711e370-1d92-4868-39c1-3423c2dd9f42@redhat.com>
Date: Wed, 11 Sep 2019 10:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911065857.GB4907@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nHaHeFAhNbBuLcA5UJq8vg1WHf6Jwez5b"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 08:01:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/7] Move qtests to a separate
 folder
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nHaHeFAhNbBuLcA5UJq8vg1WHf6Jwez5b
Content-Type: multipart/mixed; boundary="jtsS8ni978aGcliVfZwl0ddhjUZbpNg45";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <5711e370-1d92-4868-39c1-3423c2dd9f42@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/7] Move qtests to a separate folder
References: <20190910185839.19682-1-thuth@redhat.com>
 <4ce671ea-452b-39ac-ea2e-83b9d75a3b84@redhat.com>
 <20190911065857.GB4907@localhost.localdomain>
In-Reply-To: <20190911065857.GB4907@localhost.localdomain>

--jtsS8ni978aGcliVfZwl0ddhjUZbpNg45
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/09/2019 08.58, Kevin Wolf wrote:
> Am 10.09.2019 um 21:07 hat Eric Blake geschrieben:
>> On 9/10/19 1:58 PM, Thomas Huth wrote:
>>> Our "tests" directory is very overcrowded - we store the qtests,
>>> unit test and other files there. That makes it difficult to
>>> determine which file belongs to each test subsystem, and the
>>> wildcards in the MAINTAINERS file are inaccurate, too.
>>>
>>> Let's clean up this mess. The first patches disentangle some
>>> dependencies, and the last three patches then move the qtests
>>> and libqos (which is a subsystem of the qtests) to a new folder
>>> called "tests/qtest/".
>>
>> I'd also welcome a rename of tests/qemu-iotests to tests/iotests.
>=20
> I might prefer if the directory were named "iotests" rather than
> "qemu-iotests" if we were only adding the code now.
>=20
> However, I'm not so sure if I'd like a rename now because a rename
> always comes with a cost and the benefits are rather limited in this
> case.

Well, if we all agree that it rather should be renamed, we should maybe
rather do it now than later. Later the cost might even be higher.

 Thomas


--jtsS8ni978aGcliVfZwl0ddhjUZbpNg45--

--nHaHeFAhNbBuLcA5UJq8vg1WHf6Jwez5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl14qecACgkQLtnXdP5w
LbXFYRAAs2pDbcBa3dK2HC7YFiooz6/KXWHsAj+dwU8PvhsBxicxznrcwcYNI2P6
3G9/amBpzpMRDN1ufOKye08qtm81PFhvksfxrw1DNgqUdysjkaDp6oO56XTUr2hn
n5wA6D6cQU1Wso5Zh/Ukdu8y1TB3esqajprMjtowNfCcgjjpc1NFhaGsoXqGbs7m
ZCEnRV5QCHhgtFOgdM9vGly2Qb+MS8Ko3AKodCSwrFZHkJwRQZ7MX6ioRO1ziYz8
Ep2epYRMlP9tKD7VBP8YbkX7oYQKRN+SxBykDPltj2W1OLE4hu3WTdDZCWAGwPC8
3P6m+QnUAHmuN5dBv/IYVZ1fCW9co8qG6hJUSUMWQL5WH4mh0AXsCtajQjRhienq
BKncUzD/XhzofowdXCNevUPO1gpDF6UP98Y3wi/vIPEblaBfTZEhNfnq5e9tMbMA
osjrXhDzleNDxmj1nugf527Fgjrvr4VnM/pLXKBPGT6WonzqsojP0OC8rERQcvpp
Blto7mnR2CoqxLgl2Jft9N1+Wfp3hYn76vhkQ60qLG80kcHZHbkKP3uAWigTwmzr
O0HVZhz6Mf+NPyuXOsOEtplwr0dZQoCbyTvM3HJ/zDrwVrAgD8jxLSc9kE5QNQgR
FNkHmEv7X+10pA55fl28ZhEi9SgEB6hZgqx4cic/y0IjCHhoafY=
=yYpi
-----END PGP SIGNATURE-----

--nHaHeFAhNbBuLcA5UJq8vg1WHf6Jwez5b--

