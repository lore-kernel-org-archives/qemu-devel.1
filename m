Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqO99-0006gM-5t
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqO94-00025k-9Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqO94-00023R-3I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:36:50 -0400
Date: Fri, 8 Sep 2017 19:36:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908183643.GI2836@work-vm>
References: <20170908155359.27952-1-dgilbert@redhat.com>
	<26a00723-027c-4445-0590-d50739dec557@amsat.org>
	<20170908162201.GC2836@work-vm>
	<7c4ca224-2577-0ef6-6e19-9760dd58c723@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7c4ca224-2577-0ef6-6e19-9760dd58c723@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Add explanation for hostfwd parsing
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> On 09/08/2017 01:22 PM, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> > > Hi David,
> > >=20
> > > On 09/08/2017 12:53 PM, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >=20
> > > > e.g.
> > > > ./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=3D=
vnet,hostfwd=3D:555.0.0.0:0-:22'
> > > > qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:555.0.0.0:0=
-:22: Invalid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)
> > > >=20
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >    net/slirp.c | 13 ++++++++++++-
> > > >    1 file changed, 12 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/net/slirp.c b/net/slirp.c
> > > > index 01ed21c006..d87664d42e 100644
> > > > --- a/net/slirp.c
> > > > +++ b/net/slirp.c
> > > > @@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, cons=
t char *redir_str,
> > > >        char buf[256];
> > > >        int is_udp;
> > > >        char *end;
> > > > +    const char *fail_reason =3D "";
> > >=20
> > > Isn't it better not initialize this? So if one add a new failed syn=
tax case
> > > the build with abort with -Werror=3Duninitialized
> >=20
> > I never quite trust compilers to spot it or not-moan even though
> > every route to failure will have set it.
>=20
> I see, what about:
>=20
> const char *fail_reason =3D "Unknown reason";

I could, but you're right that I shouldn't miss any, and
'Unknown Reason' doesn't tell the user any more than no message.

Dave

> >=20
> > > Anyway:
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
