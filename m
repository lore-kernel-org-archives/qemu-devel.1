Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2217C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D469C21789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnvlVZ8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D469C21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXZR-00082T-OH
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQXYM-0007a2-I1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQXYG-0004RW-1v
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602169790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfTL/boSKBeyqaEpHS2cqmB6o026+UQzuTsSh+KvPN8=;
 b=YnvlVZ8bfAHnhC5TWlXMexmqiUkzXlkZAaiUUmI/uc8iSOc4OU/4OIv4V8zRtMF1tkiJsw
 LuZhPp4pWAMrtyB9lXCcREZljH4LqEh/To8RJVXYTSR08ZlrCCxWK1YOPVK/w5pyPiAtam
 soqCRk10AnqvfXfslYL7KP5queFcnBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-OyRtGIixM8O7vP4HHrCK_w-1; Thu, 08 Oct 2020 11:09:48 -0400
X-MC-Unique: OyRtGIixM8O7vP4HHrCK_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 280A180A190;
 Thu,  8 Oct 2020 15:09:47 +0000 (UTC)
Received: from localhost (ovpn-113-63.ams2.redhat.com [10.36.113.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1A75576D;
 Thu,  8 Oct 2020 15:09:43 +0000 (UTC)
Date: Thu, 8 Oct 2020 16:09:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: passthrough_ll: set FUSE_LOG_INFO
 as default log_level
Message-ID: <20201008150943.GA31472@stefanha-x1.localdomain>
References: <20201008110148.2757734-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20201008110148.2757734-1-misono.tomohiro@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 08:01:48PM +0900, Misono Tomohiro wrote:
> Just noticed that although help message says default log level is INFO,
> it is actually 0 (EMRGE) and no mesage will be shown when error occurs.
> It's better to follow help message.
>=20
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I checked that FUSE_LOG_INFO isn't used in the main request code path.
Therefore this change shouldn't cause a lot of new log output or affect
performance:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9/K7YACgkQnKSrs4Gr
c8jJaQgAo/76CVJEKpEY/g8x81q7kfJOpZQhtVmJ9BivLBCerriLMDBhKnfEyf+0
Zj8FFvYU8ILU6HLLwQEG2QYvud+Th6d5DPwikw4fFEBk5Lm/zcE0ueCAOHI9+b9A
Q0hYS9zUADCQ1hT39pBISZmppB2tpQ+Fwsnl8a1kRm2ljQXk1eH1GGRtDZioiICo
vH++qkzr97yG3vuqU5tp8eZ5ji2Dm+greSSTI6VEM7OJoNyzxRor352JNj6jNpxc
lgSTV+trQzsSMlY03dU4mAQhiAG3E3zTr2kw8ypO86bssLXfPvJoL2JFXHMww0Ze
/BBekVgbzUlxeIWcmH2TjneKrpQxrw==
=dzcJ
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


