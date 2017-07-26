Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daM42-000306-Fm
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daM3z-0005eW-Bp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daM3z-0005cH-6K
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:09:19 -0400
Date: Wed, 26 Jul 2017 10:01:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170726130120.GE20793@localhost.localdomain>
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-10-ldoktor@redhat.com>
	<20170725193442.GS2757@localhost.localdomain>
	<a0a70f94-54a4-737e-cd17-478ff2ba854c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a70f94-54a4-737e-cd17-478ff2ba854c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/10] qmp.py: Avoid overriding a
 builtin object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com

On Wed, Jul 26, 2017 at 06:46:30AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 25.7.2017 v 21:34 Eduardo Habkost napsal(a):
> > On Tue, Jul 25, 2017 at 05:09:50PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> >> The "id" is a builtin method to get object's identity and should not=
 be
> >> overridden. This might bring some issues in case someone was directl=
y
> >> calling "cmd(..., id=3Did)" but I haven't found such usage on brief =
search
> >> for "cmd\(.*id=3D".
> >>
> >> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >=20
> > I don't see the benefit of the patch, as the function is very
> > short and unlikely to ever use the id() builtin.  But I am not
> > against it if it will silence code analyzer warnings.
> >=20
> For me the biggest benefit is it decreases the probability of
> someone copying the same "idea" to other pieces of code,
> because, you know, developers are using copy&paste way too
> often.
>=20
> Anyway pylint does complain about this issue. I can either
> ignore it, skip it with an informative comment `# use id for
> backward compatibility pylint: disable=3DW0622` or use this patch
> to fix it properly. I'm inclined towards fixing it (until it
> poisons other parts of the code), you are in favor of ignoring
> it, so let's see whether someone else has another opinion,
> otherwise I'll remove it in v3.

If pylint complains about it, it won't hurt to make it happy.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
