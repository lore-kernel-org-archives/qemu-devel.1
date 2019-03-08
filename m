Received: from eggs.gnu.org ([209.51.188.92]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29QE-0000Fw-Jz
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29QD-0001k1-Rd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:55:58 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-8-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5166477f-67db-cf41-cdc9-a459597be80e@redhat.com>
Date: Fri, 8 Mar 2019 07:55:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/18] hw/nvram/fw_cfg: Add
 fw_cfg_common_unrealize()
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
> Back in abe147e0ce4 when fw_cfg_add_file() was introduced, there
> was no QOM design, object where not created and released at runtime.
> Later 38f3adc34d finished the QOM conversion of the fw_cfg device,
> adding the fw_cfg_common_realize() method.
> The time has come to add the equivalent destructor and release the
> memory allocated for 'files'.

You should mention that the unrealize function is currently never called
since the object never gets destroyed (AFAIK). But I hope we can fix
that in the not so distant future, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
