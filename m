Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F2C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED97206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkXCuL/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED97206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3me-0006Vq-Ms
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ka3li-0005ZS-8R
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ka3le-0006IK-Jc
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604438578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOW4QUfnYYSPsDzNrcVIJP1SHGGuvbrd/I9rodAwvQI=;
 b=FkXCuL/Ddhc/O4UmtbrsSdDQOSX61am66vnYjOEuybHLvmDzh8zVRpx4oikt6pYD7uLf03
 ViPlbR28wbz1Ltukp9znQwXlW7NxO85a/6NLrgTN0537jZTmfvOatIJf7bQaiOOsV+e2Qw
 MRMU98CQVRE3QvajeMkbBzDWuGKRrGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-yTfLyHqFNUm5fayUYtp1Vw-1; Tue, 03 Nov 2020 16:22:56 -0500
X-MC-Unique: yTfLyHqFNUm5fayUYtp1Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD72D1F3322
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 21:22:42 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EDA960E1C;
 Tue,  3 Nov 2020 21:22:41 +0000 (UTC)
Date: Tue, 3 Nov 2020 22:22:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
Message-ID: <20201103222239.5463be00@redhat.com>
In-Reply-To: <20201103160843.GP205187@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
 <20201103160843.GP205187@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 16:08:43 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Nov 03, 2020 at 10:14:52AM -0500, Paolo Bonzini wrote:
> > Options such as "server" or "nowait", that are commonly found in -chard=
ev,
> > are sugar for "server=3Don" and "wait=3Doff".  This is quite surprising=
 and
> > also does not have any notion of typing attached.  It is even possible =
to
> > do "-device e1000,noid" and get a device with "id=3Doff".
> >=20
> > Deprecate all this, except for -chardev and -spice where it is in
> > wide use.
> >=20
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  chardev/char.c             |  1 +
> >  docs/system/deprecated.rst |  7 +++++++
> >  include/qemu/option.h      |  1 +
> >  tests/test-qemu-opts.c     |  1 +
> >  ui/spice-core.c            |  1 +
> >  util/qemu-option.c         | 22 +++++++++++++++-------
> >  6 files changed, 26 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 78553125d3..108da615df 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -829,6 +829,7 @@ Chardev *qemu_chr_find(const char *name)
> > =20
> >  QemuOptsList qemu_chardev_opts =3D {
> >      .name =3D "chardev",
> > +    .allow_flag_options =3D true, /* server, nowait, etc. */
> >      .implied_opt_name =3D "backend",
> >      .head =3D QTAILQ_HEAD_INITIALIZER(qemu_chardev_opts.head),
> >      .desc =3D {
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 32a0e620db..0e7edf7e56 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -146,6 +146,13 @@ Drives with interface types other than ``if=3Dnone=
`` are for onboard
> >  devices.  It is possible to use drives the board doesn't pick up with
> >  -device.  This usage is now deprecated.  Use ``if=3Dnone`` instead.
> > =20
> > +Short-form boolean options (since 5.2)
> > +''''''''''''''''''''''''''''''''''''''
> > +
> > +Boolean options such as ``share=3Don``/``share=3Doff`` can be written
> > +in short form as ``share`` and ``noshare``.  This is deprecated
> > +for all command-line options except ``-chardev` and ``-spice``, for
> > +which the short form was in wide use. =20
>=20
> So IIUC, the short form was possible to use for absolutely /any/
> boolean property ?
>=20
> IMHO if we're going to deprecate short forms, we should do it
> universally including chardev and spice. Arguably spice/chardev
> are the most important ones to give an explicit warning about
> precisely because their widespread usage means a heads up is
> important to users.  For chardev in particular it is possible
> we might end up wanting to wait longer than the usual 2 cycles
> before removal. So if we're serious about removing the short
> forms long term, the sooner we deprecate & warn the better
> for chardev.

shall we also deprecate short forms for -cpu model,[feat|+feat|-feat]
and in the end allow only -device compatible form i.e. -cpu type,feat=3D[on=
|off]

that would let us drop custom
  x86_cpu_parse_featurestr,
  ppc_cpu_parse_featurestr,
  sparc_cpu_parse_features

and a bunch of cpu_class_by_name, where almost each target does its
magic conversion of cpu_model to the type (which ranges from various
prefix/suffix shuffling to completely ignoring cpu_model and returning
a fixed cpu type)


> Regards,
> Daniel


