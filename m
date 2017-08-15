Received: from eggs.gnu.org ([2001:4830:134:3::10]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhe4F-0001Zp-QC
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhe4B-0001FT-Te
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:43 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:37829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhe4B-0001FH-M2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:39 -0400
Received: by mail-pg0-x235.google.com with SMTP id y129so7822123pgy.4
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:47:39 -0700 (PDT)
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
Date: Tue, 15 Aug 2017 08:47:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170814173335.58f0e84f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 08/14/2017 08:33 AM, Cornelia Huck wrote:
> On Mon, 14 Aug 2017 17:34:15 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> Speed up tests on host systems with kvm support.
>> In particular, this fixes tests with --disable-tcg.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Suggested-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>
>> Tested on x86 only.
>>
>>  tests/boot-serial-test.c | 2 +-
>>  tests/pnv-xscom-test.c   | 4 ++--
>>  tests/prom-env-test.c    | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 11f48b0..c3b2e4e 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -78,7 +78,7 @@ static void test_machine(const void *data)
>>      fd = mkstemp(tmpname);
>>      g_assert(fd != -1);
>>  
>> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
>> +    args = g_strdup_printf("-M %s,accel=kvm:tcg -chardev file,id=serial0,path=%s"
>>                             " -no-shutdown -serial chardev:serial0 %s",
>>                             test->machine, tmpname, test->extra);
> 
> This has already been changed upstream.

Ouch.  This is the only real smoke test we have for the tcg backend for the
host.  While it is still going to test tcg for whatever machines do not run
natively on the host, I can't help think we've lost testing.

Can we use accel=tcg:kvm instead?


r~
