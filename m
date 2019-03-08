Received: from eggs.gnu.org ([209.51.188.92]:36692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Ddv-0001R0-Jw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Ddu-0003Lw-Oc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:26:23 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a085f88a-0f09-464f-af30-ec4048146cee@redhat.com>
Date: Fri, 8 Mar 2019 12:25:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/18] fw_cfg: reduce memleaks,
 add QMP/HMP info + edk2_add_host_crypto_policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series consists of:
> - trivial cleanups, add trace events (was in v1)
> - add QMP/HMP commands to display the list of fw_cfg entries (reworked =
from v1)
> - add unrealize() method and deallocate various buffers (new in v2)
> - add fw_cfg_add_file_from_host (was in v1)
> - add edk2_add_host_crypto_policy (new in v2)
>=20
> Since v1:
> - Addressed Michael and Laszlo comments.
>=20
> Please review,
>=20
> Phil.
>=20
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

I'm completely exhausted after reviewing 13 QEMU patches this morning,
so I'll stop after "PATCH v2 12/18" in this series.

Please split the patch set into multiple, better focused waves (the
summary at the top is an indication of what each wave should concern
itself with).

Thanks,
Laszlo
