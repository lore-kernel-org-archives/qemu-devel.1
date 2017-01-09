Received: from eggs.gnu.org ([2001:4830:134:3::10]:34146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cQjf2-00045P-NX
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cQjex-0002Iq-TB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:47:32 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:58544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1cQjex-0002I4-Hp
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:47:27 -0500
References: <20161206190007.7539-1-fabian@lesniak-it.de>
From: Fabian Lesniak <fabian@lesniak-it.de>
Message-ID: <3cc64ccd-c142-d07f-7c92-b53c1ce83703@lesniak-it.de>
Date: Tue, 10 Jan 2017 00:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20161206190007.7539-1-fabian@lesniak-it.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] add support for mice with
 extra/side buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Ping.

I forgot to CC Gerd.

http://patchwork.ozlabs.org/patch/703302/

http://patchwork.ozlabs.org/patch/703304/

http://patchwork.ozlabs.org/patch/703303/


Am 06.12.2016 um 20:00 schrieb Fabian Lesniak:
> This patch implements event handling for 5-button ps/2 mice and
> appropriate event generation for gtk and input-linux input methods.
>
> As Gerd suggested, it is now split into three parts and introduces
> distinct ps2 mouse button definitions instead of using the legacy
> ones from console.h. Please comment on the location of the new
> definitions if inappropriate.
>
> The changes to qapi were improved following Eric's hints.
>
> Fabian Lesniak (3):
>    qapi: add support for mice with extra/side buttons
>    ps2: add support for mice with extra/side buttons
>    ui: add support for mice with extra/side buttons
>
>   hw/input/ps2.c         | 8 +++++---
>   include/hw/input/ps2.h | 6 ++++++
>   qapi-schema.json       | 7 ++++++-
>   ui/gtk.c               | 4 ++++
>   ui/input-linux.c       | 6 ++++++
>   5 files changed, 27 insertions(+), 4 deletions(-)
>
