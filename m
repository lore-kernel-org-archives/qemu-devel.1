Received: from eggs.gnu.org ([2001:4830:134:3::10]:34516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8S6r-0002mj-Gd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8S6l-0002id-HQ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8S6l-0002h2-De
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBEA48DC27
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 15:01:19 +0000 (UTC)
Date: Tue, 17 Apr 2018 16:01:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180417150114.GI15421@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
	<87efjeaqd2.fsf@dusky.pond.sub.org>
	<20180417140540.GD15421@redhat.com>
	<21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com>
	<87po2x6gz1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po2x6gz1.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, Apr 17, 2018 at 04:32:50PM +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 17/04/2018 16:05, Daniel P. Berrang=C3=A9 wrote:
> >>> For what it's worth, my "[RFC PATCH 00/32] Command line QAPIficatio=
n"
> >>> replaces the original parsing art by getopt_long_only().
> >>>
> >>> Completing that work will take some time, but once it's done, we ca=
n
> >>> (and I think we should) prefer double-dash for consistency.
> >> Since our existing parser accepts single & double-dash already, is i=
t
> >> worth explicitly deprecating single-dash usage right now. So that wh=
en
> >> your code comes along ready to merge, we're already able to say
> >> "i told you so" and drop single-dash support at that same time.
> >
> > Serious questions: is _anyone_ of you actually using double-dash supp=
ort
> > in daily invocations of QEMU?
>=20
> I use both.  I readily concede that people familiar with QEMU probably
> use single dash a lot more than double dash.  I don't think we should
> get rid of single dash, unless we decide to bite the bullet and clean u=
p
> our command line without regard for backward compatibility, as Thomas
> proposed elsewhere in this thread, and others proposed before, multiple
> times.
>=20
> I don't entertain the idea of compatibility breaks lightly.  But our
> command line is genuinely nasty.  The closer you look, the nastier.

FWIW, I misread your earlier mail in this thread. I read it as 'getopt_lo=
ng'
rather than 'getopt_long_only', so was assuming your getopt conversion
implied dropping the single-dash long form and allowing us to have distin=
ct
single-letter short options with single-dash like sane apps do !

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
