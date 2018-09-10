Received: from eggs.gnu.org ([2001:4830:134:3::10]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzM4C-0008Hd-V2
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzLrD-0002s6-8Y
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:04:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fzLrD-0002rh-1W
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:03:59 -0400
Received: by mail-wm0-x241.google.com with SMTP id j192-v6so21430926wmj.1
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 06:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180904084648.680c564b@redhat.com>
	<CAJ+F1CLDPQr04Khj-B4UXMzEV-Cu_J2e4S4j2c43NT-s3HwywQ@mail.gmail.com>
	<20180906095802.7dffbf1b@redhat.com>
	<CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
	<20180906085937.GA2639@work-vm>
	<CAJ+F1CKeo2fGc5fLUG7Ezpk0OTkMATioqQ64A3gKT7jXvULTkA@mail.gmail.com>
	<20180906094245.GB2639@work-vm>
	<CAJ+F1C+b8Q3P7=s4W+-GCbWeLqhVCvs_xei_LTw22YWTJ16Bmg@mail.gmail.com>
	<20180906172304.GF2639@work-vm>
	<43c91014-2ca4-681b-51e7-b8cde063014c@redhat.com>
	<20180910104408.GE2482@work-vm>
In-Reply-To: <20180910104408.GE2482@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Sep 2018 17:03:39 +0400
Message-ID: <CAJ+F1CJEnLkJo29eahWS6F1cRyvS1nJZy-kGvQH04mGZdntbCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Mon, Sep 10, 2018 at 2:44 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> (I didn't know about guest_phys_block* and would have probably just used
> qemu_ram_foreach_block )
>

guest_phys_block*() seems to fit, as it lists only the blocks actually
used, and already skip the device RAM.

Laszlo, you wrote the functions
(https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dc5d7f60f0614250bd925071e=
25220ce5958f75d0),
do you think it's appropriate to list the memory to clear, or we
should rather use qemu_ram_foreach_block() ?

thanks

--=20
Marc-Andr=C3=A9 Lureau
