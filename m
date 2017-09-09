Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dqm4Z-0003oG-0D
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dqm4V-0004zF-RV
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:09:46 -0400
Received: from mta-out.u-bordeaux.fr ([147.210.215.83]:37622
	helo=v-zimmta03.u-bordeaux.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dqm4V-0004yD-K4
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:09:43 -0400
Date: Sat, 9 Sep 2017 22:09:40 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170909200940.ufht7xmckhtzcvrb@var.youpi.perso.aquilenet.fr>
References: <20170908155359.27952-1-dgilbert@redhat.com>
	<26a00723-027c-4445-0590-d50739dec557@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26a00723-027c-4445-0590-d50739dec557@amsat.org>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, jan.kiszka@siemens.com

Philippe Mathieu-Daud=C3=A9, on ven. 08 sept. 2017 13:19:56 -0300, wrote:
> Hi David,
>=20
> On 09/08/2017 12:53 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > e.g.
> > ./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=3Dvne=
t,hostfwd=3D:555.0.0.0:0-:22'
> > qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:555.0.0.0:0-:22=
: Invalid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   net/slirp.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 01ed21c006..d87664d42e 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, const ch=
ar *redir_str,
> >       char buf[256];
> >       int is_udp;
> >       char *end;
> > +    const char *fail_reason =3D "";
>=20
> Isn't it better not initialize this? So if one add a new failed syntax =
case
> the build with abort with -Werror=3Duninitialized
>=20
> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Applied to my tree, thanks!

(I have put Unknown reason there, otherwise the message would have
oddly-looking "()" )

Samuel
