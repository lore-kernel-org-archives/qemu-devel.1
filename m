Received: from eggs.gnu.org ([2001:4830:134:3::10]:49873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMaq-0001zh-HN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMan-00061g-FR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:47:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMan-00061E-AP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:47:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-12-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 16:47:43 +0200
In-Reply-To: <20180627163551.31610-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:35:47 +0200")
Message-ID: <87lgas8jg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/15] qapi/events: add #if conditions
 to events
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

> Wrap generated code with #if/#endif using an 'ifcontext' on
> QAPIGenCSnippet objects.
>
> This makes a conditional event's qapi_event_send_FOO() compile-time
> conditional, but its enum QAPIEvent member remains unconditional for
> now. A follow up patch "qapi-event: add 'if' condition to implicit
> event enum" will improve this.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
