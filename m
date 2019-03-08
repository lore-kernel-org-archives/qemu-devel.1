Received: from eggs.gnu.org ([209.51.188.92]:35830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2546-0003r4-Np
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2542-0005Ql-Ey
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:16:48 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-17-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82e36613-3968-3459-4be7-f0e927faeb5c@redhat.com>
Date: Thu, 7 Mar 2019 20:16:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-17-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/18] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 3/7/19 7:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The Edk2Crypto object is used to hold configuration values specific
> to EDK2.
>=20
> The edk2_add_host_crypto_policy() function loads crypto policies
> from the host, and register them as fw_cfg named file items.
> So far only the 'https' policy is supported.
>=20
> An usercase example is the 'HTTPS Boof' feature of OVMF [*].

s/An/A/ since "user" is a pronounced or hard 'u' (English is funny, but
the rule of thumb is you add the consonant only before a soft u, and not
a pronounced one; as in "give an umbrella to a unicorn")

>=20
> Usage example:
>=20
>   $ qemu-system-x86_64 \
>       -object edk2_crypto,id=3Dhttps,\

Might as well use --object (both spellings work for qemu, but since
--object is the only spelling for qemu-img/qemu-nbd, being consistent
between the lot is useful).

>               ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin

(I really should follow through on my threat to teach QemuOpts to ignore
whitespace after ','; but for this commit message, it's obvious the
indentation has to be stripped for the command line to be valid)

>=20
> (On Fedora these files are provided by the ca-certificates and
> crypto-policies packages).
>=20
> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
