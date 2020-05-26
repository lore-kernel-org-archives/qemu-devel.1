Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F62C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE534207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVSy2q4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE534207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVOI-00011J-Sq
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdVNl-0000bt-Jv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:56:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdVNk-00054L-CJ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590483377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yYqc79kWEYzwmVU8yUi6g9F3V570aasJ4uP8//U5Qvo=;
 b=SVSy2q4YZ8NZnkbLZGrOrnLepPoGZogFckl0JcnhSsHgGgWN8n+a6ucRD1MLt5fRitRtd6
 XxBTaDcTltTgEo5g7kr6rUTvE+tFEnEb81rq5hEFb9bPUGXa7lrMH9qklu3wE+8Qh/sUh7
 OmmyTicsjujAcjamrZHXTM2txeBW9h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-s7B4B697O0ezI2iIwvoXKg-1; Tue, 26 May 2020 04:56:16 -0400
X-MC-Unique: s7B4B697O0ezI2iIwvoXKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC36A107ACCA;
 Tue, 26 May 2020 08:56:14 +0000 (UTC)
Received: from localhost (ovpn-115-45.ams2.redhat.com [10.36.115.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E6FF5C1BB;
 Tue, 26 May 2020 08:56:11 +0000 (UTC)
Date: Tue, 26 May 2020 09:56:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
Message-ID: <20200526085609.GA766304@stefanha-x1.localdomain>
References: <20200526055820.12999-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200526055820.12999-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Alexander,
>=20
> I forgot to share these 2 patches wrote before
> the direct MemoryRegion fuzzer sent yesterday.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (2):
>   tests/qtest/fuzz: Avoid QTest ioport serialization
>   tests/qtest/fuzz: Avoid QTest mmio serialization
>=20
>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
>  3 files changed, 22 insertions(+), 9 deletions(-)

Will it still be possible to print qtest reproducer commands when a
crash is found?

Other than this concern, higher fuzzing rates would be great.

Stefan

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7M2aUACgkQnKSrs4Gr
c8htRQf+Ik/6rzryK2uaTG3kTMUh5Iii4dSQ1iXs2gVU3b0gtit0ZRKmzoRzcj7/
1cvbVHRA28LgXxWVRuS+8NXbXadMYoRpBpYgZHV2e8m6xQg1AjZ4QXv/vnTblwNU
ZmB4XnESE6SQvYqVDN+Wcq2LC604qLD3oQ6vVuuMmtH/o9IBwogG4gQR6nzzHatZ
x1aeLxRS+NF+OpeVloffH7THjfTBtwMDR1eOkvWXHpd/JSfbvfg66xzVUMlq+wMF
B/noqJptEFA7dn+2FpljJBUkc5OtQAtLGBCLNE1ygMl+G0jplzIQKG8bTlfUOy7C
EdNFYjgYB/lZmCLvUQeuR3JGZzoS7A==
=ZEqQ
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


