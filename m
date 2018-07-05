Received: from eggs.gnu.org ([2001:4830:134:3::10]:48441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2lz-0005CR-GW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb2lt-0005Nw-9C
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:50:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb2lt-0005M8-43
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:50:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-10-marcandre.lureau@redhat.com>
Date: Thu, 05 Jul 2018 13:49:55 +0200
In-Reply-To: <20180326150916.9602-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 26 Mar 2018 17:08:47 +0200")
Message-ID: <87fu0x9a1o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/38] json: remove useless return value
 from lexer/parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The lexer always returns 0 when char feeding. Furthermore, none of the
> caller care about the return value.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

My intuitive reaction was "how come the lexer can't fail?"  It can, but
it communicates failure by pushing JSON_ERROR to the streamer, not by
having the feed function return an error.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
