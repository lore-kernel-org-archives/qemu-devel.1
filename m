Received: from eggs.gnu.org ([2001:4830:134:3::10]:33714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEoF-0003wl-4c
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEoA-000340-8y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:29:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEEoA-00032K-32
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:29:50 -0500
Date: Mon, 13 Nov 2017 14:29:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113132946.j4xyt2gx4uqmmvxw@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-9-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112193032.9724-9-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] sdl2: Ignore UI hotkeys after a focus
 change when GUI modifier is held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

 Hi,

>          if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
>              absolute_mouse_grab(scon);
>          }

Can you please add a comment here describing why this is done?
>From the code alone it isn't obvious that this is a workaround
for a SDL bug.

> +        scon->ignore_hotkeys = get_mod_state();
>          break;

cheers,
  Gerd
