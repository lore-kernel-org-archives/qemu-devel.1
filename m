Received: from eggs.gnu.org ([209.51.188.92]:37521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsdF-0006Xh-6d
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsdE-0006ua-2R
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDsdA-0006pk-AP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:50 -0400
References: <20190409134536.15548-1-philmd@redhat.com>
	<CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
Date: Tue, 9 Apr 2019 17:25:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 04/09/19 16:00, Peter Maydell wrote:
> On Tue, 9 Apr 2019 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> Hi,
>>
>> Two trivial fixes to avoid the latest EDK2 testing series to
>> cause trouble to downstream distributions (in particular if
>> they have PIE enforced).
>>
>> Since v2:
>> - addressed Laszlo's suggestion
>> - reworded patch description
>>
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.htm=
l
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.htm=
l
>> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/ms=
g00992.html
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>>   roms: Allow passing configure options to the EDK2 build tools
>>
>>  roms/Makefile | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> Thanks. This is one of a handful of remaining bugs we
> should fix for 4.0, so I would ideally like to get this
> in rc3 today (or tomorrow if we have to slip rc3 a day).
> If people wanting to review this series could do so
> promptly I'd definitely appreciate it.
>=20
> -- PMM
>=20

I hope I was quick enough.

Thanks,
Laszlo
