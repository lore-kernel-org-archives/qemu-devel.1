Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H9a-00069N-HV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H9W-0001WU-Dp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:31:42 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H9W-0001VG-9o
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:31:38 -0400
Received: by mail-qt0-x233.google.com with SMTP id f16-v6so3651019qth.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:31:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419212727.26095-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0732721-82d1-de1a-25ed-60749be96f51@amsat.org>
Date: Thu, 19 Apr 2018 18:31:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180419212727.26095-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] qdev: remove
 DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/19/2018 06:27 PM, Philippe Mathieu-Daudé wrote:
> Since v2:
>   - rebased for 2.13 (Markus)
>   - dropped 2 patches already merged (Gerd)
>   - start sentences with a capital letter and end with a full stop (Peter)

I forgot to put the backport-diff, in case someone already reviewed v2:

[----] : patches are identical
The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively

001/4:[----] [--] 'hw/i2c/smbus: use DeviceClass::realize instead of
SMBusDeviceClass::init'
002/4:[----] [-C] 'hw/i2c: use DeviceClass::realize instead of
I2CSlaveClass::init'
003/4:[----] [-C] 'qdev: simplify the SysBusDeviceClass::init path'
004/4:[----] [-C] 'qdev: remove DeviceClass::exit'


> since v1:
>   - fix format string on 32-bit host (patchew)
>   - do not add smbus_eeprom_reset() (Eduardo)
>   - directly use DeviceClass::realize (Eduardo)
>   - squashed 2 patches (Eduardo)
