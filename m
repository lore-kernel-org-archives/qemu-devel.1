Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E42C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB5C206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9JDghjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB5C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWwd-0003nn-2a
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jZWvs-0002xB-2p
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:47:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jZWvr-0003Yl-6O
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589536024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWVaHkiiCedQgkWuw/4FpDpSOpAK59XIIOs2pJ3h95Q=;
 b=I9JDghjhHlE3AH6EtKxgnOHvOtSgrEBda9fyd4J1hn8Od06uRlB9Cx5tmHjF3GBdga5bT5
 nfv8mFLUP8aFCAFNn5soskoL7IOAzWjRERuNTRFryfbHa0EqrqbBb5PwC7y/3Yu8aomKk0
 4e8KAZNNP6KnenN9y+FBa4fZyiKU9lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-lczl__tlMP2KQ5vsDVolCw-1; Fri, 15 May 2020 05:47:00 -0400
X-MC-Unique: lczl__tlMP2KQ5vsDVolCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E9E9BFCA;
 Fri, 15 May 2020 09:46:59 +0000 (UTC)
Received: from localhost (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5AA2579A0;
 Fri, 15 May 2020 09:46:55 +0000 (UTC)
Date: Fri, 15 May 2020 10:46:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] tests/fuzz: Review notes
Message-ID: <20200515094654.GA355503@stefanha-x1.localdomain>
References: <20200514143433.18569-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514143433.18569-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 04:34:27PM +0200, Philippe Mathieu-Daud=E9 wrote:
> I took some code notes while testing Alex's toy.
> Sending them as patches.
>=20
> Alex, I had theses issues while building following
> docs/devel/fuzzing.txt:
>=20
>     CC      nbd/server.o
>   nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cleanup_N=
BDExtentArray' [-Werror,-Wunused-function]
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
>   ^
>   /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro =
'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>     static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l=
) { g_list_free_full (*_l, (GDestroyNotify) func); } \
>                        ^
>   /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro =
'_GLIB_AUTOPTR_LIST_FUNC_NAME'
>   #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup=
_##TypeName
>                                                  ^
> Solved by using './configure ... --extra-cflags=3D-Wno-unused-function'
>=20
>     LINK    i386-softmmu/qemu-fuzz-i386
>   /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interc=
eptors_vfork.S.o): warning: common of `__interception::real_vfork' overridd=
en by definition
>   /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interc=
eptors.cc.o): warning: defined here
>=20
> I simply ignore this warning.
>=20
> Alex, could you provide few more examples (in particular about
> instantiating devices, or useful libfuzzer arguments)?
>=20
> Also, I suppose you are using a script to generate the bug reports:
>=20
>   I can reproduce it in qemu 5.0 using:
>=20
>   cat << EOF | qemu-system ...
>   outl 0xcf8 ...
>   outl 0xcfc ...
>   ...
>   EOF
>=20
> Is this script available in the QEMU repository? I couldn't find it.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (6):
>   tests/fuzz/Makefile: Do not link code using unavailable devices
>   Makefile: List fuzz targets in 'make help'
>   tests/fuzz: Add missing space in test description
>   tests/fuzz: Remove unuseful/unused typedefs
>   tests/fuzz: Extract pciconfig_fuzz_qos() method
>   tests/fuzz: Extract ioport_fuzz_qtest() method
>=20
>  Makefile                          |  6 +++-
>  tests/qtest/fuzz/i440fx_fuzz.c    | 47 ++++++++++++++++++++-----------
>  tests/qtest/fuzz/Makefile.include |  6 ++--
>  3 files changed, 38 insertions(+), 21 deletions(-)
>=20
> --=20
> 2.21.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6+ZQ4ACgkQnKSrs4Gr
c8h66wgAwyipHH7iW/aLWrsYwvbRVRoepk2Sd5u9u+XUpwxhSl6AVEufvfZ8l3pV
2uzGdXOZsjCfIfQAbjKxah3Tafd2q0PlD8mLhBKV33UB1qT3ulaW+d8BKoXDnqK6
5SDbz3k0LW0SPAKUZeFd33ITrMmoeSnuRQcHn0cpYA5RuulDR5Y2zjkikbwJ4QGL
zPUZry6HZkqUTqgNdhxY7Pv+a/9MqgvwNMB7jbcEHJsJ/6DMqlT1x/u4Z+z1/j0B
rCWSnB0ky8PJY40YgCL7b7v9KuqzsvT8qEC9z9uyfUV+URSyi1U0v7dZZcDPNtw5
ab1KCoceOI1cFQiaHoy/3An/h2zEqA==
=HO3X
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


