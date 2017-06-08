Received: from eggs.gnu.org ([2001:4830:134:3::10]:46775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIxee-0001bj-3b
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIxed-0005PD-CA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIxed-0005Og-7J
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:15 -0400
Message-ID: <1496929152.29761.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 08 Jun 2017 15:39:12 +0200
In-Reply-To: <1496927734-29174-4-git-send-email-owen.smith@citrix.com>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
	<1496927734-29174-4-git-send-email-owen.smith@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/4] ui/input: Add activate/remove for
 keyboard handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 7159747..fbe1ce7 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -142,6 +142,18 @@ QEMUPutKbdEntry
> *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func, void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return entry;
> =C2=A0}
> =C2=A0
> +void qemu_activate_kbd_event_handler(QEMUPutKbdEntry *entry)

Please don't add new code to input-legacy.c please.

Switch your code to use the new qemu_input_handler_*() functions
directly instead.

cheers,
  Gerd
