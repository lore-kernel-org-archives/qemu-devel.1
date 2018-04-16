Received: from eggs.gnu.org ([2001:4830:134:3::10]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1f7zsf-0000B6-Ra
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1f7zsf-0005lu-1H
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:52:57 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:39938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <debby83729@gmail.com>)
	id 1f7zse-0005lO-O9
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:52:56 -0400
Received: by mail-wr0-x232.google.com with SMTP id v60so19727572wrc.7
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:52:56 -0700 (PDT)
MIME-Version: 1.0
From: Eva Chen <debby83729@gmail.com>
Date: Mon, 16 Apr 2018 16:52:34 +0800
Message-ID: <CAG0V3WRdK+p-qo9NmnKkKT6kMNBJBxj9vNuYBSzX7zrZU8FGiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Let event loop use non-default GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

It seems that AIO use global default GMainContext by
*g_main_context_default()*.
I want to replace all default GMainContext into another GMainContext by
*g_main_context_new()*, but I have no idea when and where to add
*g_main_context_new()*.

It should be only created new GMainContext once, then others use this new
GMainContext.
But it's hard to create a global variable that will not cause redefine
during make

Is there any suggestion which data structure is suitable for adding a
GMainContext?
or is there any advice for replacing default GMainContext?

The reason for replacing default GMainContext is that I simultaneously run
two qemu, called A and B, in threads. However, these two QEMU using the
same default GMainContext causes A QEMU to handle the event from B QEMU,
and run B's handler instead of A's handler.

I will be grateful for any help, thanks.

Sincerely,
Eva



=E2=80=8B
