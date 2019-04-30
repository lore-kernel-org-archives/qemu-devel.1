Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPq5-0001Py-KO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPcB-0002VD-UE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLPcB-0002TK-26
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 622E380461
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:03:52 +0000 (UTC)
Date: Tue, 30 Apr 2019 11:03:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190430100345.GJ3716@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
	<b8a8e3fb-281a-7252-4899-859959a97a1d@redhat.com>
	<20190425174208.GO18406@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425174208.GO18406@habkost.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, mprivozn@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, Apr 25, 2019 at 02:42:08PM -0300, Eduardo Habkost wrote:
> On Thu, Apr 25, 2019 at 11:20:58AM -0300, Wainer dos Santos Moschetta wrote:
> > Hi Eduardo,
> > 
> > 
> > On 04/23/2019 06:22 PM, Eduardo Habkost wrote:
> > > This struct will be used to represent support and deprecation
> > > status of QEMU features.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >   qapi/common.json | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/qapi/common.json b/qapi/common.json
> > > index 99d313ef3b..b59d0dc66b 100644
> > > --- a/qapi/common.json
> > > +++ b/qapi/common.json
> > > @@ -193,3 +193,27 @@
> > >                'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> > >                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> > >                'x86_64', 'xtensa', 'xtensaeb' ] }
> > > +
> > > +##
> > > +# @SupportStatusInfo:
> > > +#
> > > +# Information on support status of a given feature
> > > +# (e.g. machine type)
> > > +#
> > > +# @deprecated: if true, the given feature is deprecated and may be removed
> > > +#              in future versions of QEMU according to the QEMU deprecation
> > > +#              policy.
> > 
> > Eventually management software will need the know the QEMU version the
> > feature is planed for removal. So makes sense to include a field to capture
> > that information as well or do you expect it to be added (as a good
> > practice) in the 'status-message'?
> 
> If we really want to provide extra information like version
> numbers, adding a separate field sounds better than using
> status-message.
> 
> But I'm not sure we really want to include this amount of detail
> in the API.  Mentioning explicit version numbers could make
> things more complex for downstream distributions of QEMU that
> include backports and/or have a different deprecation policy.
> 
> I'd like to hear opinions from others.

Yeah, I'm *not* in favour of mentioning any version number in this. Our
"2 cycle" deprecation rule is more of a guideline than a strict rule.
It can be extended if we find some blocking problem that makes removal
more painful than expected.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
