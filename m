Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60652C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15C8207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGbeHp/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15C8207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHPk-0005vo-10
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKHMF-0001oe-WF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKHMD-0003WV-Db
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600677572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szMmPZwO5ZvD7j+uBn+j2B3Y9vhCoD0E1DP9d/TTuPc=;
 b=FGbeHp/Pow9qYRLs/fhrxIlqiM3zuVKi6H4LJnHjiRrzeQahIvo9fu+cccpifG4I4RhOYY
 ZBIm9mSXxJ0e99PlOlykkQfg1NRAvklGSkzNE0TYPmzRgrEgGwcvS1dt1vJRBklU9FKt1K
 nkDIFhjKhyxDou255py0Jeji++rl7Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-PywmEaZ4MRiu_bF7c02RhA-1; Mon, 21 Sep 2020 04:39:29 -0400
X-MC-Unique: PywmEaZ4MRiu_bF7c02RhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56551091064
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:39:27 +0000 (UTC)
Received: from localhost (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7806061177;
 Mon, 21 Sep 2020 08:39:24 +0000 (UTC)
Date: Mon, 21 Sep 2020 09:39:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200921083923.GA71121@stefanha-x1.localdomain>
References: <20200918213436.GA3520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918213436.GA3520@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 05:34:36PM -0400, Vivek Goyal wrote:
> And here are the comparision results. To me it seems that by default
> we should switch to 1 thread (Till we can figure out how to make
> multi thread performance better even when single process is doing
> I/O in client).

Let's understand the reason before making changes.

Questions:
 * Is "1-thread" --thread-pool-size=3D1?
 * Was DAX enabled?
 * How does cache=3Dnone perform?
 * Does commenting out vu_queue_get_avail_bytes() + fuse_log("%s:
   Queue %d gave evalue: %zx available: in: %u out: %u\n") in
   fv_queue_thread help?
 * How do the kvm_stat vmexit counters compare?
 * How does host mpstat -P ALL compare?
 * How does host perf record -a compare?
 * Does the Rust virtiofsd show the same pattern (it doesn't use glib
   thread pools)?

Stefan

> NAME                    WORKLOAD                Bandwidth       IOPS     =
      =20
> cache-auto              seqread-psync           690(MiB/s)      172k     =
      =20
> cache-auto-1-thread     seqread-psync           729(MiB/s)      182k     =
      =20
>=20
> cache-auto              seqread-psync-multi     2578(MiB/s)     644k     =
      =20
> cache-auto-1-thread     seqread-psync-multi     2597(MiB/s)     649k     =
      =20
>=20
> cache-auto              seqread-mmap            660(MiB/s)      165k     =
      =20
> cache-auto-1-thread     seqread-mmap            672(MiB/s)      168k     =
      =20
>=20
> cache-auto              seqread-mmap-multi      2499(MiB/s)     624k     =
      =20
> cache-auto-1-thread     seqread-mmap-multi      2618(MiB/s)     654k     =
      =20
>=20
> cache-auto              seqread-libaio          286(MiB/s)      71k      =
      =20
> cache-auto-1-thread     seqread-libaio          260(MiB/s)      65k      =
      =20
>=20
> cache-auto              seqread-libaio-multi    1508(MiB/s)     377k     =
      =20
> cache-auto-1-thread     seqread-libaio-multi    986(MiB/s)      246k     =
      =20
>=20
> cache-auto              randread-psync          35(MiB/s)       9191     =
      =20
> cache-auto-1-thread     randread-psync          55(MiB/s)       13k      =
      =20
>=20
> cache-auto              randread-psync-multi    179(MiB/s)      44k      =
      =20
> cache-auto-1-thread     randread-psync-multi    209(MiB/s)      52k      =
      =20
>=20
> cache-auto              randread-mmap           32(MiB/s)       8273     =
      =20
> cache-auto-1-thread     randread-mmap           50(MiB/s)       12k      =
      =20
>=20
> cache-auto              randread-mmap-multi     161(MiB/s)      40k      =
      =20
> cache-auto-1-thread     randread-mmap-multi     185(MiB/s)      46k      =
      =20
>=20
> cache-auto              randread-libaio         268(MiB/s)      67k      =
      =20
> cache-auto-1-thread     randread-libaio         254(MiB/s)      63k      =
      =20
>=20
> cache-auto              randread-libaio-multi   256(MiB/s)      64k      =
      =20
> cache-auto-1-thread     randread-libaio-multi   155(MiB/s)      38k      =
      =20
>=20
> cache-auto              seqwrite-psync          23(MiB/s)       6026     =
      =20
> cache-auto-1-thread     seqwrite-psync          30(MiB/s)       7925     =
      =20
>=20
> cache-auto              seqwrite-psync-multi    100(MiB/s)      25k      =
      =20
> cache-auto-1-thread     seqwrite-psync-multi    154(MiB/s)      38k      =
      =20
>=20
> cache-auto              seqwrite-mmap           343(MiB/s)      85k      =
      =20
> cache-auto-1-thread     seqwrite-mmap           355(MiB/s)      88k      =
      =20
>=20
> cache-auto              seqwrite-mmap-multi     408(MiB/s)      102k     =
      =20
> cache-auto-1-thread     seqwrite-mmap-multi     438(MiB/s)      109k     =
      =20
>=20
> cache-auto              seqwrite-libaio         41(MiB/s)       10k      =
      =20
> cache-auto-1-thread     seqwrite-libaio         65(MiB/s)       16k      =
      =20
>=20
> cache-auto              seqwrite-libaio-multi   137(MiB/s)      34k      =
      =20
> cache-auto-1-thread     seqwrite-libaio-multi   214(MiB/s)      53k      =
      =20
>=20
> cache-auto              randwrite-psync         22(MiB/s)       5801     =
      =20
> cache-auto-1-thread     randwrite-psync         30(MiB/s)       7927     =
      =20
>=20
> cache-auto              randwrite-psync-multi   100(MiB/s)      25k      =
      =20
> cache-auto-1-thread     randwrite-psync-multi   151(MiB/s)      37k      =
      =20
>=20
> cache-auto              randwrite-mmap          31(MiB/s)       7984     =
      =20
> cache-auto-1-thread     randwrite-mmap          55(MiB/s)       13k      =
      =20
>=20
> cache-auto              randwrite-mmap-multi    124(MiB/s)      31k      =
      =20
> cache-auto-1-thread     randwrite-mmap-multi    213(MiB/s)      53k      =
      =20
>=20
> cache-auto              randwrite-libaio        40(MiB/s)       10k      =
      =20
> cache-auto-1-thread     randwrite-libaio        64(MiB/s)       16k      =
      =20
>=20
> cache-auto              randwrite-libaio-multi  139(MiB/s)      34k      =
      =20
> cache-auto-1-thread     randwrite-libaio-multi  212(MiB/s)      53k      =
      =20
>=20
>=20
>=20
>=20
>=20
>=20

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9oZrkACgkQnKSrs4Gr
c8hWWgf/caiEHK3xeTWTOvaSY9b2skEAqR34Apthl9YK89/J3rdzTcqQ3JqqIEQH
mmRbw387/xD6Fabms1CXgj2iASu9ZHby8egxiYC1W0um9cEroHJMncjxRTaFu2PC
4LMJc40jvRgTVNIkIYeQKNJBK0bW2PZsSLAgO1aP5+f5XemfNwQv6Jacew4i4ZP/
q91QjYyZPGcgJXzLHr3JpKymULAlq1HiMfov93mHp6CnoFaOpKdQ8sGth2RnTYsH
mVeXZLNYY/ZGp2r3DXl1Pdzgc1RN9tF7eglJXh3nbPhCGG2GRv7TcZq8oUyzx3jr
MEdIKCt7KH5W3XQnLeTYjqgUpyDDmw==
=xpCg
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


