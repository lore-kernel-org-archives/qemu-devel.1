Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ffNOE-0004Eo-Dx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ffNOB-0008Q1-Av
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:39:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ffNOB-0008PV-55
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:39:27 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so1135695ita.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 03:39:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717120326.0c62f545@redhat.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-3-marcandre.lureau@redhat.com>
	<20180717120326.0c62f545@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 12:39:25 +0200
Message-ID: <CAMxuvaxOOeHW_iCzp+xSaH6=jqq+6yZHcWNzEK=AFqu3UFjAjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Tue, Jul 17, 2018 at 12:03 PM, Igor Mammedov <imammedo@redhat.com> wrote=
:
> On Mon, 16 Jul 2018 14:59:45 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> Implement a virtual memory device for the TPM Physical Presence interfac=
e.
>> The memory is located at 0xFED45000 and used by ACPI to send messages to=
 the
>> firmware (BIOS) and by the firmware to provide parameters for each one o=
f
>> the supported codes.
> ...
> another question wrt E820 table, is firmware putting a reservation record
> for this RAM area overlay or should we do it QEMU?

There doesn't seem to be any reservation done in ovmf, or on my
laptop. I also wonder if it should be done. And how OS deal with that
today (/proc/iomem is correct).

Laszlo, any idea?
