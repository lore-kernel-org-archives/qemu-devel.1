Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E00C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174EF217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXr9bJvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174EF217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBHD-00074p-BZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBGd-0006fa-Vj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:06:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBGb-0006Jm-Ki
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594695960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7FiueqM7opae6BWaREvNTpd2yeSbNY7FfUXYJbZeJ0=;
 b=SXr9bJvFlprAZ8rDcUIJTlPzMOkwenUFZYG89P1zl9eaxRV5/7cRAI0PUnDtx+HXA/QW+n
 rMKoRa5RvrbGTLZWWJH8WqTz9IcTJaVQDPKLpsmByusTd6AJshJd5TF7kXolOm6ltmv7o8
 +JJErGP/+QdS8FBeQUt7RvYCMC9dpMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-lYQu8nJUN7KGLhcr53cDmA-1; Mon, 13 Jul 2020 23:05:58 -0400
X-MC-Unique: lYQu8nJUN7KGLhcr53cDmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21908184C5F0;
 Tue, 14 Jul 2020 03:05:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B0219C4F;
 Tue, 14 Jul 2020 03:05:53 +0000 (UTC)
Date: Mon, 13 Jul 2020 23:05:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 07/12] python/machine.py: Make wait() call shutdown()
Message-ID: <20200714030551.GC2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:44AM -0400, John Snow wrote:
> At this point, shutdown(has_quit=3DTrue) and wait() do essentially the
> same thing; they perform cleanup without actually instructing QEMU to
> quit.
>
> Define one in terms of the other.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NIQwACgkQZX6NM6Xy
CfNtShAAxfP/wAsmoOnsd00M8LEJzGo+5iv0kXjr1h2fchK6gKe1YBypm1A79EEX
tmh+DhHe7PWQhXPQoBoQQ/Y9ZgOvLSYs0NGqBJKFUqVaVhncwoG04aPL8E35LswZ
98DFgeDf9ZGqxulLfVi9JpklbShvY8/9oRgT9hVd8QOe3mmnIztCgl+VIumAM4h7
vCz0LhW86tVSAbi1C4C0vIERYATHO764a136UEJ21P2R+HWZN+wRJgwiyK2phMGN
ic4dOX5DXLs32y0TqPJX48hjq99shmvcoL1hvvBMxzcFhDQNZ1UFjjwsWrPUANKg
9EHKpEpr62G9EztGEka9LgESkOP5mROCoCruI71BlGS4QHw9RDV3bdha2CSq2Ssv
WYe3hN4l6OuP3U/9Da3iQ+D6VbtPFFBI0oA5y0xRpcm32vue+ztG0wTqpIKhMu/G
mfO/ZBJQSM5TUl9iXO103h+N8gDpO8vY6/y16XAM+gYGFLs6DckUMaj6YN0QkVCU
x2kjFIMirziDwzVkUbSyhXQ49dlxEvLQB0nCxDQmzY1x5bd57c24/OfFEkQZYAGQ
YVnX6AU0N3nJcThK6ii/gVidWQCeRJzYP62bSveTUp4lAEPf9uOFXnF3uBmjIy5I
oocArhEMxInQ+ZvxvMAXW6ZYN6jyObQE1CGZmfH7o0MGqTJL9tQ=
=06XF
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--


