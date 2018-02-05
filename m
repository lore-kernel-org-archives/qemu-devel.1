Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eihjP-00036j-UE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eihjK-0007Qg-U7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:26:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eihjK-0007Q3-Nl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:26:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-13-armbru@redhat.com>
	<CAMxuvazW5+FzsFPq2+=jyktw+WMabKw0cMtM4N40JRLTz=C_iA@mail.gmail.com>
Date: Mon, 05 Feb 2018 15:26:38 +0100
In-Reply-To: <CAMxuvazW5+FzsFPq2+=jyktw+WMabKw0cMtM4N40JRLTz=C_iA@mail.gmail.com>
	(Marc-Andre Lureau's message of "Mon, 5 Feb 2018 14:45:26 +0100")
Message-ID: <87y3k7v7fl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 12/21] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

Marc-Andre Lureau <mlureau@redhat.com> writes:

> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> It's not obvious the motivation behind this change (beside behind more
> elegant), but

At one point during my search for a good way to record includes in the
parse tree, updating .exprs in two places got in the way, so I cleaned
it up.  I guess it's not in the way of the solution I eventually chose,
but I consider it a worthwhile little cleanup on its own.

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
