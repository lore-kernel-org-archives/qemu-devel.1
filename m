Received: from eggs.gnu.org ([209.51.188.92]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGRl7-0002Nm-EB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGRl6-00043O-IT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hGRl6-0003mi-Bj
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:20:36 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com> <20190416084059.GD31311@redhat.com>
	<jpglg0a3p93.fsf@linux.bootlegged.copy>
	<20190416161242.GU31311@redhat.com>
	<jpgwojtoq5r.fsf@linux.bootlegged.copy>
	<20190416165217.GV31311@redhat.com>
Date: Tue, 16 Apr 2019 13:20:14 -0400
In-Reply-To: <20190416165217.GV31311@redhat.com> ("Daniel P.
	\=\?utf-8\?Q\?Ber\?\= \=\?utf-8\?Q\?rang\=C3\=A9\=22's\?\=
	message of "Tue, 16 Apr 2019 17:52:17 +0100")
Message-ID: <jpg1s21dfzl.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

>> I can't find usb-mtp sending a "I/O error" on an error condition
>> for the objectinfo phase. It might be libmtp or even the command itself
>> failing for some reason. For incomplete transfer, I just checked, it's
>> spitting out the error message correctly as INCOMPLETE_FILE_TRANSFER.
>>=20
>> With libmtp version 1.13 on a FC24 guest, here's the output:
>>=20
>> $ mtp-sendfile test.txt test.img
>> libmtp version: 1.1.13
>>=20
>> Device 0 (VID=3D46f4 and PID=3D0004) is UNKNOWN in libmtp v1.1.13.
>> Please report this VID/PID and the device model to the libmtp developmen=
t team
>> ignoring libusb_claim_interface() =3D -6PTP_ERROR_IO: failed to open ses=
sion, trying again after resetting USB interface
>> LIBMTP libusb: Attempt to reset device
>> Sending test.txt to test.img
>> type: txt, 44
>> Sending file...
>> Progress: 322 of 322 (100%)
>> New file ID: 7
>>=20
>> What guest is this ? I can try to reproduce.
>
> This was Fedora 26, so technically it is end of life, but then so
> is your F24 guest :-)
>
> Should really check with a modern guest like Fedora 29 or rawhide.
>
I had a F28 guest and here, mtp-sendfile appears to succeed but no file is =
written
However, nautilus works fine, it doesn't appear like an issue with libmtp
or Qemu.

> Regards,
> Daniel
