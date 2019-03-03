Received: from eggs.gnu.org ([209.51.188.92]:43896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0S3g-0006ti-Ow
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0S3f-0005ko-T0
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:25:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h0S3f-0005jR-L5
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:25:39 -0500
References: <1551456970-463-1-git-send-email-thuth@redhat.com>
	<74a6796e-1242-69dd-a74d-74525955f100@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <257d080a-27f9-52e5-76e4-d6929b80cad5@redhat.com>
Date: Sun, 3 Mar 2019 15:15:32 +0100
MIME-Version: 1.0
In-Reply-To: <74a6796e-1242-69dd-a74d-74525955f100@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Remove (mostly) useless
 architecture checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>

On 01/03/2019 18.57, John Snow wrote:
>=20
>=20
> On 3/1/19 11:16 AM, Thomas Huth wrote:
>> These checks at the beginning of some of the tests are mostly useless:
>> We only run the tests on x86 anyway, and g_test_message() does not
>> print anything unless you call g_test_init() first.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/fdc-test.c      | 7 -------
>>  tests/ide-test.c      | 7 -------
>>  tests/ipmi-bt-test.c  | 7 -------
>>  tests/ipmi-kcs-test.c | 7 -------
>>  4 files changed, 28 deletions(-)
>>
>> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
>> index 88f1abf..31cd329 100644
>> --- a/tests/fdc-test.c
>> +++ b/tests/fdc-test.c
>> @@ -548,16 +548,9 @@ static void fuzz_registers(void)
>> =20
>>  int main(int argc, char **argv)
>>  {
>> -    const char *arch =3D qtest_get_arch();
>>      int fd;
>>      int ret;
>> =20
>> -    /* Check architecture */
>> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
>> -        g_test_message("Skipping test for non-x86\n");
>> -        return 0;
>> -    }
>> -
>>      /* Create a temporary raw image */
>>      fd =3D mkstemp(test_image);
>>      g_assert(fd >=3D 0);
>> diff --git a/tests/ide-test.c b/tests/ide-test.c
>> index f0280e6..300d64e 100644
>> --- a/tests/ide-test.c
>> +++ b/tests/ide-test.c
>> @@ -1009,16 +1009,9 @@ static void test_cdrom_dma(void)
>> =20
>>  int main(int argc, char **argv)
>>  {
>> -    const char *arch =3D qtest_get_arch();
>>      int fd;
>>      int ret;
>> =20
>> -    /* Check architecture */
>> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
>> -        g_test_message("Skipping test for non-x86\n");
>> -        return 0;
>> -    }
>> -
>>      /* Create temporary blkdebug instructions */
>>      fd =3D mkstemp(debug_path);
>>      g_assert(fd >=3D 0);
>> diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
>> index f4a81b5..fc4c83b 100644
>> --- a/tests/ipmi-bt-test.c
>> +++ b/tests/ipmi-bt-test.c
>> @@ -400,15 +400,8 @@ static void open_socket(void)
>> =20
>>  int main(int argc, char **argv)
>>  {
>> -    const char *arch =3D qtest_get_arch();
>>      int ret;
>> =20
>> -    /* Check architecture */
>> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
>> -        g_test_message("Skipping test for non-x86\n");
>> -        return 0;
>> -    }
>> -
>>      open_socket();
>> =20
>>      /* Run the tests */
>> diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
>> index 178ffc1..a2354c1 100644
>> --- a/tests/ipmi-kcs-test.c
>> +++ b/tests/ipmi-kcs-test.c
>> @@ -263,16 +263,9 @@ static void test_enable_irq(void)
>> =20
>>  int main(int argc, char **argv)
>>  {
>> -    const char *arch =3D qtest_get_arch();
>>      char *cmdline;
>>      int ret;
>> =20
>> -    /* Check architecture */
>> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
>> -        g_test_message("Skipping test for non-x86\n");
>> -        return 0;
>> -    }
>> -
>>      /* Run the tests */
>>      g_test_init(&argc, &argv, NULL);
>> =20
>>
>=20
> Hm, if you insist. I have no strong feelings... Do we plan to split
> tests out by architecture eventually? Clearly x86 only tests don't
> really need to each individually check the arch, but I'm not sure what
> the vision is.

We could also fix the g_test_message() output by moving it after the
g_test_init() ... I don't mind too much which way we go, but at least
the current state is bad.

Looking at other tests, we seem to be pretty inconsistent in checking
the architecture at the beginning. For example q35-test.c,
pvpanic-test.c and test-x86-cpuid.c do not check for x86, while
rtas-test.c has a check for ppc64...

> Either way, since I have no horse in the race:
>=20
> Acked-by: John Snow <jsnow@redhat.com>

Thanks!

 Thomas
