Received: from eggs.gnu.org ([2001:4830:134:3::10]:37975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daL75-0004yR-I2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daL72-0003LF-Q7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daL72-0003KZ-Jw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 987527F405
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:08:23 +0000 (UTC)
Date: Wed, 26 Jul 2017 13:08:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726120819.GH7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
	<85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 26, 2017 at 07:02:48AM -0500, Eric Blake wrote:
> On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> > Add multimedia keys to QKeyCodes and to the keymaps.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  ui/input-keymap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  qapi-schema.json  | 17 ++++++++++++++++-
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> > +++ b/qapi-schema.json
> > @@ -4843,6 +4843,16 @@
> >  # @henkan: since 2.9
> >  # @yen: since 2.9
> >  #
> > +# @sleep: since 2.10
> > +# @wake: since 2.10
> > +# @audio*: since 2.10
> > +# @volume*: since 2.10
> > +# @mediaselect: since 2.10
> > +# @mail: since 2.10
> > +# @calculator: since 2.10
> > +# @computer: since 2.10
> > +# @ac_*: since 2.10
> 
> Borderline between bug-fix and new feature (arguing that the bug is that
> we don't represent all keys).  Does this need to be 2.11 instead?

It is really fixing a bug introduced in the PS2 driver in 2.8.0.  It
roundtrips via QKeyCode now, so any key where there is an AT Set 1
scancode defined, but for which we lack a QKeyCode can't be sent to
guests since QEMU 2.8.0 onwards.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
