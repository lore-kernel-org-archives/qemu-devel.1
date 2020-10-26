Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C8CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821A2076B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2d7D9Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3yZ-0003rK-Cq
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX3xo-0003Je-Sz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX3xm-0003hS-Rz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603724349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1z7koPYbZaiQnGU0m0CQ10b7BPxxTEy72Ct07wiOXY=;
 b=B2d7D9MgHGL4X11pWqeqP/diOOErF41GdZK8VV5byTVsZWDLNxM5lmlHPA2KfrM13JjE9G
 XnauzhNlx34tWWKX3dqVXMOKZlFTr8bspzYRp/+P6FcHiAtcZqFaBijizztLg+2FA/pKSZ
 3+sVzpua567KhdfwdgglX1KxhLsOzFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363--d56hIdoO2a3fzXAW7uNZQ-1; Mon, 26 Oct 2020 10:59:06 -0400
X-MC-Unique: -d56hIdoO2a3fzXAW7uNZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D14AD1020903
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:59:05 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 760F15C1BB;
 Mon, 26 Oct 2020 14:59:05 +0000 (UTC)
Date: Mon, 26 Oct 2020 14:59:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 1/5] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20201026145904.GC52035@stefanha-x1.localdomain>
References: <20201023165812.36028-1-dgilbert@redhat.com>
 <20201023165812.36028-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023165812.36028-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 05:58:08PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add an option to define mappings of xattr names so that
> the client and server filesystems see different views.
> This can be used to have different SELinux mappings as
> seen by the guest, to run the virtiofsd with less privileges
> (e.g. in a case where it can't set trusted/system/security
> xattrs but you want the guest to be able to), or to isolate
> multiple users of the same name; e.g. trusted attributes
> used by stacking overlayfs.
>=20
> A mapping engine is used with 3 simple rules; the rules can
> be combined to allow most useful mapping scenarios.
> The ruleset is defined by -o xattrmap=3D'rules...'.
>=20
> This patch doesn't use the rule maps yet.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/tools/virtiofsd.rst         |  92 ++++++++++++++++
>  tools/virtiofsd/passthrough_ll.c | 173 +++++++++++++++++++++++++++++++
>  2 files changed, 265 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W5DgACgkQnKSrs4Gr
c8hXnAf9FRtyTrpmi38Fkm6CGlb2OCJiWoJvjz0oEPb82LFKPmDQglfbALDYRtNe
r0/iJScUlsbemrzhqow6+B/DgjQn5J/HgYXBLxi5HHvi2flAnHVUvB1fb9BCwOGH
loxODG1b6lBXDHfh6+2Ikk9sClPhM0dak6W4+2p8gmqFpvDcNs1TrC8Y46C36P+O
9zKijiF8g+OWl+Uy2W7G+pmWCP3dJqttKKP2KsDII47JTTlboVWJMVTPlJo8lxA+
Ig78ZfthyF8zwqunMZS6wBJICiJ8Awc2pGV0OcVgy/iUNo1UTTGn9jMR0aJJB9A8
gzt9o06tX7bOsbmb/BAY4mri57BmFA==
=lUXW
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


