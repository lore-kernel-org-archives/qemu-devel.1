Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gU7sK-0002s8-4r
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gU7sF-0008I0-9i
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:24:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gU7sF-0008HW-43
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:24:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 450BB58E36
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 10:24:14 +0000 (UTC)
Date: Tue, 4 Dec 2018 10:24:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181204102409.GD20360@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
	<4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com>
	<87wooql7c9.fsf@dusky.pond.sub.org>
	<de1686a3-1981-442d-a82a-704bca834922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de1686a3-1981-442d-a82a-704bca834922@redhat.com>
Subject: Re: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, Dec 03, 2018 at 01:57:13PM -0600, Eric Blake wrote:
> On 12/3/18 1:48 PM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> > 
> > > On 12/3/18 10:30 AM, Max Reitz wrote:
> > > > Hi,
> > > > 
> > > > QMP accepts double keys in dicts without complaining.  The value it is
> > > > using is apparently the last one specified:
> > > 
> > > JSON says it is undefined what happens when a client passes double
> > > keys. We are probably best off if we teach our parser to be strict and
> > > reject doubled keys in QMP as invalid.
> > 
> > Not bug-compatible.  Do we care?
> 
> I don't think so. Such a client was already invoking undefined behavior.
> Relying on first- or last-past-the-post to win is not portable, since JSON
> parsers are allowed to use hash tables with non-deterministic lookups. I
> think erroring out is nicer than silently accepting one thing, especially if
> that might have been different than what the client (incorrectly) expected.
> I'm not even sure that we would want a deprecation period.

Erroring out immediately, without any deprecation period sounds fine
to me, as this is simply a bug fix.

IMHO the ABI/API compatibility stability only applies to things that
are intended behaviour / correct usage.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
