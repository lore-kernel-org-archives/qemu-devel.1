Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93FC04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB5821670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB5821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPrm-0002jl-8N
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:20:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPpo-0001PR-N8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPiG-0006GE-K8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLPiG-0006FX-Bf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861563084032
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:10:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 453C6756D8;
	Tue, 30 Apr 2019 10:10:08 +0000 (UTC)
Date: Tue, 30 Apr 2019 11:10:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190430101006.GA6818@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
	<20190424082652.GC28615@redhat.com>
	<20190424182036.GH18406@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424182036.GH18406@habkost.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 30 Apr 2019 10:10:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mprivozn@redhat.com, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430101006.rW0h4G_ECpFpyUW-AjAWaw0Cd8ecnaLe79JmmUmLbDA@z>

On Wed, Apr 24, 2019 at 03:20:36PM -0300, Eduardo Habkost wrote:
> On Wed, Apr 24, 2019 at 09:26:52AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Apr 23, 2019 at 06:22:44PM -0300, Eduardo Habkost wrote:
> > > This struct will be used to represent support and deprecation
> > > status of QEMU features.
> > >=20
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  qapi/common.json | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/qapi/common.json b/qapi/common.json
> > > index 99d313ef3b..b59d0dc66b 100644
> > > --- a/qapi/common.json
> > > +++ b/qapi/common.json
> > > @@ -193,3 +193,27 @@
> > >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> > >               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> > >               'x86_64', 'xtensa', 'xtensaeb' ] }
> > > +
> > > +##
> > > +# @SupportStatusInfo:
> > > +#
> > > +# Information on support status of a given feature
> > > +# (e.g. machine type)
> > > +#
> > > +# @deprecated: if true, the given feature is deprecated and may be=
 removed
> > > +#              in future versions of QEMU according to the QEMU de=
precation
> > > +#              policy.
> > > +#
> > > +# @status-message: Human readable message describing support statu=
s
> > > +#                  of the feature.
> > > +#
> > > +# @suggested-alternative: Optional.  Suggested alternative for a d=
eprecated
> > > +#                         feature.  For machine types, this should=
 be the name
> > > +#                         of an available machine-type.
> > > +#
> > > +# Since: 4.1
> > > +##
> > > +{ 'struct': 'SupportStatusInfo',
> > > +  'data': { 'deprecated': 'bool',
> > > +            '*status-message': 'str',
> > > +            '*suggested-alternative': 'str' } }
> >=20
> > I see status-message has to be optional, since you're embedding the
> > struct into another struct and want deprecated=3D=3Dfalse by default.
> >=20
> > I'd be inclined to change it to embed a pointer to the struct and
> > drop the deprecated field, and make both status-message and
> > suggested-alternative be mandatory. ie a struct  "DeprecationInfo"=20
> > the pointer to which is NULL if not deprecated.
>=20
> That could be a simple solution if we were sure we would only
> track deprecation info.  But I would like us to track additional
> support status on that struct eventually.

I've no objection to expanding it to capture other info - we'll
want to change the 'deprecated' field to an enum though. Also,
in some cases there won't be any real alternative so lets just
call it 'hint' instead. How about

    { 'enum':  "SupportStatus",
      'data': { 'production',  # Secure for use in hostile production env
                'development', # No security guarentee, friendly dev only
		'deprecated',  # To be removed in the future
    } }

    { 'struct': "SupportStatusInfo",
       'data': { 'status': 'SupportStatus',
                 '*info': 'str',
		 '*hint': 'str' } }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

