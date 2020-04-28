Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D56C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501FD206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPEbD8a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501FD206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTEc-00053n-E2
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTT9v-0006UV-Dl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTT85-0005lx-4m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:32:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTT84-0005ln-Nf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAS6FxUWwaPbBIIulpdTfLEjfQ4/VTpmjP/FyRYSkT8=;
 b=hPEbD8a1t9n9VR3/k616QJ5JG229XD6ekQcyFWQBvI7pMeHsYNrCNLFvbycT0qXLiFoeRU
 TLGrIpN2EXWMfmVWuehWZSRXwDxV5+8yqpqRE6I2U480rilTRR33fYGO7vI2F4sRRuBdQk
 F7GpqRmuyIk3yjGGxYNU0FFnWdL4oq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-SxipNdLMOqyoJ-6nO20MKw-1; Tue, 28 Apr 2020 12:29:28 -0400
X-MC-Unique: SxipNdLMOqyoJ-6nO20MKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB918107B28B;
 Tue, 28 Apr 2020 16:29:24 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4004282CA;
 Tue, 28 Apr 2020 16:29:17 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:29:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 08/36] multi-process: Add stub functions to
 facilitate build of multi-process
Message-ID: <20200428162916.GC109767@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <647fa5bf70dbea7d2b4e47d2084dea3a66385433.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424131230.GA190507@stefanha-x1.localdomain>
 <A0E83A03-3B01-4863-949A-F5DDC328A387@oracle.com>
MIME-Version: 1.0
In-Reply-To: <A0E83A03-3B01-4863-949A-F5DDC328A387@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 09:47:56AM -0400, Jag Raman wrote:
> > On Apr 24, 2020, at 9:12 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > On Wed, Apr 22, 2020 at 09:13:43PM -0700, elena.ufimtseva@oracle.com wr=
ote:
> >> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> >> index f884bb6180..f74c7e927b 100644
> >> --- a/stubs/Makefile.objs
> >> +++ b/stubs/Makefile.objs
> >> @@ -20,6 +20,7 @@ stub-obj-y +=3D migr-blocker.o
> >> stub-obj-y +=3D change-state-handler.o
> >> stub-obj-y +=3D monitor.o
> >> stub-obj-y +=3D monitor-core.o
> >> +stub-obj-y +=3D get-fd.o
> >> stub-obj-y +=3D notify-event.o
> >> stub-obj-y +=3D qtest.o
> >> stub-obj-y +=3D replay.o
> >=20
> > audio.c, vl-stub.c, and xen-mapcache.c are added by this patch but not
> > added to Makefile.objs?  Can they be removed?
>=20
> Hey Stefan,
>=20
> Sorry it=E2=80=99s not clear. but these files are referenced in Makefile.=
target.

Why is the Makefile.target change not in this patch?

Please structure patch series as logical changes that can be reviewed
sequentially.  Not only is it hard for reviewers to understand what is
going on but it probably also breaks bisectability if patches contain
incomplete changes.

> >=20
> > This entire patch requires justification.  Stubs exist so that common
> > code can be linked without optional features.
> >=20
> > For example, common code may call into kvm but that callback isn't
> > relevant when building with kvm accelerator support (e.g. say qemu-nbd)=
.
> > That's where the stub function comes in.  It fulfills the dependency
> > without dragging in the actual kvm accelerator code.
> >=20
> > Adding lots of stubs suggests you are building QEMU in a new way that
> > wasn't done before (this is true and expected for this patch series).  =
I
> > would like to understand the reason for these stubs though.  For
> > example, why do you need to stub audio?
>=20
> These stub functions are only used by the remote process, and not by
> QEMU itself.
>=20
> Our goal is to ensure that the remote process is building the smallest
> set of files necessary and these stub functions are necessary to meet
> that goal.
>=20
> For example, the remote process needs to build some of the functions
> defined in =E2=80=9Chw/core/qdev-properties-system.c=E2=80=9D. However, t=
his file
> depends on audio.c (references audio_state_by_name()), which is not
> needed for the remote process. The alternative to stub functions would
> be to compile audio.c into the remote process, but that was not necessary
> in our judgement. When the project started out, we spent a lot of time
> figuring out which functions/files are necessary for the remote process, =
and
> we stubbed out the ones which are needed to resolve dependency during
> compilation, but not needed for functionality.
>=20
> audio.c is just an example of tens of other places where we needed to
> make similar judgements.
>=20
> Would you prefer if we moved these stub functions into a separate
> library (instead of stub-obj-y) which is only linked by the remote proces=
s?

It's too bad that none of these judgements were documented.  As a
reviewer I have no idea what the justification for each individual stub
was.

Some stubs are unavoidable but they also indicate that the code is
tightly coupled where maybe it can be split up.  The
qdev-properties-system.c example you mentioned sounds like something
that should be broken up into multiple files.  Then stubs wouldn't be
necessary.

That said, adding stubs doesn't place a great burden on anyone and I
think they can be merged.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6oWdwACgkQnKSrs4Gr
c8hy0wgAwfb/db1YJ3Wh8uan2ZBvvBW3J82bOvP9LeYtVtQ2N+T8QTnRlsIzX9Cc
x9rLoFEIUxoveQXwhDyw6qI52/1lxdBp+8ASY2MedpaDLESEwOZJey4yYoL/15Zz
RTU7sCk45qmubB2EXgHzMu5WWuAxkyfZHq0MpCFnF3hADn5wJqHrZdYB5QhW6KNK
oz2XyjWqdJthHUJgl2ou/3QNspQXWNWwJuzgl7Z9AvN10Rbxg+RQ+qlbpqqTQh4B
1QHU7umUZKLu9Gh9ll1RaQBVXfRfvv5QJx2q2YPzeeYHnyO48Kmkk4ZdTRRcpFxO
Fi7+Dt0lk+8i9lQKK9wBD//sqmjnqQ==
=zbF/
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--


