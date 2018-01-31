Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egseU-0004XI-9n
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egseP-0004nJ-LR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egseP-0004mt-Ez
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:42:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180122120351.22369-1-f4bug@amsat.org>
Date: Wed, 31 Jan 2018 14:42:03 +0100
In-Reply-To: <20180122120351.22369-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	22 Jan 2018 09:03:44 -0300")
Message-ID: <87372m5ems.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] qdev: remove
 DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> since v1:
>   - fix format string on 32-bit host (patchew)
>   - do not add smbus_eeprom_reset() (Eduardo)
>   - directly use DeviceClass::realize (Eduardo)
>   - squashed 2 patches (Eduardo)
>
> Hi,
>
> This series finalize the qdev QOMification.

Awesome!

It's been almost nine years since qdev, and more than 7 since QOM.

Sadly, I don't have the time to review this closely right now.

> We first convert the I2CSlave/SMBusDevice,
> then the usb-ccid and virtio-ccw,
> and finally the SysBusDevice.
>
> At the end we get one less TODO :)
>
>     /* TODO remove, once users are converted to unrealize */
>
> There is still one standing in SysBusDeviceClass::init().

Another one in ssi_sd_realize(), I think.  I didn't really look for
more.
