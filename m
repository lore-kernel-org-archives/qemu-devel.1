Received: from eggs.gnu.org ([2001:4830:134:3::10]:55155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edVU1-0006Q0-Au
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edVTx-0006hx-Sb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:21:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1edVTx-0006h1-Mm
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:21:25 -0500
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-2-f4bug@amsat.org>
	<20171108202924.GV3111@localhost.localdomain>
	<915da050-14bd-50ad-9a0d-5ad81fd34073@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <46d3f7c5-df3b-b650-e0a2-ea786a0400c4@redhat.com>
Date: Mon, 22 Jan 2018 07:21:18 +0100
MIME-Version: 1.0
In-Reply-To: <915da050-14bd-50ad-9a0d-5ad81fd34073@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] machine: add a deprecated_reason
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 22.01.2018 03:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
>> This series introduces 5 different flavors of deprecation
>> messages:
>>
>> * "Too old"
>> * "Unmaintained"
>> * "The ZCU102 machine has the same features supported"
>> * "Use the \"pc\" machine instead"
>> * "Obsoleted by the \"40p\" machine"
>>
>> Can we clearly document guidelines and examples for values of
>> this field, to help ensure consistency?
>>
>> Examples of questions that could be answered in the field
>> documentation:
>>
>> * Should the message start with an uppercase letter?
>> * Should it really explain _why_ it was deprecated, or is a
>>   simple "please use xlnx-zcu102 instead" good enough?
>> * Which of the following is preferred:
>>   * "obsoleted by the \"pc\" machine"
>>   * "obsoleted by \"pc\""
>>   * "use \"pc\" instead"
>>   * "too old, use \"pc\" instead"
>>   * "too old; use \"pc\" instead"
>>   * <something else?>
>=20
> Do you have any preference regarding Eduardo's suggestions?
>=20
> I see this pattern:
>=20
> - obsoleted by newer
>   -> hint about replacement
> - too old, unmaintained (maybe suggest use an older version?)
>   -> hint when removal is scheduled

I don't mind the exact wording, as long as there is an indication for
the user what to do next (if possible).

> These are also valid for Devices.
>=20
> Now if we want a consistent guideline, I suggest we clearly document th=
e
> deprecated machines/devices in qemu-doc.texi and extract this
> information at build time, like trace.h.

While it's a must of course to document deprecations in the qemu-doc,
automatic extraction already sounds like over-engineering to me. I don't
think that we are going to have as much deprecation entries as trace
points, so would an additional automatic mechanism really help a lot here=
?

 Thomas
