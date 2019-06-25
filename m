Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AEEC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B9E20883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B9E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpmd-0003Zl-A3
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfpk2-0002aw-4o
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfpk0-0000lS-KW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfpk0-0000jE-DG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:00:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E26E7FDEC
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 18:00:23 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 332F96014E;
 Tue, 25 Jun 2019 18:00:20 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:00:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190625180019.GU1862@habkost.net>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-4-ehabkost@redhat.com>
 <20190625161533.GJ3139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190625161533.GJ3139@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 25 Jun 2019 18:00:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] qmp: Add "alias-of" field to
 query-cpu-definitions
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 05:15:33PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 25, 2019 at 02:00:05AM -0300, Eduardo Habkost wrote:
> > Management software will be expected to resolve CPU model name
> > aliases using the new field.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > ---
> >  qapi/target.json | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/target.json b/qapi/target.json
> > index 1d4d54b600..0197c7962c 100644
> > --- a/qapi/target.json
> > +++ b/qapi/target.json
> > @@ -475,6 +475,12 @@
> >  #            to introspect properties configurable using -cpu or -gl=
obal.
> >  #            (since 2.9)
> >  #
> > +# @alias-of: Name of CPU model this model is an alias for.  The targ=
et of the
> > +#            CPU model alias may change depending on the machine typ=
e.
> > +#            Management software is supposed to translate CPU model =
aliases
> > +#            in the VM configuration, because aliases may stop being
> > +#            migration-safe in the future (since 4.1)
> > +#
> >  # @unavailable-features is a list of QOM property names that
> >  # represent CPU model attributes that prevent the CPU from running.
> >  # If the QOM property is read-only, that means there's no known
> > @@ -498,7 +504,8 @@
> >              '*migration-safe': 'bool',
> >              'static': 'bool',
> >              '*unavailable-features': [ 'str' ],
> > -            'typename': 'str' },
> > +            'typename': 'str',
> > +            '*alias-of' : 'str' },
> >    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGE=
T_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>=20
> IIUC, this means that data for a "Haswell" CPU model will now report
> "alias-of": "Haswell-NNN"  (for some arbitrary NNN which may change
> at will in any release).

That's correct.

--=20
Eduardo

