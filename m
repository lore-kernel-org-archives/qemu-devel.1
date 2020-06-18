Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0840C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018E2100A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLNMuI9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B018E2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpvn-0004FR-0O
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlpv2-0003Yq-FT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:29:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlpv0-0000hh-I1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592468945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIjJTLi2ro976j008Rv4CUv2GvcZuZijKXViAFFmeLc=;
 b=OLNMuI9o+zHnCSFfXVCXBjmQoD/kRkkmK5ehhMKHt1Zj3CmBOwDcEYsZWg7VorLHHu/153
 fg32GwTUBcxXw2gmwZuuuTndsuyBktH5NNBuKcdDhSk+kOhg6MoPo0zpZ7cOi4ZemkVn6a
 39ulbYqhmRL/yU8Fzegv8vIlOh3SB6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-lbZrnqfhPj6Y_5GrL5JdOA-1; Thu, 18 Jun 2020 04:29:01 -0400
X-MC-Unique: lbZrnqfhPj6Y_5GrL5JdOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC54A88EF12;
 Thu, 18 Jun 2020 08:28:46 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DCBF7C375;
 Thu, 18 Jun 2020 08:28:46 +0000 (UTC)
Date: Thu, 18 Jun 2020 09:28:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200618082844.GC1956319@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <159216218770.30485.1172665077342708998@45ef0f9c86ae>
 <20200616065216.wpf2rxgwxvtqgxlk@r>
MIME-Version: 1.0
In-Reply-To: <20200616065216.wpf2rxgwxvtqgxlk@r>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 02:52:16PM +0800, Coiby Xu wrote:
> On Sun, Jun 14, 2020 at 12:16:28PM -0700, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200614183907.514282-1-coiby.xu@=
gmail.com/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series failed the asan build test. Please find the testing command=
s and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > export ARCH=3Dx86_64
> > make docker-image-fedora V=3D1 NETWORK=3D1
> > time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 =
NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> >  CC      stubs/vm-stop.o
> >  CC      ui/input-keymap.o
> >  CC      qemu-keymap.o
> > /tmp/qemu-test/src/util/vhost-user-server.c:142:30: error: use of undec=
lared identifier 'VHOST_MEMORY_MAX_NREGIONS'
> >                             VHOST_MEMORY_MAX_NREGIONS, nfds + nfds_t);
> >                             ^
> >=20
> > The full log is available at
> > http://patchew.org/logs/20200614183907.514282-1-coiby.xu@gmail.com/test=
ing.asan/?type=3Dmessage.
>=20
> I couldn't re-produce this error locally for both docker-test-quick@cento=
s7
> and this docker test. And I can't see any reason for this error to occur =
since
> VHOST_MEMORY_MAX_NREGIONS is defined in contrib/libvhost-user/libvhost-us=
er.h
> which has been included by util/vhost-user-server.h.

Using G_N_ELEMENTS(vmsg->fds) instead of VHOST_MEMORY_MAX_NREGIONS is an
even cleaner fix.

Stefan

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7rJbwACgkQnKSrs4Gr
c8hbiwgAmU2ZtI71B283rG9ncycCbTc+Y1b1WWIa5W/08DsGYRd2VcjD6EnQLjS5
vKfFtSvLfALseRdo13B6ZC6vba4YoM/9Q/roi8QO33KbuVo1vL/cChg5ZZFvNBwn
9Sng4oGo4OKm0jngQxDnxP6vcYgJ8LSH1TU/MHyo7hxvrPjGSCK7fgJjIkfgxJR9
G+fIKAfUNImYgaQDy1HSR3unBvtvMqo/L/YQIAaqf5j/Jzlqyr38FbjJioMNEfKu
DtUbbNs2QQGbEnmYy4Ppu60Umq2vlPGjbVuhSmDHKRrNdISxce7bPUGb0XP5TRkS
63v7opDBPJczpFv9+X2wTgwdPS0/Wg==
=r3Ya
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--


