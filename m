Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B4C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9AB2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCZoYN7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9AB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDQv-0006uP-Ru
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJDPt-0006Nu-IJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kJDPq-0002QW-Gl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600424093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8LQIiuCOOSt2dzqTFFSEul3s6eq23jrDDKqMP9A0rs=;
 b=eCZoYN7H+MrlNRjtFcScIoxCqIykNYxq5nAa9By/QAcWPWfkJTjsqlWknV9vRQk/x1hlHi
 n28FskmqlC7KgcRcspyex5Q3lkE0O9Ma500TkHWJQrf6p9CQlEoz33LXx5rM6alT9MWs8h
 J8kZsCyJIgUCXTZCsmKzXe7ZjQH1u/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Xrg8i3ELOVO2dacUphl82g-1; Fri, 18 Sep 2020 06:14:51 -0400
X-MC-Unique: Xrg8i3ELOVO2dacUphl82g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D982710219E0;
 Fri, 18 Sep 2020 10:14:49 +0000 (UTC)
Received: from localhost (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8C410027AB;
 Fri, 18 Sep 2020 10:14:46 +0000 (UTC)
Date: Fri, 18 Sep 2020 11:14:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 1/7] libvhost-user: Allow vu_message_read to be
 replaced
Message-ID: <20200918101445.GA869406@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-2-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-2-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 04:09:06PM +0800, Coiby Xu wrote:
> Allow vu_message_read to be replaced by one which will make use of the
> QIOChannel functions. Thus reading vhost-user message won't stall the
> guest. For slave channel, we still use the default vu_message_read.
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.c |  2 +-
>  contrib/libvhost-user/libvhost-user.c      | 14 +++++++-------
>  contrib/libvhost-user/libvhost-user.h      | 21 +++++++++++++++++++++
>  tests/vhost-user-bridge.c                  |  2 ++
>  tools/virtiofsd/fuse_virtio.c              |  4 ++--
>  5 files changed, 33 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9kiJUACgkQnKSrs4Gr
c8jEhAf+P7mKDEXxRNkwg1BHznL2SxKO2B/8ftJh6MFiI5zwKMCVNW1wP9fjRR0d
DT2q/SHe2fMfhgLjKsjW2iQ3HDqztMt34quF+CxfY1JMMsPC2ndIm/QAOuXY1cxl
f7LdMyotp7+KalZvkOdCQ+HJ3XYVkfQ+x0v5XlQFsdpimAPmo7XhjbTOtXc5LO0Q
utQFKA9ZybdLO9Q2OfktDX4TyHKrsBtMB8NazbOZJClYOB7gv1Z88P4PH0FeSpRG
PI5CHfClyqtgSMBzm41XZkkvL3TetdoKikOYj+Kuuc/xDRljNnitxRjbvQNz/YRG
/lbS5FJA69AkPBWTY7WADgqN/Ltbuw==
=FIlh
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


