Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D52FC4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA72D23787
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LynXrzZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72D23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLB9J-0003WG-Oh
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLB7S-0002Gb-2p
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLB7Q-0004t2-A4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600891919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBC55br8rnBZgZGStlPUHEYSbe1IRHil6snYiOfkfEE=;
 b=LynXrzZv436paGQPkcYJRMSH7/pXSAvluYh15ZzZmddDY+rwEa8ppR6Azr7m8qVHMhROzC
 q6Ghs2ZCie6sw2kDVknckwF2xco7yUNL+fIym+2QoNh6yitK+Twjy/uRH8almhP0gmNJDz
 s9tqG8m6OAPii6eMGejHPd0qnJhFVIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-jUa93TJbMyaNs73Rgyw-1A-1; Wed, 23 Sep 2020 16:11:55 -0400
X-MC-Unique: jUa93TJbMyaNs73Rgyw-1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4061B107465C;
 Wed, 23 Sep 2020 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A4873682;
 Wed, 23 Sep 2020 20:11:53 +0000 (UTC)
Date: Wed, 23 Sep 2020 16:11:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 16/38] qapi: establish mypy type-checking baseline
Message-ID: <20200923201151.GP191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-17-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-17-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Eu9PQ+LfZADlAtIa"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Eu9PQ+LfZADlAtIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:39PM -0400, John Snow wrote:
> Fix two very minor issues, and then establish a mypy type-checking
> baseline.
>=20
> Like pylint, this should be run from the folder above:
>=20
>  > mypy --config-file=3Dqapi/mypy.ini qapi/

Like with pylint, let's at least document the version of mypy used.
For example, with 0.740, this fails.  With 0.782, it passes.

- Cleber.

--Eu9PQ+LfZADlAtIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rrAQACgkQZX6NM6Xy
CfOSAhAAkEl/vaN8vixY6FCIyMAcKH6opCScUbNAZ0TogOaYsEuwcefNmJNhF0QB
YCY0pq1mTWKwaIsx1bOygWXYtap5ZmRHosj+CM0PzgyJi3yv4YiGBKkj/Wvrvi9z
jt4pVayuy4AHNNoCa92dgrq3SqUlt0B78gIcY11q/UX9EHMlmQ+oy0tem3HVwtRL
GtqJhcCnD1vfd8DDtCU6KYHYJeZfanNBli3d1+h0Y6gX2BMguM9Lt3PqwtYhZ7yU
PGk/rQttUyELUdJazVrd8lrUwA90zbP/CJOOUFLLAc2navzLDRuQvNi87w+em7ad
OMR/Sdards1r6x1qTiMYp3j9M+2fSdjO9OTx5a7uZWxbJ5fxMb1Po4Rxp7AScwY+
r5UTf7xKSwQj8OugJmp/1L0xtvZEfI6fpswGYvQFGSMEKvYp5IViY3MmKG7BLzXi
JD2CkHeY5qwa7zRFNYgitYbEriyYcqXzWBc312feD8w89Q4GObC4u49tq0pu90/D
9FqhjySBAkCzOd8ehPQ0u+9UFTaOxLLau9XEPh/RCMWq2YAk8SQItSW4E3diXlzM
mkfdNtOjB1EjgehOAu8LcKga8hFt1hc4W98XEI7ctYM/gOSCab8KzTaCpiFMcIh4
I09BDJpP2c+RE3HqatogLclBBE+kdJ7BYcgxZ9ul9TvSxJcbGAs=
=vMdb
-----END PGP SIGNATURE-----

--Eu9PQ+LfZADlAtIa--


