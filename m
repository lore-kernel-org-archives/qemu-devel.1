Received: from eggs.gnu.org ([2001:4830:134:3::10]:45294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dNRKG-0003gx-4n
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dNRKC-0000IC-TX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dNRKC-0000GT-Nt
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:08:40 -0400
Date: Tue, 20 Jun 2017 23:08:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170620220830.GA12749@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.121ea9b14e06a8c4e19f8a16ed6e963e8310c301.1497458933.git-series.knut.omang@oracle.com>
	<8705c71efd97770eb26432da4d72ead13d83a49e.1497458933.git-series.knut.omang@oracle.com>
	<20170616144157.GH25765@redhat.com>
	<1497992323.16004.1.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497992323.16004.1.camel@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] tests: Add test-listen - a stress
 test for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 20, 2017 at 10:58:43PM +0200, Knut Omang wrote:
> On Fri, 2017-06-16 at 15:41 +0100, Daniel P. Berrange wrote:
> > On Wed, Jun 14, 2017 at 06:53:51PM +0200, Knut Omang wrote:
> > > +static void listen_compete(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0listen_compete_nthr(true, 200, 5920, 300);
> > > +}
> > > +
> > > +static void listen_serial(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0listen_compete_nthr(false, 200, 6300, 300)=
;
> > > +}
> > > +
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0g_test_init(&argc, &argv, NULL);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0g_test_add_func("/socket/listen-serial", l=
isten_serial);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0g_test_add_func("/socket/listen-compete", =
listen_compete);
> >=20
> > Not all our CI systems have network access. You'll want todo a check =
for
> > access first, and exit if not available. See check_protocol_support()=
 in
> > test-io-channel-socket.c for example.
>=20
> Will do=C2=A0
> - maybe these functions could be made part of the test framework to avo=
id
> duplication?

Sure, pulling the code out into a common helper file is a fine idea.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
