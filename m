Received: from eggs.gnu.org ([2001:4830:134:3::10]:57997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUx04-0002Ti-1L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUx02-0000qH-QC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:22:56 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUx02-0000pc-Jl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:22:54 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so3583615wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:22:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 16:22:32 +0100
Message-ID: <CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 11 July 2017 at 16:07, Ben Warren <ben@skyportsystems.com> wrote:
> Hi Peter,
>> On Jul 11, 2017, at 6:32 AM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> On 3 July 2017 at 20:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> From: Ben Warren <ben@skyportsystems.com>
>>>
>>> The following tests are implemented:
>>> * test that a GUID passed in by command line is propagated to the guest=
.
>>>  Read the GUID from guest memory
>>> * test that the "auto" argument to the GUID generates a valid GUID, as
>>>  seen by the guest.
>>> * test that a GUID passed in can be queried from the monitor
>>>
>>>  This patch is loosely based on a previous patch from:
>>>  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.co=
m>
>>>
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Hi -- this test seems to intermittently fail:
>>
>> TEST: tests/vmgenid-test... (pid=3D15466)
>>  /i386/vmgenid/vmgenid/set-guid:                                      **
>> ERROR:/home/peter.maydell/qemu/tests/vmgenid-test.c:65:acpi_find_vgia:
>> assertion failed (ACPI_ASSERT_CMP
>> _str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
>> FAIL
>> GTester: last random seed: R02S27021da892f2124a377287729b848ff8
>> (pid=3D15470)
>>  /i386/vmgenid/vmgenid/set-guid-auto:                                 OK
>>  /i386/vmgenid/vmgenid/query-monitor:                                 OK
>> FAIL: tests/vmgenid-test
>>
>> (that's an aarch32 build).
>>
>>
> I=E2=80=99ll try to reproduce.  How exactly are the tests called?

'make check V=3D1', same as usual.

I did a manual run of just this test, with
while QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386 gtester -k
--verbose -m=3Dquick tests/vmgenid-test ;do true ;done

but that didn't seem to fall over, so either the test is very
intermittently flaky, or it depends on load on the machine or
something.

thanks
-- PMM
