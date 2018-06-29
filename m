Received: from eggs.gnu.org ([2001:4830:134:3::10]:38583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joe@perches.com>) id 1fZ1Df-0001Nm-2k
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joe@perches.com>) id 1fZ1Dc-0004Ui-14
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:46:19 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:48574
	helo=smtprelay.hostedemail.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joe@perches.com>) id 1fZ1Db-0004Pl-SY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:46:15 -0400
Message-ID: <9376a63ed1790a79dadaaf0aac72455f6e7e2942.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 29 Jun 2018 14:46:09 -0700
In-Reply-To: <9a30c2d7-b6b7-c6e9-1c70-0fd4a90bca0c@redhat.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-5-f4bug@amsat.org>
	<9a30c2d7-b6b7-c6e9-1c70-0fd4a90bca0c@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/46] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Pasi Savanainen <pasi.savanainen@nixu.com>, =?ISO-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On Fri, 2018-06-29 at 15:41 -0500, Eric Blake wrote:
> On 06/25/2018 07:41 AM, Philippe Mathieu-Daud=E9 wrote:
> > Do not match the IEC binary prefix as camelcase typedefs.
> >=20
> > This fixes:
> >=20
> >      ERROR: "foo * bar" should be "foo *bar"
> >      #310: FILE: hw/ppc/ppc440_uc.c:564:
> >      +        size =3D 8 * MiB * sh;
> >      total: 1 errors, 0 warnings, 433 lines checked

Does the linux kernel use these?
I don't believe so.

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -242,6 +242,7 @@ our $UTF8	=3D qr{
> >   # There are still some false positives, but this catches most
> >   # common cases.
> >   our $typeTypedefs =3D qr{(?x:
> > +        (?![KMGTPE]iB)                      # IEC binary prefix (do =
not match)
