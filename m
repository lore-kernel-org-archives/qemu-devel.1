Received: from eggs.gnu.org ([2001:4830:134:3::10]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e072E-0000en-FW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e072A-0000eH-Q6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e072A-0000cB-Is
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:21:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EE977F41C
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 14:21:53 +0000 (UTC)
Date: Thu, 5 Oct 2017 15:21:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171005142149.GE2556@work-vm>
References: <20171005105157.10831-1-dgilbert@redhat.com>
	<20171005105157.10831-4-dgilbert@redhat.com>
	<19c477ab-a3dc-a994-905b-7a8d01298a76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <19c477ab-a3dc-a994-905b-7a8d01298a76@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 3/5] hmp-commands-info: Fix "info
 rocker-FOO" misspellings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 05/10/2017 12:51, Dr. David Alan Gilbert (git) wrote:
> > From: Markus Armbruster <armbru@redhat.com>
> >=20
> > Screwed up in commit da76ee7.
>=20
> Let me introduce you to these two aliases:
>=20
>         whatis =3D "show -s --pretty=3D'tformat:%h (\"%s\", %cd)' --dat=
e=3Dshort"
>         pwhatis =3D "show -s --pretty=3D'tformat:%h, \"%s\", %cd' --dat=
e=3Dshort"
>=20
> $ git whatis da76ee7
> da76ee76f7 ("hmp-commands-info: move info_cmds content out of monitor.c=
", 2015-09-16)
>=20
> pwhatis is more appropriate if you are including the commit at the end
> of a parenthetical remark, like
>=20
>    ... (see commit message for 53ec73e, "block: Use bdrv_drain to
>    replace uncessary bdrv_drain_all", 2015-07-07).

Ah well, that was just Markus's message; personally I'd
uses a=20
Fixes: da76ee7

then we've got a chance of automation.

Dave

> Paolo
>=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Message-Id: <20171002134538.23332-2-armbru@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
