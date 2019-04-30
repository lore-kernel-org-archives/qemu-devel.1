Received: from eggs.gnu.org ([209.51.188.92]:42097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYQa-0006V2-RK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYQZ-00071O-O0
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLYQZ-00070z-GU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:28:31 -0400
References: <20190427144025.22880-1-philmd@redhat.com>
	<6e3003f3-3d96-c1be-6890-baa2c61d34dc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <766a1b03-47cb-2fc3-bdfb-e0d883ad0ebd@redhat.com>
Date: Tue, 30 Apr 2019 21:28:18 +0200
MIME-Version: 1.0
In-Reply-To: <6e3003f3-3d96-c1be-6890-baa2c61d34dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/i386/acpi: Improve build modularity
 (isapc/q35/...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27/04/19 16:43, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/27/19 4:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This series allow to build the ISAPC/Q35 machines independently.
>=20
> Oops I guess I forgot:
> Based-on: 20190427141905.20393-1-philmd@redhat.com
> (i440fx is not a machine)
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04673.html

Queued (*without* the based-on-but-not-really series), thanks.

Paolo
>=20
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>>   hw/acpi/piix4: Move TYPE_PIIX4_PM to a public header
>>   hw/i386/acpi: Add object_resolve_type_unambiguous to improve
>>     modularity
>>   hw/i386/acpi: Assert a pointer is not null BEFORE using it
>>
>>  hw/acpi/piix4.c         | 13 -------------
>>  hw/i386/acpi-build.c    | 22 +++++++++++++++++-----
>>  hw/isa/lpc_ich9.c       | 11 -----------
>>  include/hw/acpi/piix4.h |  2 +-
>>  include/hw/i386/ich9.h  |  2 --
>>  5 files changed, 18 insertions(+), 32 deletions(-)
>>
