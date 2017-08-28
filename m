Received: from eggs.gnu.org ([2001:4830:134:3::10]:50989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nathan.gauer@gmail.com>) id 1dmRnl-00077B-6O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nathan.gauer@gmail.com>) id 1dmRnk-0003eT-8k
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:42:33 -0400
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nathan.gauer@gmail.com>)
	id 1dmRnk-0003dh-3Z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:42:32 -0400
Received: by mail-vk0-x22d.google.com with SMTP id q189so4968171vke.4
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 14:42:30 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Nathan_Gau=C3=ABr?= <nathan.gauer@gmail.com>
Date: Mon, 28 Aug 2017 23:42:09 +0200
Message-ID: <CAP4Y0TJ=pd+AdeY_5uuDaaixpA5PK4eq8C++vZss6-cgBn+6uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [GSoC] OpenGL support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org

Hi all,

I'm Nathan Gau=C3=ABr, a GSoC 17 student.
My goal was to provide a PoC OpenGL driver for Windows.

Status:

This project contains two main parts: the OpenGL driver (ICD) and the
kernel driver (DOD).
An Escape handler had to be created on the current DOD driver, and is
now merged on the spice repo.
The ICD contains a basic state-tracker, supporting some OpenGL
commands like glClear, glDrawArray, and contexts.
As a result, we can now display some basic OpenGL.

To get a rapid overview of the project, here is a gist:
https://gist.github.com/Keenuts/199184f9a6d7a68d9a62cf0011147c0b

Repositories:

ICD: https://github.com/Keenuts/virtio-gpu-win-icd/tree/master
DOD: https://gitlab.com/spice/virtio-gpu-wddm/virtio-gpu-wddm-dod/tree/mast=
er
VirGL reference: https://github.com/Keenuts/virtio-gpu-documentation/tree/m=
aster

What's left to do:

- Extend the commands supported by the ICD
- Add a real state-tracker with shader support (Mesa)
- Add in kernel resource tracking to prevent lost resources
- Be able to get feedback from VirGL commands

All the best,

--=20
Nathan Gau=C3=ABr
