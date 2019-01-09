Received: from eggs.gnu.org ([209.51.188.92]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH0T-0006MF-KN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH0S-0000Hl-MX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:47:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghH0S-0000Dd-En
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:47:04 -0500
References: <20190108182226.28873-1-pbonzini@redhat.com>
	<CAFEAcA-HpZxMH5LoK2waHQ0VGSR2tu_F2J7AFSBm4gRvZTdM3A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97f7d8c9-8035-ef5c-676a-b3e065eacc9b@redhat.com>
Date: Wed, 9 Jan 2019 17:40:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-HpZxMH5LoK2waHQ0VGSR2tu_F2J7AFSBm4gRvZTdM3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 09/01/19 00:51, Peter Maydell wrote:
> On Tue, 8 Jan 2019 at 18:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffe=
f22f0:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-=
request' into staging (2019-01-08 16:07:32 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to aac9150d775a51cd6c49c466114006ac9f8a3ba=
a:
>>
>>   avoid TABs in files that only contain a few (2019-01-08 19:20:41 +01=
00)
>>
>> ----------------------------------------------------------------
>> * HAX support for Linux hosts (Alejandro)
>> * esp bugfixes (Guenter)
>> * Windows build cleanup (Marc-Andr=C3=A9)
>> * checkpatch logic improvements (Paolo)
>> * coalesced range bugfix (Paolo)
>> * switch testsuite to TAP (Paolo, with Peter's fix to hexloader-test)
>> * QTAILQ rewrite (Paolo)
>> * block/iscsi.c cancellation fixes (Stefan)
>> * improve selection of the default accelerator (Thomas)
>>
>> ----------------------------------------------------------------
>> v4->v5: fix conflicts
>=20
> unexpected write errors still here :-(
>=20
> Looking for expected file 'tests/data/acpi/q35/DSDT.bridge'
> Using expected file 'tests/data/acpi/q35/DSDT.bridge'
> Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> Using expected file 'tests/data/acpi/q35/FACP'
> Looking for expected file 'tests/data/acpi/q35/APIC.bridge'
> Looking for expected file 'tests/data/acpi/q35/APIC'
> Using expected file 'tests/data/acpi/q35/APIC'
> Looking for expectfwrite(): Resource temporarily unavailable
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/al=
ldbg'
> make: write error: stdout
>=20
>=20
>=20
> I'll try to prod this a bit more on Thursday (and
> find out if it's intermittent or consistent).

Hmm I should have left in the </dev/null just in case. :((((

Paolo
