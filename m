Received: from eggs.gnu.org ([2001:4830:134:3::10]:47798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dnQbQ-0001yF-IU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dnQbP-0004d2-GT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dnQbP-0004cF-AA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:37:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 884F3C0587E5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:37:49 +0000 (UTC)
Date: Thu, 31 Aug 2017 10:37:48 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1035692873.6569490.1504190268397.JavaMail.zimbra@redhat.com>
In-Reply-To: <87mv6fiztt.fsf@dusky.pond.sub.org>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-13-marcandre.lureau@redhat.com>
	<87ziahfd06.fsf@dusky.pond.sub.org>
	<87mv6fiztt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/14] qlit: improve QLit list vs qlist
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Use QLIST_FOREACH_ENTRY() to simplify the code and break earlier.
> >>
> >> Check that the QLit list has the same size as the qlist, this should
> >> ensure that we have an exact match when iterating over qlist for
> >> comparing the elements.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> I'm updating the commit message so it continues to match the previous
> commit's message:
>=20
>     qlit: Tighten QLit list vs QList comparison
>=20
>     We check that all members of the QLit list are also in the QList.  We
>     neglect to check the other direction.  Fix that.
>=20
>     While there, use QLIST_FOREACH_ENTRY() to simplify the code and break
>     the loop on the first mismatch.
>=20
> Hope that's okay with you.

Works for me, thanks a lot.
