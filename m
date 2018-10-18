Received: from eggs.gnu.org ([2001:4830:134:3::10]:33726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gD0PP-0001q3-0w
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 00:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gD0PD-0000NL-9o
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 00:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gD0P9-00007w-8M
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 00:59:28 -0400
References: <20181011192513.63634-1-dgilbert@redhat.com>
	<20181011192513.63634-3-dgilbert@redhat.com>
	<20181017192826.GA7385@flamenco>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb994077-c798-99ea-c526-47ef19481209@redhat.com>
Date: Thu, 18 Oct 2018 06:59:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181017192826.GA7385@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/7] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, wei@redhat.com, i.maximets@samsung.com, den@openvz.org

On 2018-10-17 21:28, Emilio G. Cota wrote:
> On Thu, Oct 11, 2018 at 20:25:08 +0100, Dr. David Alan Gilbert (git) wr=
ote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We can re-use the s390-ccw bios code to implement a small firmware
>> for a s390x guest which prints out the "A" and "B" characters and
>> modifies the memory, as required for the migration test.
>>
>> [quintela: Converted the compile script to Makefile rules]
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <1539078677-25396-1-git-send-email-thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>   Fixed up Makefile since the aarch patch sneaked in first
>=20
> I suspect this test is giving me intermittent hangs. I've seen the hang=
s
> in different machines, but when they're lightly loaded the
> hang happens more frequently.
>=20
> To reproduce:
>=20
> $ ./configure --target-list=3Ds390x-softmmu
> $ make clean && make
> $ for i in $(seq 0 150); do echo $i && make -j check-qtest || break; do=
ne
>=20
> It usually ends up hanging before 50 runs. When the hang happens, I see
> two qemu-system-s390x processes with:
>=20
> -serial file:/tmp/migration-test-0FZErQ/dest_serial
>=20
> as an argument, among others. That means the migration test is the
> one hanging, correct?

Can you also reproduce it directly by only running the migration test
alone, just to be sure? I.e. run something like this in a loop:

QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" tests/migration-tes=
t

 Thanks,
  Thomas
