Received: from eggs.gnu.org ([2001:4830:134:3::10]:32932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cVkLh-0004EM-8U
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cVkLf-0002gO-5Z
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:32:17 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1cVkLf-0002fg-0E
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:32:15 -0500
Received: by mail-vk0-x22e.google.com with SMTP id t8so97613776vke.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:32:13 -0800 (PST)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Mon, 23 Jan 2017 14:32:12 -0500
Message-ID: <CAF++6APW69OBEzfUaWXK-kXLY5euu8aJjvFrYzwFT1tes-W=gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] changeset b0cb0a66d broken - missing
 QEMU_OPTION_enable_hax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Vincent Palatin <vpalatin@chromium.org>

Changeset fails to compile:

qemu/vl.c:3683:18: error: =E2=80=98QEMU_OPTION_enable_hax=E2=80=99 undeclar=
ed (first use in
this function)
             case QEMU_OPTION_enable_hax:
                  ^
I assume that there is details in

./qemu-options.def
./qemu-options.hx

that were not included with the commit?

http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Db0cb0a66d6d535112aa513568e=
f21dcb1ad283ed

-Jim
