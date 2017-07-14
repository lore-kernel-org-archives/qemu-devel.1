Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0an-0006Te-0j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0ai-0006bv-UW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dW0ai-0006YN-LW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:25:08 -0400
Date: Fri, 14 Jul 2017 14:25:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714132503.GB17616@stefanha-x1.localdomain>
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
	<20170710124025.GE14195@stefanha-x1.localdomain>
	<5fd4160d-87ca-6cb1-1a32-1d4debf34d76@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <5fd4160d-87ca-6cb1-1a32-1d4debf34d76@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 04:01:09PM +0800, Wang Dong wrote:
> On 07/10/2017 08:40 PM, Stefan Hajnoczi wrote:
> > On Mon, Jul 10, 2017 at 01:24:23PM +0800, Xie Changlong wrote:
> > > =E5=9C=A8 7/9/2017 5:57 PM, Wang Dong =E5=86=99=E9=81=93:
> > > > Hi,
> > > >=20
> > > > I am new to QEMU. But I got some problem so that  I want to figure =
it out.
> > > >=20
> > > > So I try to debug qemu to see what happened.
> > > >=20
> > > > And I found trace framework. I think this will help me understand t=
he
> > > > point.
> > > >=20
> > > > So I compiled qemu with option:
> > > >=20
> > > > ## *--enable-trace-backends=3Dsimple*
> > > >=20
> > > > And did as the docs/tracing.txt tell. But when I execute the example
> > > > command in it, nothing just happens.
> > > >=20
> > > > *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace fi=
le
> > > > produced by qemu)
> > > > I am not sure what happened. Just ask this.
> > > > Any clue will be appreciated. Thanks in advance.
> > > > *
> > > >=20
> > > Did you set *trace-event*? I've encountered this issue in the past :)
> > > (qemu) help trace-event
> > > trace-event name on|off -- changes status of a specific trace event
> > > (qemu) info trace-events
> > Yes, you need to enable specific trace events that you are interested
> > in.  'trace-event' does that from the QEMU monitor at runtime.  If you'd
> > rather keep a file with a list of events to enable:
> >=20
> >    $ echo bdrv_aio_readv   > /tmp/events
> >    $ echo bdrv_aio_writev >> /tmp/events
> >    $ qemu -trace events=3D/tmp/events ... # your normal QEMU invocation
> >=20
> > It's hard to know what is missing without seeing your QEMU command-line
> > and monitor commands you used.
> >=20
> > Stefan
>=20
> I thought the example in doc was enabled by default.
>=20
> Thanks for your reply. Below is my command:
> When to compile:
>=20
> ./configure --enable-debug --enable-trace-backends=3Dsimple
>=20
> $ echo bdrv_aio_readv   > /tmp/events
> $ echo bdrv_aio_writev >> /tmp/events
>=20
>=20
> qemu [...]
>=20
> -chardev socket,id=3Dmon1,host=3Dlocalhost,port=3D7777,server,nowait \
> -mon chardev=3Dmon1,mode=3Dcontrol,pretty=3Don \
> -trace events=3D/tmp/events
>=20
>=20
> Did I miss something?

Recent QEMU versions do not have bdrv_aio_readv/bdrv_aio_writev trace
events, so you may not get any output.

Which events do you actually want to trace?

I will update the example in docs/devel/tracing.txt with trace events
that are more likely to be triggered.

Stefan

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaMYvAAoJEJykq7OBq3PIzf8IAIkDqsWrfy8lr+orECCROij/
a/DdcEUX+KFGEGY3gIv9jou7q/TIbH40XtowSqv2Dmtwy7ii2lQ9KrPEvi7PI5qg
SE7d2mJOvcKgwB0PJbxuxoEPTH5zto2Q44aRa1oPgcjegqhOstUm6uwCwhMUKbSH
MTfG6OgctX8GopVAcpurbiIiqPBgVIYO1pWQOnF7CQANgBJdw1jLWQZnPzOw/RK/
DMIpcpS+bwLtL4BylYwnC092PgYseCbeacMGuSzDZQLFmjAPQwqJsnsSqBWEt/0q
TZ8uj7JX++69URCce5UCupKJ3m8awQilQJS5BbcOo4rHV5mc2CwppWGanVVIaNk=
=cOmf
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
