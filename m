Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91241C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5713C2068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMznKoWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5713C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8Sv-0004yr-IT
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Rt-000472-Eu
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Rs-0003Ox-Qr
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590395224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNEEy15mpvmFHU1NiVH/O4940/WS0SC0eLyAHyZpNMs=;
 b=jMznKoWwamRCPIbS13UfQwtLjjjmQPbN86kNM/rLwlgcaIqieZO8bZwNuC4emRcJ9k3nvp
 2DYCmHeBA1TIV3TkwDaeqN7xLWs9m2ZmCOgeE2PX7qpp9AIhhb1HZOlm7qssvLaD0UXnoW
 o9Aa7d5lF1i2IQOvdq1xx0Ei0Qgeu24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Ds3OxRjCOpehDBeIHohCDw-1; Mon, 25 May 2020 04:27:00 -0400
X-MC-Unique: Ds3OxRjCOpehDBeIHohCDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3600800688;
 Mon, 25 May 2020 08:26:58 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BF235D788;
 Mon, 25 May 2020 08:26:55 +0000 (UTC)
Date: Mon, 25 May 2020 10:26:54 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 7/7] block/nvme: support nested aio_poll()
Message-ID: <20200525082654.2qflstcksb3sjl63@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-8-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-8-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n5jquohymhvbhfxk"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
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

--n5jquohymhvbhfxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:38PM +0100, Stefan Hajnoczi wrote:
> QEMU block drivers are supposed to support aio_poll() from I/O
> completion callback functions. This means completion processing must be
> re-entrant.
>=20
> The standard approach is to schedule a BH during completion processing
> and cancel it at the end of processing. If aio_poll() is invoked by a
> callback function then the BH will run. The BH continues the suspended
> completion processing.
>=20
> All of this means that request A's cb() can synchronously wait for
> request B to complete. Previously the nvme block driver would hang
> because it didn't process completions from nested aio_poll().
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c       | 67 ++++++++++++++++++++++++++++++++++++++++------
>  block/trace-events |  2 +-
>  2 files changed, 60 insertions(+), 9 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--n5jquohymhvbhfxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LgU0ACgkQ9GknjS8M
AjUe0A/+KY4HREgfUPlrmrdBhuGoWFhzacWUUdPi73pbRVrybuV+a+aq2UdzeQs3
kncwjAQYQNfp0GqbTnohxOWkw1d8PoB8nuldywi6QvFq5TzSUKaT7rkIb1QlpSH3
Bc1zfPl+1VVk4RC1BYIulP4haQCKQg/SyWv80rqj4sigBTu+WP2esXfbSk2Qqpa4
vZjhKb+USVEwVmKtRzXn++VGZYyOp8MzfiuTDtYsO+a/7tclrRmeIyji0Sd+lYJp
8wrxhtOTFt77ZD2XhP6CVogseNAygRL7c3V/VhFT/f4+KX/zWJ0kwo+uQoxW0skY
VQ2+YlfmaRfOFdhWE+dvjtsZ0m2cBjCnGn3X6m+m10gT5dqZTqP3Kovq8OOifHy0
o6F52ya153JKD079cqScBUiEj35ZMJffxC6b+5QQ6agMYWf5aZPBYmv+ygCk6d56
ZXy2Hb/7iWXUVmdges4VyjLipA9MXvd5lO8Gmjy3hiEgPFnizSzlGatgVOUYBxah
oGuvsQoWd0vRcVFdfUhJXWWe8BQvW+4bHX6hOaCDS317Kuz7rsZsyvkWfPd/Z1hv
sa2C1dSK4bAPFc6NhzDcmmHG6K49KzJ3ZNy5z0L+EA+tOmWoIxgufnjd2HwTS2eb
+dzRUx6zDmi0PdroIXOiBfP7/M9iOLMPCsYH2hHIP6LjmMqt86M=
=i3Iu
-----END PGP SIGNATURE-----

--n5jquohymhvbhfxk--


