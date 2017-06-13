Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=330a39dd3=owen.smith@citrix.com>)
	id 1dKo8L-0005Hy-Sp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=330a39dd3=owen.smith@citrix.com>)
	id 1dKo8H-0004DP-W1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:53:33 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:9636
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=330a39dd3=owen.smith@citrix.com>)
	id 1dKo8H-0004Cv-Jg
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:53:29 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Tue, 13 Jun 2017 15:01:35 +0000
Message-ID: <f8c381d8dd07408faaac1ebf014c8f46@AMSPEX02CL02.citrite.net>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
	<1496927734-29174-4-git-send-email-owen.smith@citrix.com>,
	<1496929152.29761.3.camel@redhat.com>
In-Reply-To: <1496929152.29761.3.camel@redhat.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

Noted, I have had a look at porting the xenfb input handlers to the

qemu_input_handler_*() functions, and will post an update that combines pat=
ch

3 and 4 of this series.



From: Gerd Hoffmann<mailto:kraxel@redhat.com>
Sent: 08 June 2017 14:39
To: Owen Smith<mailto:owen.smith@citrix.com>; qemu-devel@nongnu.org<mailto:=
qemu-devel@nongnu.org>
Cc: sstabellini@kernel.org<mailto:sstabellini@kernel.org>; Anthony Perard<m=
ailto:anthony.perard@citrix.com>; xen-devel@lists.xenproject.org<mailto:xen=
-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/4] ui/input: Add activate/remove for keyboard handler=
s



diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 7159747..fbe1ce7 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -142,6 +142,18 @@ QEMUPutKbdEntry
> *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func, void *opaque)
>      return entry;
>  }
>
> +void qemu_activate_kbd_event_handler(QEMUPutKbdEntry *entry)

Please don't add new code to input-legacy.c please.

Switch your code to use the new qemu_input_handler_*() functions
directly instead.

cheers,
  Gerd
