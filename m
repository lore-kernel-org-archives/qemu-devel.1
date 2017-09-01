Received: from eggs.gnu.org ([2001:4830:134:3::10]:56119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dna0l-0005jw-PH
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dna0k-0007V9-JO
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:40:39 -0400
References: <20170901001502.29915-1-jsnow@redhat.com>
	<20170901001502.29915-6-jsnow@redhat.com>
	<b16eaf48-2452-8f9f-547d-b9ac999be308@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <8234fbad-76d8-bb9d-6972-871578fca59e@redhat.com>
Date: Thu, 31 Aug 2017 20:40:28 -0400
MIME-Version: 1.0
In-Reply-To: <b16eaf48-2452-8f9f-547d-b9ac999be308@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/9] IDE: replace DEBUG_AIO with trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com



On 08/31/2017 08:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/31/2017 09:14 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

TY, and btw the reasoning behind what I went with:

Since s->dma_cmd is itself a type `enum ide_dma_cmd` then by definition
s->dma_cmd (even if corrupted or wrong) must fit inside the width of
that type. Performing the range checking in the getter is adequate for
protecting the table in this case, if I understand Laszlo's rationales
correctly.

In case case of the AHCI table, I do not use a getter since the IRQBIT
property is passed in statically for each instance and shouldn't have a
chance to get out-of-spec. (If it does, something MASSIVELY bad has
corrupted everything, and then we've got worse problems.)

Thanks,
John
