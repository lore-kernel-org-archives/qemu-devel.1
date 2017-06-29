Received: from eggs.gnu.org ([2001:4830:134:3::10]:53152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQbz3-00047c-P1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQbz2-0004lw-Fd
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQbz2-0004kP-95
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:07:56 -0400
Date: Thu, 29 Jun 2017 17:07:49 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629160749.GH32167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Jun 29, 2017 at 05:46:26PM +0200, Thomas Huth wrote:
> On 29.06.2017 17:06, Paolo Bonzini wrote:
> > 
> > 
> > On 29/06/2017 10:46, Thomas Huth wrote:
> >>> Patches 7,8 are the removal, marked RFC... let's debate!
> >> ... but NACK for a direct removal. Common sense is to make obsolete
> >> features as deprecated first and then wait for 2 public releases before
> >> the final removal, so that users still have a chance to speak up in case
> >> they still need the feature and are willing to maintain it.
> > 
> > I think this is a slightly different case than what is in
> > http://wiki.qemu.org/Features/LegacyRemoval.
> > 
> > TCI is enabled only with a specific configure argument if your machine
> > is not supported by TCG.  This would break _build_ configurations, not
> > user configurations.  It's a remote possibility that users are building
> > their own QEMU, with TCI enabled, to work around a TCG bug.  So we can
> > be more speedy in removing the code.
> 
> You never know ... it's unlikely, but there might be people around who
> run configure with "--enable-tcg-interpreter" on purpose. And why the
> hurry for removing this? It's been around in the current shape since
> years, so waiting for two more releases does not hurt, does it?

The flipside is that even if we delete it, if someone does suddenly
care, the code is still there in git & easy to undelete again. Given
that we believe there are zero users, it is known broken in many
ways, and TCG provides a working alternative, I don't see a strong
reason to not just kill it right away. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
