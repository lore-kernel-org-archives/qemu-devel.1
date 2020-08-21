Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD620724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaoqYZ73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Tb-0008C9-EO
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k953w-0001JG-PP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k953u-0008Gc-Iv
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598008701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/fJOlqSUYb1iE40x2bIwvvAj6CumhhXWCvhyyUZrdA=;
 b=XaoqYZ73Gv+O6uTU2cPyZhiI0slH27VDOWeGBWd1pJNoI+3RrF2qveMVEQYxcvwHxCF9U5
 w/mAfy+eSNh2ghf0CgA6MbcbpGEipVSzJFpBlYfR+gSPul62E2kJUKWKq7/CZNzYIMHT7L
 CzL+cRJCPO6Ic1vaMpd8n4LzHBx5ENU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-hHqmZGrSPaS7ChykoAmnww-1; Fri, 21 Aug 2020 07:18:19 -0400
X-MC-Unique: hHqmZGrSPaS7ChykoAmnww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 590951DE0E;
 Fri, 21 Aug 2020 11:18:18 +0000 (UTC)
Received: from localhost (ovpn-113-166.ams2.redhat.com [10.36.113.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9F9060BF1;
 Fri, 21 Aug 2020 11:18:17 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:18:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH] virtiofsd: add -o allow_directio|no_directio option
Message-ID: <20200821111816.GC205318@stefanha-x1.localdomain>
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> open flag of guest applications will be discarded by virtiofsd. While
> this behavior makes it consistent with the virtio-9p scheme when guest
> applications using direct I/O, we no longer have any chance to bypass
> the host page cache.
>=20
> Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
> option is added, or none of '-o no_directio' or '-o allow_directio' is
> added, the 'allow_directio' will be set to 0, and virtiofsd discards
> O_DIRECT as before. If '-o allow_directio' is added to the stariting
> command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> flags will be retained and host page cache can be bypassed.
>=20
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  tools/virtiofsd/helper.c         |  4 ++++
>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)

Nice, thanks! This will be useful for benchmarking.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8/rXgACgkQnKSrs4Gr
c8hjnQf+OOD30/FUgjlQ4uOFY3GT47Dsqns9iIxYq2QEYlJjV6sSnGQnxcSvFZm8
BOcGWf8UXUTXI4zXgp2jpqtlml2f6vMSIowYosA6z0Y7sGkk8Op3aDNiFAN1n9AK
g6tb2ySU9/qC/d5c2UZEr+RrjZ69OHwpGQm7DbI4aTduvLuuiviF/n3b1tzChPqK
dJ0SxSfB+HlvQQLCZBME8AtinlXb8IeGC2ncuQMFqGLUY+qn7fkoMb9M9RieCTL8
fK3OksEaTH16Dg+qAexT+d44SF3Wc80Ow57dzr/iwG+n9cupF6cG7AjI+AcOKOI+
rQGFACmP3ncLuhI/SCj+WW7I5cbFiw==
=q2b5
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--


