Received: from eggs.gnu.org ([2001:4830:134:3::10]:55529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffMpX-0003Kc-WC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffMpS-0002c6-H1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ffMpS-0002b7-Af
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:03:34 -0400
Date: Tue, 17 Jul 2018 12:03:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180717120326.0c62f545@redhat.com>
In-Reply-To: <20180716125948.11666-3-marcandre.lureau@redhat.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/5] tpm: implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S.
	Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 16 Jul 2018 14:59:45 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> Implement a virtual memory device for the TPM Physical Presence interface.
> The memory is located at 0xFED45000 and used by ACPI to send messages to =
the
> firmware (BIOS) and by the firmware to provide parameters for each one of
> the supported codes.
...
another question wrt E820 table, is firmware putting a reservation record
for this RAM area overlay or should we do it QEMU?
