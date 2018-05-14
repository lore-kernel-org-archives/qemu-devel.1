Received: from eggs.gnu.org ([2001:4830:134:3::10]:53100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fI9rI-0005HQ-Km
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fI9rE-0001FK-Nm
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:33:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fI9rE-0001ES-IS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:33:28 -0400
Date: Mon, 14 May 2018 10:33:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180514093320.GI29495@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180511224823.GR13350@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511224823.GR13350@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Requiring Python 2.7+ (was Re: [PATCH 0/3]
 Document intent for supported build platforms and bump min glib to 2.42)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, May 11, 2018 at 07:48:23PM -0300, Eduardo Habkost wrote:
> On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> [...]
> > Based on that doc and https://repology.org/metapackage/glib/versions,
> > I identified that we could feasibly set min glib to 2.42. Note that
> > this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
> > 2010 so that's reasonable to drop IMHO). It would still cover 2 major
> > Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
> > 14.04). This min glib lets us remove almost all our compat code.
>=20
> If we're dropping RHEL-6, is there anything else blocking us from
> bumping the minimum required Python versino to 2.7?
>=20
> From the wording on patch 1/3, it looks like we will drop support
> for SLES-11 too?

Yes, that is correct.

py27 seems reasonable to me, assuming none of Peter's build machines
are stuck on 2.6


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
