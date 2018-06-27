Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9Wq-0004r4-B3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9Wn-0002pq-5N
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:26:32 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
	<20180627132747.76773eb9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
Date: Wed, 27 Jun 2018 07:26:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180627132747.76773eb9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 06:27 AM, Igor Mammedov wrote:
> On Mon, 25 Jun 2018 09:41:53 -0300
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> Loosely based on 076b35b5a56.
>>
>> Suggested-by: Stefan Weil <sw@weilnetz.de>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---

>> +#ifndef QEMU_UNITS_H
>> +#define QEMU_UNITS_H
>> +
>> +#define KiB     (INT64_C(1) << 10)
>> +#define MiB     (INT64_C(1) << 20)
>> +#define GiB     (INT64_C(1) << 30)
>> +#define TiB     (INT64_C(1) << 40)
>> +#define PiB     (INT64_C(1) << 50)
>> +#define EiB     (INT64_C(1) << 60)
> Shouldn't above use UINT64_C()

Since the decision of signed vs. unsigned was intentional based on=20
review on earlier versions, it may be worth a comment in this file that=20
these constants are intentionally signed (in usage patterns, these tend=20
to be multiplied by another value; and while it is easy to go to=20
unsigned by doing '1U * KiB', you can't go in the opposite direction if=20
you want a signed number for '1 * KiB' unless KiB is signed).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
