Received: from eggs.gnu.org ([2001:4830:134:3::10]:58663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPua-0001zn-1i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePPuW-0004wp-TA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:34:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePPuW-0004vY-MX
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:34:36 -0500
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
	<20171214090658.GA3731@dhcp-200-186.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
Date: Thu, 14 Dec 2017 10:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 14/12/2017 10:06, Kevin Wolf wrote:
> Am 14.12.2017 um 00:20 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> Use Base64 to serialize the binary blobs in JSON.
>> So far at most 512 bytes will be transfered, which result
>> in a 684 bytes payload.
>> Since this command is intented for qtesting, this is acceptable.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Doing this kind of thing over QMP doesn't look right to me. qtests
> should access hardware the same way as real guests access the hardware
> (i.e. MMIO and I/O ports).
>=20
> But if for some reason the QMP maintainers were to think that this is
> acceptable in QMP, I'd argue it should at least get an x-debug- prefix
> to avoid making it a stable API that management tools may rely on.

Yeah, what we usually do is not test the device (e.g. SCSI) directly,
but only through the HBA (e.g. virtio-scsi or AHCI, it would be SDHCI in
this case).

Thanks,

Paolo
