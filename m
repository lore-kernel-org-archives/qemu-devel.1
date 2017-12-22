Received: from eggs.gnu.org ([2001:4830:134:3::10]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPCy-00035a-T5
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPCu-00014j-SG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:00 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eSPCu-00013d-Kl
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:25:56 -0500
Received: by mail-lf0-x241.google.com with SMTP id y78so26251562lfd.1
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 07:25:56 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Fri, 22 Dec 2017 17:25:28 +0200
Message-Id: <20171222152531.1849-1-miika9764@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] input: add keys and mouse buttons to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, Miika S <miika9764@gmail.com>

This patchset adds some missing keys and mouse buttons to
hw/input/virtio-input-hid.c.

On a JIS keyboard such as this one (106/109 - JIS)
https://upload.wikimedia.org/wikipedia/commons/b/b2/Physical_keyboard_layouts_comparison_ANSI_ISO_KS_ABNT_JIS.png
the keys are located as follows:
muhenkan: left of spacebar
henkan: right of spacebar
katakanahiragana: right of henkan
compose: the same as menu but the existing one didn't work
ro: left of right shift
    (this produces the same key code as the key right of left shift on
    102/105 ISO keyboard in the linked picture and consequently this
    patch also adds support for those keyboards)
yen: left of backspace

The mouse buttons "side" and "extra" are the ones you use to go to the
previous and next page in modern web browsers such as Firefox and
Chrome.

The last patch fixes mouse wheel event sent for both button up and down
by only forwarding the event when the button state is down.


Miika S (3):
  input: add missing JIS keys to virtio input
  input: add mouse side buttons to virtio input
  input: virtio: don't send mouse wheel event twice

 hw/input/virtio-input-hid.c | 15 +++++++++++++--
 qapi/ui.json                |  5 ++++-
 ui/keycodemapdb             |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.15.1
