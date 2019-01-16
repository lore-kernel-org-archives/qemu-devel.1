Received: from eggs.gnu.org ([209.51.188.92]:43906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gjjTT-0004Zo-QC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gjjTR-0003lf-2H
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:35:09 -0500
Date: Wed, 16 Jan 2019 12:34:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190116113455.dyl6uctl4dpaqh6v@sirius.home.kraxel.org>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
	<be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
	<87sgxtatod.fsf@dusky.pond.sub.org>
	<4b24723e-5a27-f25f-76c1-f2f4e94757ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b24723e-5a27-f25f-76c1-f2f4e94757ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/ssi: Remove SSIBus from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

  Hi,

> typedefs.h is useful to avoid rebuilding the world too often if a type
> is used many times as a pointer, but rarely as a struct and rarely has
> functions called on its instances.

Related:  Can also be used to keep struct content private.  struct
QemuConsole for example is private to ui/console.c, but pointers to
QemuConsole are passed around alot in ui/* and hw/display/* code.

cheers,
  Gerd
