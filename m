Received: from eggs.gnu.org ([2001:4830:134:3::10]:54252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMs6-0004w9-Sv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMs1-0001LJ-L6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:05:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMs1-0001Ko-Ex
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:05:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-16-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 17:05:31 +0200
In-Reply-To: <20180627163551.31610-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:35:51 +0200")
Message-ID: <874lhg8imc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/15] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_SPICE) in generated code, and adjust the
> qmp/hmp code accordingly.
>
> query-qmp-schema no longer reports the command/events etc as
> available when disabled at compile time.
>
> Commands made conditional:
>
> * query-spice
>
>   Before the patch, the command for !CONFIG_SPICE is unregistered. It
>   will fail with the same error.
>
> Events made conditional:
>
> * SPICE_CONNECTED, SPICE_INITIALIZED, SPICE_DISCONNECTED,
>   SPICE_MIGRATE_COMPLETED
>
> Add TODO for conditional SPICE chardevs, delayed until the supports
> for conditional members lands.
>
> No HMP change, the code was already conditional.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
