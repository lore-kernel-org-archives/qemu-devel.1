Received: from eggs.gnu.org ([2001:4830:134:3::10]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1di0i9-0001Yn-9w
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1di0i4-0002Rz-Eu
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1di0i4-0002RQ-8r
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:58:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E78B119C332
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 15:50:12 +0000 (UTC)
Date: Wed, 16 Aug 2017 11:50:12 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1693347134.2736614.1502898612069.JavaMail.zimbra@redhat.com>
In-Reply-To: <981ecc11-57f4-3f6a-3ee6-d829d60edfb1@redhat.com>
References: <20170802201900.11890-1-eblake@redhat.com>
	<1325195018.65415326.1501711642675.JavaMail.zimbra@redhat.com>
	<981ecc11-57f4-3f6a-3ee6-d829d60edfb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Hi

----- Original Message -----
> On 08/02/2017 05:07 PM, Marc-Andr=C3=A9 Lureau wrote:
>=20
> >>
> >> Rather than leave this untested time-bomb in place, rip it out.
>=20
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> > I think it used to work in a vm (as qemu-ga user), but I don't mind to
> > revert it if we need it back:
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Should this be R-b instead of S-o-b?

correct,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
