Received: from eggs.gnu.org ([2001:4830:134:3::10]:45914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fQD64-0002tW-QM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fQD61-0004bx-Jm
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:04 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:44284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fQD61-0004bk-CF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:38:01 -0400
Received: by mail-io0-x230.google.com with SMTP id g7-v6so3607671ioh.11
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:38:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180605102037.3f54j2ir4aqrvelr@sirius.home.kraxel.org>
Date: Tue, 5 Jun 2018 10:37:58 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <59A7C723-C73D-4FE2-BB35-2F77695AD5D4@gmail.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
	<20180221170820.15365-3-kraxel@redhat.com>
	<78856018-DE4F-42C2-899F-428FE7E55141@gmail.com>
	<20180605102037.3f54j2ir4aqrvelr@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] kbd-state: add hotkey registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org


> On Jun 5, 2018, at 6:20 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> You say the hotkey is a QKeyCode and a modifier key combined. But it =
looks like a single QKeyCode would be supported. I would prefer being =
able to use a single key like F16 to ungrab the mouse. Would that be =
possible here?
>>=20
>> Kbd_state_hotkey_register(kbd, KBD_HOTKEY_GRAB, Q_KEY_CODE_F16, =
KBD_MOD_NONE, KBD_MOD_NONE, KBD_MOD_NONE);
>=20
> Yes, that should work.  I'm working on the series now and then (when I
> find some time), latest state is here:
>=20
> https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/kbd-state
>=20
> cheers,
>  Gerd

Great. I look forward to seeing the completed series. I think we should =
add the code for specifying the command-line option for setting custom =
keys to this series if possible.=
