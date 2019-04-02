Received: from eggs.gnu.org ([209.51.188.92]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBC7E-0000gd-3m
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBC7D-0006wQ-78
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBC7C-0006vi-Ve
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:37:43 -0400
Date: Tue, 2 Apr 2019 07:37:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190402053739.6krcd5hmd4cwm67s@sirius.home.kraxel.org>
References: <90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: fix audio timer rate conversion bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: qemu-devel@nongnu.org

On Mon, Apr 01, 2019 at 08:59:20PM +0200, Volker R=FCmelin wrote:
> Currently the default audio timer frequency is 10000Hz instead of
> a period of 10000us. Also the audiodev timer-period property gets
> converted like a frequency. Only handling of the legacy
> QEMU_AUDIO_TIMER_PERIOD environment variable is correct because
> it's actually a frequency.
>=20
> With this patch the property timer-period is really a timer period
> and QEMU_AUDIO_TIMER_PERIOD remains a frequency.

Patch queued.

> This fixes commit 71830221fb23388b32e6516c2fb7a698453a6c5a
> -audiodev command line option basic implementation.

This can be written as "Fixes: <short hash> <subject>" line,
so tools can pick this up automatically (Hint for the next time,
I've updated the commit message, no need to resend).

thanks,
  Gerd
