Received: from eggs.gnu.org ([209.51.188.92]:59342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmgr7-0004fr-RR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmgr5-0002A3-9x
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:23:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmgr5-00027z-1k
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:23:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A416181129
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 15:23:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190121170434.13592-1-cfergeau@redhat.com>
	<87d0omieea.fsf@dusky.pond.sub.org>
	<20190124124428.GX30040@natto.ory.fergeau.eu>
Date: Thu, 24 Jan 2019 16:23:29 +0100
In-Reply-To: <20190124124428.GX30040@natto.ory.fergeau.eu> (Christophe
	Fergeau's message of "Thu, 24 Jan 2019 13:44:28 +0100")
Message-ID: <871s52dqq6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Christophe Fergeau <cfergeau@redhat.com> writes:

> Hey,
>
> On Thu, Jan 24, 2019 at 10:38:37AM +0100, Markus Armbruster wrote:
>> Christophe Fergeau <cfergeau@redhat.com> writes:
>>=20
>> > This commit adds a qemu_init_logging() helper which calls
>> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
>> > are handled similarly to other QEMU logs. This means they will get a
>> > timestamp if timestamps are enabled, and they will go through the
>> > monitor if one is configured.
>> > This commit also adds a call to qemu_init_logging() to the binaries
>> > installed by QEMU.
>> > glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
>> > glib default log handler.
>> >
>> > At the moment, this change will mostly impact SPICE logging if your
>> > spice version is >=3D 0.14.1. With older spice versions, this is not g=
oing
>> > to work as expected, but will not have any ill effect, so this call is
>> > not conditional on the SPICE version.
>> >
>> > Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>=20
>> Do you expect this to go through my tree?
>
> To be honest, I don't know through whose tree this should go.

The bulk of the patch is in qemu-error.c, which suggests my tree.

>> Hint: if you do, cc'ing me tends to help ;)
>>=20
>> scripts/get_maintainer.pl can be your friend.
>
> I ran it, but it returned a few too many names given that it touches
> files in various subsystems, I was not sure I should cc: everyone.

You were right to doubt.

> Now that I look again, at least "(supporter:Error reporting)" would have
> made sense.
>
> Thanks for noticing this patch without the cc: :)

No problem :)
