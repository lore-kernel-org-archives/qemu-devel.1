Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF7C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C661F2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxBDEozZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C661F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeQJ-0004RV-Sx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKeF2-000310-PM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:05:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKeEw-0003FO-Ty
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600765533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5XZ28c/Nw+4z39lcTrdziaDLFRmRShRLazOWsJ9L5s=;
 b=TxBDEozZ2UwA1R1JjVffozZ16+8RfEQQuDIlJEsGglSTK25ETEmqgkW18a2M6wxct5ize2
 zx4TS618Br/SNpvQCmNCwmJ2QPoIo8hbRMv9OkVAjGJ0fwy67lhZczRJ14bQl8h0bBA4sj
 uugp4K1c7T/RrBZfUkmPz2/0UFDzRu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-C1Ux0o_ZNx2wKnT6v78PDQ-1; Tue, 22 Sep 2020 05:05:31 -0400
X-MC-Unique: C1Ux0o_ZNx2wKnT6v78PDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1EB78030A5;
 Tue, 22 Sep 2020 09:05:26 +0000 (UTC)
Received: from localhost (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E13FA7EB74;
 Tue, 22 Sep 2020 09:05:13 +0000 (UTC)
Date: Tue, 22 Sep 2020 10:05:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
Message-ID: <20200922090513.GC201611@stefanha-x1.localdomain>
References: <20200921162346.188997-1-stefanha@redhat.com>
 <1ce94412-7a01-9208-31b1-76b7562c3843@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1ce94412-7a01-9208-31b1-76b7562c3843@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:27:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 sheepdog@lists.wpkg.org, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Jiri Slaby <jslaby@suse.cz>, Stefano Stabellini <sstabellini@kernel.org>,
 Alberto Garcia <berto@igalia.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Paul Durrant <paul@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Liu Yuan <namei.unix@gmail.com>, qemu-riscv@nongnu.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>, John Snow <jsnow@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 04:29:10PM -0500, Eric Blake wrote:
> On 9/21/20 11:23 AM, Stefan Hajnoczi wrote:

Thanks for the review! Your feedback prompted me to do this more
systematically. I fixed the command-lines and published a diff of just
the manual changes I made on top of the mechanical changes (see v2).

> > clang's C11 atomic_fetch_*() functions only take a C11 atomic type
> > pointer argument. QEMU uses direct types (int, etc) and this causes a
> > compiler error when a QEMU code calls these functions in a source file
> > that also included <stdatomic.h> via a system header file:
> >=20
> >    $ CC=3Dclang CXX=3Dclang++ ./configure ... && make
> >    ../util/async.c:79:17: error: address argument to atomic operation m=
ust be a pointer to _Atomic type ('unsigned int *' invalid)
> >=20
> > Avoid using atomic_*() names in QEMU's atomic.h since that namespace is
> > used by <stdatomic.h>. Prefix QEMU's APIs with qemu_ so that atomic.h
> > and <stdatomic.h> can co-exist.
> >=20
> > This patch was generated using:
> >=20
> >    $ git diff | grep -o '\<atomic_[a-z0-9_]\+' | sort -u >/tmp/changed_=
identifiers
>=20
> Missing a step in the recipe: namely, you probably modified
> include/qemu/atomic*.h prior to running 'git diff' (so that you actually =
had
> input to feed to grep -o).  But spelling it 'git diff HEAD^
> include/qemu/atomic*.h | ...' does indeed give me a sane list of identifi=
ers
> that looks like what you touched in the rest of the patch.

Yes, I edited the file first and then used this command-line. The one
you posted it better :).

>=20
> >    $ for identifier in $(</tmp/changed_identifiers64); do \
>=20
> Also not quite the right recipe, based on the file name used in the line
> above.

Yes, "64" is when I realized the original grep expression hadn't matched
the atomic64 APIs.

These commands only show the gist of it. It involved a few manual steps.

