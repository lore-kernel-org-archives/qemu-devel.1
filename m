Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C0EC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CA02051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeSP3ra4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CA02051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is67M-0007l0-N2
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is65e-0005tB-PG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is65a-0005Ke-0O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:25:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is65Y-0005JO-VF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gIxMsqPMfimPFe44n4bKsLCEwI7dt7AE9NZT3z6LG/8=;
 b=TeSP3ra4AmUoMieVF9l5p4FokXeU9kmAp1Zx8gsyvpy8Klf9cnph6xL1NYl7F1MwblweYk
 r9DmFpmNP8NCz5Rgl/qsr+/e9qWCpf4a1LcNIzdKeEuUJgtKaR1ik7c38bkkVl32cX2fY5
 GTvQgftmdIdrylKuy09KlC2RP24ivw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-yvr_3rWAN1GAkoyik8awUg-1; Thu, 16 Jan 2020 09:25:32 -0500
X-MC-Unique: yvr_3rWAN1GAkoyik8awUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7498010C8
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:25:31 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD731001B03;
 Thu, 16 Jan 2020 14:25:28 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-44-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 043/104] virtiofsd: check input buffer size in
 fuse_lowlevel.c ops
In-reply-to: <20191212163904.159893-44-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 15:25:25 +0100
Message-ID: <87tv4vwka2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Each FUSE operation involves parsing the input buffer.  Currently the
> code assumes the input buffer is large enough for the expected
> arguments.  This patch uses fuse_mbuf_iter to check the size.
>
> Most operations are simple to convert.  Some are more complicated due to
> variable-length inputs or different sizes depending on the protocol
> version.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 581 +++++++++++++++++++++++++-------
>  1 file changed, 456 insertions(+), 125 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gclUACgkQ9GknjS8M
AjUucw//algDEUEshXcXSaQZUqL+wRNbXJ1vVSVPPkcGIY+SJKfLbfBwOG3UxNPx
oDYRxKSJWx+ulzNA4BKYG/ekYn2sPJqYXuPagU0bnKR/Q9SAWuCP48Gv4oV0rx5k
bxnRLFGzgbJSafyGjUPxaCs2wJaopwuZc4UembwEzxnLtUDaa4FsWM2otMhQ7P2c
SN9tzJrFWySOlxFudswdGz9yXzg6NNIugYp++C3jq/xeL6kx2UVjENrogdTDehPk
5ys+QCwgqjVsSXBHq4KJtC8UGl6bvPNwkVGAJAhfgqp1UCXI8ARWTI83HBJZDayD
FJJbRMsS3nmYaFqu4oNfEJvNjIXKJOC2PDdRn5Kune22sg4vqv5XP0SX4zlPoCTC
yCoP2lPTwVrnCs2ktMU17fpShh9QU6bB5bAm2YF80r3Hvz8W5avKW/mYbaakY0tU
9rHQXsNM3b0sqsytGLmM8Ejkv0wEgOTcEGILcgaABx1PMWSDXZ1FWMTsZd3OofHj
nFW2rpE6Bj1WLuRkAkBu/v+Hxg8OXECh5qUxh9RNOjSZZDiizwK6PAcKaPMRz6kS
UrpJVX4X4oq0aLDXLkrlKmKeQFUvjjl7BwI2gNaMp07mOU+0RtUaS/AwzGG+9H9X
64AHKqSoNdMZTiaS2O5uZl6146wPwYONVAekP9urWVeNscmDgt8=
=kMC/
-----END PGP SIGNATURE-----
--=-=-=--


