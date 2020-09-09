Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3EAC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0DB21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/2olWCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0DB21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFy6x-0004mG-32
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1kFy67-00049d-CS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1kFy65-0005Dz-3R
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599650223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y2gU+TPjnYqAZWsSP85tIq5psc/pNymQ1odxfZLWCw=;
 b=h/2olWCjs7Uez2G43yhcEIKHVNoZxAu26UrKvOp55Q/pA8TwgP9XAzveK1ZhNTAD7+Wnlu
 xx9+LYzvKD8oATIh/yJJ4vSSecZrDKrkUgCli8E64eGC1YYJQerQxxL0Tb78LUulyfDyFs
 pBUYhhpgJa3jPL9W8TzJAKIeTjIKSDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-IlOraKxkMO275v-DphPcEQ-1; Wed, 09 Sep 2020 07:17:00 -0400
X-MC-Unique: IlOraKxkMO275v-DphPcEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EDAE10BBED2
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 11:16:59 +0000 (UTC)
Received: from lpt (unknown [10.43.2.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69ED160C0F;
 Wed,  9 Sep 2020 11:16:52 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:16:49 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 1/6] virtiofsd: Silence gcc warning
Message-ID: <20200909111649.GC1377607@lpt>
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827153657.111098-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jtomko@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jtomko@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Thursday in 2020, Dr. David Alan Gilbert (git) wrote:
>From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
>Gcc worries fd might be used unset, in reality it's always set if
>fi is set, and only used if fi is set so it's safe.  Initialise it to -1
>just to keep gcc happy for now.
>
>Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>---
> tools/virtiofsd/passthrough_ll.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE7DTm0WabvfIr7YZ4Ak1z5KIMl5QFAl9YuZ0ACgkQAk1z5KIM
l5S4MAf/dm2VM2eVZnN8FydhcFUE4anDIpf1cAcLpFXmSBcFXae4OEZAP6miQxlf
q0an22nLJKcMsOJhajx0BEZ3lKlydSVr2Nj7YA2eAQ1psf7zZVdb9nBJuNh7lyBV
ZqKmfPCZdDZDwfJplon7cclU/o0tf1yhOwZ4HmBlf3gaU3tren9p4PB4jrkla/gI
zTi1n8C5kVjrY710ThEMzgN4cmESJ1sEr9jY9ywuRcTsNXjV61HDCqkTW6WlPn0Q
nEeAixVk9kk0d15xWQx0xRJ2Y+zgdVWEn/wtQ8lJmCAnTvDNGm+SOYZDrcfM/0mz
VSUVd7RxUExwsfeToX8qs/RgOYnYDg==
=xftR
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--