>=20
> >         sed -i "s%\<$identifier\>%qemu_$identifier%" $(git grep -l "\<$=
identifier\>") \
> >      done
> >=20
>=20
> Fortunately, running "git grep -c '\<atomic_[a-z0-9_]\+'" on the pre-patc=
h
> state of the tree gives me a list that is somewhat close to yours, where =
the
> obvious difference in line counts is explained by:
>=20
> > I manually fixed line-wrap issues and misaligned rST tables.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> First, focusing on the change summary:
>=20
> >   docs/devel/lockcnt.txt                        |  14 +-
> >   docs/devel/rcu.txt                            |  40 +--
> >   accel/tcg/atomic_template.h                   |  20 +-
> >   include/block/aio-wait.h                      |   4 +-
> >   include/block/aio.h                           |   8 +-
> >   include/exec/cpu_ldst.h                       |   2 +-
> >   include/exec/exec-all.h                       |   6 +-
> >   include/exec/log.h                            |   6 +-
> >   include/exec/memory.h                         |   2 +-
> >   include/exec/ram_addr.h                       |  27 +-
> >   include/exec/ramlist.h                        |   2 +-
> >   include/exec/tb-lookup.h                      |   4 +-
> >   include/hw/core/cpu.h                         |   2 +-
> >   include/qemu/atomic.h                         | 258 +++++++-------
> >   include/qemu/atomic128.h                      |   6 +-
>=20
> These two are the most important for the sake of this patch; perhaps it's
> worth a temporary override of your git orderfile if you have to respin, t=
o
> list them first?

Will do in v2.

>=20
> >   include/qemu/bitops.h                         |   2 +-
> >   include/qemu/coroutine.h                      |   2 +-
> >   include/qemu/log.h                            |   6 +-
> >   include/qemu/queue.h                          |   8 +-
> >   include/qemu/rcu.h                            |  10 +-
> >   include/qemu/rcu_queue.h                      | 103 +++---
>=20
> Presumably, this and any other file with an odd number of changes was due=
 to
> a difference in lines after reformatting long lines.

Yes, line-wrapping required many changes in this file.

>=20
> >   include/qemu/seqlock.h                        |   8 +-
> ...
>=20
> >   util/stats64.c                                |  34 +-
> >   docs/devel/atomics.rst                        | 326 +++++++++--------=
-
> >   .../opensbi-riscv32-generic-fw_dynamic.elf    | Bin 558668 -> 558698 =
bytes
> >   .../opensbi-riscv64-generic-fw_dynamic.elf    | Bin 620424 -> 620454 =
bytes
>=20
> Why are we regenerating .elf files in this patch?  Is your change even
> correct for those two files?

Thanks for noticing this! The git-grep(1) man page documents the -I
option for skipping binary files. I thought this was the default.

Will fix in v2.

>=20
> >   scripts/kernel-doc                            |   2 +-
> >   tcg/aarch64/tcg-target.c.inc                  |   2 +-
> >   tcg/mips/tcg-target.c.inc                     |   2 +-
> >   tcg/ppc/tcg-target.c.inc                      |   6 +-
> >   tcg/sparc/tcg-target.c.inc                    |   5 +-
> >   135 files changed, 1195 insertions(+), 1130 deletions(-)
>=20
> I don't spot accel/tcg/atomic_common.c.inc in the list (which declares
> functions such as atomic_trace_rmw_pre) - I guess that's intentional base=
d
> on how you tried to edit only the identifiers you touched in
> include/qemu/atomic*.h.

Yes. The namespace cleaning only applies to atomic.h. Any other part of
QEMU uses atomic_ is unaffected.

> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 030b5c8691..9ec38a1bf1 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1625,7 +1625,7 @@ sub dump_function($$) {
> >       # If you mess with these regexps, it's a good idea to check that
> >       # the following functions' documentation still comes out right:
> >       # - parport_register_device (function pointer parameters)
> > -    # - atomic_set (macro)
> > +    # - qemu_atomic_set (macro)
> >       # - pci_match_device, __copy_to_user (long return type)
>=20
> Does the result of sphinx still look good, as mentioned in this comment?

Yes.

Stefan

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9pvkkACgkQnKSrs4Gr
c8ijMAf+KxriRSupSZdvFISwtf4I1wF3o4wobEjSkF8aFOGI+Myg2x9r8LY4PE24
i0ommAJZLH3h+vdyH+Pz+IuPZbMrVlKteGQLpNUYruz0Xo6uKLo0gC1o1Dohf9Fp
2KdinT1vU3nGmn4XOdac9KLpvnUdNpXR/L8MgRps4DfFoU171WWlROaxBYdQFXRu
igcNqRaOaQmSkRKU62eFLjxhHPsDofiWxN5Do1YIPqZr6J/eVygdp7bWfYu4i7t9
i2mlZNjf6S7EF3zq0HMGrjAMx/YHfIIo+fOBckjI2+WEdjLfePMbrVbVT+7HiBd9
99hTSIGsu5w0hsUbc0y+NLgRokY2lA==
=cZCa
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--


