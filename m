Received: from eggs.gnu.org ([2001:4830:134:3::10]:44247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCg0-00024D-SG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCfw-00043v-0c
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:04:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecCfv-00043i-R5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:04:23 -0500
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-9-f4bug@amsat.org>
	<393fbcf8-a2a6-64cc-f5a2-c9e9cd90037a@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed0e2989-b61b-ba8f-764a-240ebfdd81ac@redhat.com>
Date: Thu, 18 Jan 2018 17:04:17 +0100
MIME-Version: 1.0
In-Reply-To: <393fbcf8-a2a6-64cc-f5a2-c9e9cd90037a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 08/16] sdhci: add basic Spec v1
 capabilities
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

On 18/01/2018 16:45, Philippe Mathieu-Daud=C3=A9 wrote:
>>      s->version =3D (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
>> =20
>> +    capab =3D sdhci_init_capareg(s, errp);
>> +    if (errp && *errp) {
> Paolo said this is wrong, I'll resping using UINT64_MAX as error and
> checking "if (capab =3D=3D UINT64_MAX) { return; }"

If all-ones capabilities is valid or can be valid in the future, then
perhaps it is better to use local_err, and not use the return value at
all if local_err !=3D NULL.

Paolo
