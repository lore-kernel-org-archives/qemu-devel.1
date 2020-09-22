Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2608239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsHJliB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2608239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdVG-0004wj-V2
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKdUO-00048W-71
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:17:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKdUM-0005Vc-9i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600762645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oakQ8ZvOG/PZHFgINL6qXTOYOkalonDKl4hzXDidq5o=;
 b=gsHJliB2b1Pf7VoRNrxCZYkpa1Z2X8QeHQU85UPYLdZ7nDtZdb4NfeIW8WQDgNd84aRnBC
 AJQmSawDU7PyPyrCmPpgKgWWozodUuGFNZKbwY+D89wKPSfg6pyvNu11wM9rlHUiuUwvk2
 bukRE82rzOYtstinOz9fqZYmjjYiW84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-NmB85ZUzNVuAZQDy8gEBcA-1; Tue, 22 Sep 2020 04:17:23 -0400
X-MC-Unique: NmB85ZUzNVuAZQDy8gEBcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F881868405;
 Tue, 22 Sep 2020 08:17:18 +0000 (UTC)
Received: from localhost (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4395C225;
 Tue, 22 Sep 2020 08:17:05 +0000 (UTC)
Date: Tue, 22 Sep 2020 09:17:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
Message-ID: <20200922081705.GB201611@stefanha-x1.localdomain>
References: <20200921162346.188997-1-stefanha@redhat.com>
 <160072176188.21069.7427016597134663502@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <160072176188.21069.7427016597134663502@66eaa9a8a123>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:27:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 kvm@vger.kernel.org, david@redhat.com, jasowang@redhat.com,
 yuval.shaia.ml@gmail.com, mdroth@linux.vnet.ibm.com, jcmvbkbc@gmail.com,
 Alistair.Francis@wdc.com, kraxel@redhat.com, chenhc@lemote.com,
 sstabellini@kernel.org, berto@igalia.com, sagark@eecs.berkeley.edu,
 ysato@users.sourceforge.jp, quintela@redhat.com, jslaby@suse.cz,
 mst@redhat.com, armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 aleksandar.qemu.devel@gmail.com, thuth@redhat.com, marcandre.lureau@redhat.com,
 mjrosato@linux.ibm.com, aleksandar.rikalo@syrmia.com, ehabkost@redhat.com,
 sw@weilnetz.de, pl@kamp.de, dgilbert@redhat.com, paul@xen.org,
 anthony.perard@citrix.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 namei.unix@gmail.com, qemu-riscv@nongnu.org, sunilmut@microsoft.com,
 jsnow@redhat.com, zhang.zhanghailiang@huawei.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 mreitz@redhat.com, palmer@dabbelt.com, pbonzini@redhat.com,
 xen-devel@lists.xenproject.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 01:56:08PM -0700, no-reply@patchew.org wrote:
> ERROR: Macros with multiple statements should be enclosed in a do - while=
 loop
> #2968: FILE: include/qemu/atomic.h:152:
> +#define qemu_atomic_rcu_read__nocheck(ptr, valptr)      \
>      __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
>      smp_read_barrier_depends();
>=20
> ERROR: space required before that '*' (ctx:VxB)
> #3123: FILE: include/qemu/atomic.h:347:
> +#define qemu_atomic_read__nocheck(p) (*(__typeof__(*(p)) volatile*) (p))
>                                                                   ^
>=20
> ERROR: Use of volatile is usually wrong, please add a comment
> #3123: FILE: include/qemu/atomic.h:347:
> +#define qemu_atomic_read__nocheck(p) (*(__typeof__(*(p)) volatile*) (p))
>=20
> ERROR: space required before that '*' (ctx:VxB)
> #3125: FILE: include/qemu/atomic.h:349:
> +    ((*(__typeof__(*(p)) volatile*) (p)) =3D (i))
>                                   ^
>=20
> ERROR: Use of volatile is usually wrong, please add a comment
> #3125: FILE: include/qemu/atomic.h:349:
> +    ((*(__typeof__(*(p)) volatile*) (p)) =3D (i))
>=20
> ERROR: space required after that ',' (ctx:VxV)
> #3130: FILE: include/qemu/atomic.h:352:
> +#define qemu_atomic_set(ptr, i)     qemu_atomic_set__nocheck(ptr,i)
>                                                                  ^
>=20
> ERROR: memory barrier without comment
> #3205: FILE: include/qemu/atomic.h:410:
> +#define qemu_atomic_xchg(ptr, i) (smp_mb(), __sync_lock_test_and_set(ptr=
, i))
>=20
> WARNING: Block comments use a leading /* on a separate line
> #3280: FILE: include/qemu/atomic.h:462:
> +/* qemu_atomic_mb_read/set semantics map Java volatile variables. They a=
re
>=20
> WARNING: Block comments use a leading /* on a separate line
> #6394: FILE: util/bitmap.c:214:
> +        /* If we avoided the full barrier in qemu_atomic_or(), issue a
>=20
> WARNING: Block comments use a leading /* on a separate line
> #7430: FILE: util/rcu.c:85:
> +        /* Instead of using qemu_atomic_mb_set for index->waiting, and
>=20
> WARNING: Block comments use a leading /* on a separate line
> #7456: FILE: util/rcu.c:154:
> +        /* In either case, the qemu_atomic_mb_set below blocks stores th=
at free
>=20
> total: 7 errors, 4 warnings, 6507 lines checked

These are pre-existing coding style issues. This is a big patch that
tries to make as few actual changes as possible so I would rather not
try to fix them.

Stefan

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9pswEACgkQnKSrs4Gr
c8iYggf/cN1AvmT30HEFnk6TFaWwEK/1uPdJX8OsfFcwI7Y3ubB8wcLWnyXzwsOg
tRL2aDrOZ1cJcV8pHVtlNuJTcqox1NBFhSC6thYgo4PzXU7O2+LPijF+PrrJBrer
C/TLImTNNDBL8+IQX8bOBz4kVqyoEoodEvNsRUb05oyhVK0uej9yK0Vf+WOiRDmf
O4f1cAXTcA0qhhmU5NJO5sNe3cVEbrkHJ9wtK7mFlIRt/RuHLvW5M0UscL0/KF2o
SyWNVBIVFKBl/o16jkA4J+C1wAM6uPP3s5NYqJgaEUtYUaP7cir42blCMCa3MYz6
LSmqavtaJ2f531DBpjOq3G5c+fyk5A==
=nJgj
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--


