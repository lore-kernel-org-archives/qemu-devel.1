Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA32C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25252207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQAQYmj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25252207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8OG-0002fl-CC
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8NS-0001k1-CV
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:22:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8NR-0002WD-BP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAoJOQ7/yvZj6FIuBlCGxflaaiZQrwcjwXComxRt8yA=;
 b=CQAQYmj9utMkLALpHaQSWhIT3eF9nGQTFwzG6mHSNCvxXFGAl3cZIqOlGmt+STRSVYw2X8
 196UZt/dy5UC+ATDcV3DzInmZbV9qt43/jwn7dscpCy4GedOy2ZInihMqqbdusRWuDAICa
 SsS2WwSykkt6VJdH4yscr3bSQl4Q9wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ZXvMJ9dEPied-VloMOU70A-1; Mon, 25 May 2020 04:22:26 -0400
X-MC-Unique: ZXvMJ9dEPied-VloMOU70A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A937800688;
 Mon, 25 May 2020 08:22:25 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5C360FC2;
 Mon, 25 May 2020 08:22:22 +0000 (UTC)
Date: Mon, 25 May 2020 10:22:21 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 6/7] block/nvme: keep BDRVNVMeState pointer in
 NVMeQueuePair
Message-ID: <20200525082221.2r4bccwscrxhns7x@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-7-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-7-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y7riued4ogm6oahz"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--y7riued4ogm6oahz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:37PM +0100, Stefan Hajnoczi wrote:
> Passing around both BDRVNVMeState and NVMeQueuePair is unwiedly. Reduce
> the number of function arguments by keeping the BDRVNVMeState pointer in
> NVMeQueuePair. This will come in handly when a BH is introduced in a
> later patch and only one argument can be passed to it.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 70 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 32 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--y7riued4ogm6oahz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LgDwACgkQ9GknjS8M
AjWteQ//cMmAoQQ//S0bcxmSWQ4A2MlKxyFvkc2FhxTWWK5aA2lCzeU2lTE9qV0p
mcviHL6xQBLf0Tvkrq5ukL/nvMcL2vBPNLQG7JEfJzeD5ku7XXjoO6KgNYLCpmo5
4WIpBf0Y9aXpl3D19y6jXxK+duzeYkdN86AB9iR/VK/f4aG6x/RYW89PlYhMnn0k
k/oarJZ68StFYwVTfBHfNqEue9O0aHMGP+nIeU4FO50cOKRxVplMJp+WyMu5/O5+
tPngE4/wtjofPQHJsbbJEVuQyjUzmDDynCAPcXqYh1DUtzJoQez6Y3PTuU3o8U6T
zXmb+E7a++XGmCHOyKPgJDYHMUL1FS+hjkSvQWKc0bmu8tJktG8dVxKr/y3AdhX1
84vI34wzzPG7f0Wig2A1dxHGeyanIA4zjaygfyhdcVd9W9iAyqNQ7SwX6ugaG2jw
7CxC0KWBfAHvvsjxJXklWbJ9ZwSPAbOakTpI7wBEop0hJe8z7Bw28cR6kGbsksJT
me/4WpJs4EtfsYo3V2G+neQyVFEq8J4IxQQ06ul1NzqAg2XkTNNQLIU+7tr5E9tW
i/NWgaphO4XUfFjAEDmMGx1a7GoSDEqVUsRE0Xs72OVJqHBbypjYgFmijsTDrDF+
v/o5umwzNWsUnAUlDuJwDeXJBzXaXQiPf8p0q+DqcIW/a9dm9GM=
=02Vu
-----END PGP SIGNATURE-----

--y7riued4ogm6oahz--


