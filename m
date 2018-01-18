Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCdC-0000OE-T2
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCd7-0001Ce-Fb
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecCd7-0001C1-9E
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:01:29 -0500
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-7-f4bug@amsat.org>
	<16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dc16a38-1b4a-91f9-a68c-e216cbe279fe@redhat.com>
Date: Thu, 18 Jan 2018 17:00:42 +0100
MIME-Version: 1.0
In-Reply-To: <16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 06/16] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 18/01/2018 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>  static void sdhci_common_realize(SDHCIState *s, Error **errp)
>>  {
>> +    sdhci_init_readonly_registers(s, errp);
>> +    if (errp && *errp) {
> Paolo said this is wrong (as in bad pattern?).
>=20
> I will respin probably using 'bool sdhci_init_readonly_registers()' ins=
tead.
>=20

Please use the local_err idiom instead.

Paolo
