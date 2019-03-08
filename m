Received: from eggs.gnu.org ([209.51.188.92]:38038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29WX-0003F4-Sl
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29WW-0003Tx-Mk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:02:29 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-13-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2c1d16fc-fffa-1315-8a05-6dd080d2913d@redhat.com>
Date: Fri, 8 Mar 2019 08:02:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/18] hw/nvram/fw_cfg: Keep reference
 of file_data in FWCfgState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Daniel P . Berrange" <berrange@redhat.com>

On 08/03/2019 02.32, Philippe Mathieu-Daud=C3=A9 wrote:
> The 'file_data' is allocated by read_splashfile() (introduced in
> commit 3d3b8303c6f8).  It is then used by fw_cfg_add_file(). Due
> to the contract interface of fw_cfg_add_file(), it has to be valid
> for the lifetime of the FwCfg object.
>=20
> Keep a reference of 'file_data' in FWCfgState to be able to
> free this memory in fw_cfg_common_unrealize().
> We can now remove the res_free() from the main() loop.
> The global boot_splash_filedata is now unused, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c         | 10 ++++++----
>  include/hw/nvram/fw_cfg.h |  1 +
>  include/sysemu/sysemu.h   |  1 -
>  vl.c                      |  9 ---------
>  4 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
