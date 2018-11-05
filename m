Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJaG0-0007ay-Br
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJaFv-0006qG-4e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJaFu-0006mg-TY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:07 -0500
Date: Mon, 5 Nov 2018 09:29:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105082902.so2mq3njuk5c3yu6@sirius.home.kraxel.org>
References: <1541052609-29212-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541052609-29212-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw: fw_cfg: use qemu_opt_get_number to
 get splash-time and reboot-timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

> +    uint64_t boot_splash_time = -1;

Hmm, why use uint64_t here ...

> +    if ((int64_t)boot_splash_time >= 0) {

... then cast it to int64_t here?

Isn't it easier to just use int64_t?

cheers,
  Gerd
