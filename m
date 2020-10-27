Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BBC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9236021D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dINjsyVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236021D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLjC-0004zo-HX
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLhV-0003lX-UB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLhR-0007CO-QS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603792527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFx3R6TCLxgEnKr+RPmuYoecV/2YLya44KRwykONRjk=;
 b=dINjsyVNUyTcTy16+mhggB9lpBT9GIgZ8yjbUhLNUDJZnTMuYsmZLXHmbP3OACj0PUKW70
 2lcJrzVbbqoRdAJNDoAc8ntEVaDJJMeE9w5uN4CvKnjCvzp623+JvMtsksxJsWEsTpT920
 pkVGgLJ7z2ITru07X/VFCQQV0ux9wiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-3Z71_8BqMq--Vd3EBpQUBw-1; Tue, 27 Oct 2020 05:55:25 -0400
X-MC-Unique: 3Z71_8BqMq--Vd3EBpQUBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB3D1882FAA;
 Tue, 27 Oct 2020 09:55:24 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2456960C07;
 Tue, 27 Oct 2020 09:55:14 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:55:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 00/19] util/vfio-helpers: Allow using multiple MSIX IRQs
Message-ID: <20201027095513.GF79063@stefanha-x1.localdomain>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:54:45AM +0100, Philippe Mathieu-Daud=E9 wrote:
> This series allow using multiple MSIX IRQs
> We currently share a single IRQ between 2 NVMe queues
> (ADMIN and I/O). This series still uses 1 shared IRQ
> but prepare for using multiple ones.
>=20
> Since v1:
> - Addressed Stefan comment in patch #14
>   "Pass minimum page size to qemu_vfio_open_pci"
>   (check the page size is in range with device)
> - To reduce (and simplify) changes in patch #14, added
>   new patch #2 "Introduce device/iommu 'page_size_min' variables"
> - Added "Trace controller capabilities" useful to test the
>   previous changes
> - "Set request_alignment at initialization" reported by Stefan
>   (and tested by Eric off-list).

The MSI-X patches look good.

I'm confused about the page size patches since they don't solve the 4KB
device page size on 64KB IOMMU page size issue that you and Eric were
working on. I would prefer to hold off on page size changes until that
work is complete.

Stefan

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+X7oEACgkQnKSrs4Gr
c8j+4gf/Y9LPqVLM29rn5dMoMVyN6TdApP+FnLDYdMaJrtpEiX1YzaCYA60nv1IV
9JWC23B7rUrDNm17Oz0oL/TWOpg4myxmu66AmXbiTMwZzmrhERBQP8tJO6nZ5UP+
6WJa3d7tXck9Sku5EW4LfYQKw37QMZy4+vDOQ168nfaPCkX13/M8kGmuzqy+QLAv
ic0tL1EACeAXNf1FxT38kksVfrHo8KbHsjxmVU5/aAfERTu7gdphSs0VEC60mC3i
M7FWOlSDlIngbWVHh25WUtYib8qt2zDFUXkCBsqbT/j4Ltw98Vz0nTBUr08WAw5l
3Ng7xjvOe0e0aXFpTat8Nov0uybW2w==
=bpuX
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--


