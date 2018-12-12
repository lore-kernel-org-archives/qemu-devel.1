Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gXA33-0005FO-9H
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gXA30-0007kl-2Y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:19:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gXA2z-0007jy-Rb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:19:53 -0500
References: <20180910083222.8245-1-marcandre.lureau@redhat.com>
	<20180910083222.8245-5-marcandre.lureau@redhat.com>
	<b2554dcc-2f42-a154-5680-45f31726ae90@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d4355023-434e-78f0-1acd-0f3e2ad5ae07@redhat.com>
Date: Wed, 12 Dec 2018 20:19:41 +0100
MIME-Version: 1.0
In-Reply-To: <b2554dcc-2f42-a154-5680-45f31726ae90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 4/6] acpi: expose TPM/PPI configuration
 parameters to firmware via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/12/18 17:04, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing Laszlo

Thanks.

As noted in the blurb, the edk2 side has been upstream for a while (it
was applied after an extremely long and thorough design discussion). As
long as the QEMU side conforms to the agreed-upon interface, I'm neutral
on the QEMU code.

Of course, this doesn't mean that *you* shouldn't review it! :)

Thanks,
Laszlo
