Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA1C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2F020C09
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMt6Bea9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2F020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4B3-0003PM-8w
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL49e-00027T-Hq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL49c-0007Ph-LY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQbMnKsjNUc/LKekeTNEiZSAsCYCAhCvIx46aL9pJy0=;
 b=SMt6Bea9J7K2vqP6aCDmewxAiLBv00G4F/0fmCfyDgFE/eURJxtiOPXY7RVjcNUEqLoCnu
 BrbyBzhs3I+dVcD2F1u7VywYc7ctpIC8N+XCfRanqmOAgVvQCuVjPJaTBQZCegixFZQJ19
 7sEgdwCfzpmLt+cRrvGO4shZCJIEDlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-B3G-GuyyMt62OM-T1KLGvQ-1; Wed, 23 Sep 2020 08:45:42 -0400
X-MC-Unique: B3G-GuyyMt62OM-T1KLGvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AAF101962B
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 12:45:41 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4A8673668
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 12:45:40 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:45:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] gitmodules: add qboot, meson, and vbootrom mirrors
Message-ID: <20200923124539.GH51019@stefanha-x1.localdomain>
References: <20200915130834.706758-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915130834.706758-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 02:08:31PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Rebase now that vbootrom is in .gitmodules [Peter]
>=20
> This patch series adds qemu.org mirrors for qboot, meson, and vbootrom.
>=20
> vbootrom is not yet used by qemu.git/master so you may wish to hold off o=
n
> applying the final patch.
>=20
> Stefan Hajnoczi (3):
>   gitmodules: switch to qemu.org qboot mirror
>   gitmodules: switch to qemu.org meson mirror
>   gitmodules: add qemu.org vbootrom submodule
>=20
>  .gitmodules | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rQ3MACgkQnKSrs4Gr
c8ikSAf/by81xEuwHo/XjSnR2wW/LNN57hvbpRb9rmMpkNUVociPlWjjMNZwFkqg
S2N7Ai5kkQYQ45prilPIjS+HQq6J+9QXk2zzgPK/cRTpBR6J4YnlW8Djt4N/dWXM
aDfd3ilyrGOLlDG5oWKoJZK23uAFdM3VEHzqDDYj0UXPIbZeBEKLTJQePdzsoCSA
goRWsQNducySp9PGXO38MNOcvavVc3PYmD9A3PkZKqBvHvDa8ffKWHsial0QQLa0
4Kvmw+Y6/nkD6lDGPfYPvCx/eYT6AbER5cxMu310bvcIXStMSrlBELwJFyGse6jo
zp1g0lvY2fLO2EFo7kJtBsV0zKEmzw==
=21BW
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--


