Received: from eggs.gnu.org ([2001:4830:134:3::10]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDoTn-0002ES-6v
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDoTi-0000yZ-D6
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:27:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDoTh-0000t7-1R
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:27:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id f17-v6so8131169wrs.12
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 03:27:26 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
	<20181019184408.GG31060@habkost.net>
	<20181019215345.521d58d7@igors-macbook-pro.local>
	<20181019202321.GM31060@habkost.net>
Message-ID: <f3d35b09-cec1-7d18-4d42-86dfb5b63fba@redhat.com>
Date: Sat, 20 Oct 2018 12:27:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181019202321.GM31060@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/45] Machine queue, 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 19/10/2018 22:23, Eduardo Habkost wrote:
> On Fri, Oct 19, 2018 at 09:53:45PM +0200, Igor Mammedov wrote:
>> On Fri, 19 Oct 2018 15:44:08 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>> On Fri, Oct 19, 2018 at 03:12:31PM +0100, Peter Maydell wrote:
>>>> On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:
>>>>>
>>>>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>>>>
>>>>> for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39c700cc:
>>>>>
>>>>>   numa: Clean up error reporting in parse_numa() (2018-10-17 16:33:40 -0300)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Machine queue, 2018-10-18
>>>>>
>>>>> * sysbus init/realize cleanups
>>>>>   (Cédric Le Goater, Philippe Mathieu-Daudé)
>>>>> * memory-device refactoring (David Hildenbrand)
>>>>> * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
>>>>> * -numa parsing cleanups (Markus Armbruster)
>>>>> * Fix hostmem-file memory leak (Zhang Yi)
>>>>> * Typo fix (Li Qiang)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>>
>>>>
>>>> Hi. This had some problems in merge testing, I'm afraid:
>>>>
>>>> On aarch64 host, warnings running tests/cpu-plug-test for i386 and s390 targets:
>>>>
>>>> TEST: tests/cpu-plug-test... (pid=12602)
>>>>   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=12:
>>>> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
>>>> (1) * cores (3) * threads (2) != maxcpus (12)
>>> [...]
>>>>
>>>> (plus similar ppc64, x86_64 targets)
>>>
>>> Ouch.  Apologies.
>>>
>>> Can we please do something make sure "make check" will fail on
>>> these cases?  I'd like to be able to trust CI systems like
>>> travis-ci.
>>>
>>
>> we probably don't want make check fail on warning.
> 
> I disagree.  If a warning is blocking a pull request from being
> merged, it must make CI systems fail too.  Otherwise we're
> defeating the purpose of CI systems.

We can, we also have the hardware (courtesy of Packet), we just need to
make time to set it up.

QEMU Summit is a good place where to talk about this.

> 
> 
>> Test was written with assumption that s/c/t tuples matches initially present CPUs, hence a warning.
>> Would something like following fix the issue (local x86 build/test looks fixed with it)?
> 
> It works for me.  I will queue it on machine-next, thanks!
> 
>>
>> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
>> index 3e93c8e..f4a677d 100644
>> --- a/tests/cpu-plug-test.c
>> +++ b/tests/cpu-plug-test.c
>> @@ -32,12 +32,12 @@ static void test_plug_with_cpu_add(gconstpointer data)
>>      unsigned int i;
>>  
>>      args = g_strdup_printf("-machine %s -cpu %s "
>> -                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>> +                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>>                             s->machine, s->cpu_model,
>>                             s->sockets, s->cores, s->threads, s->maxcpus);
>>      qtest_start(args);
>>  
>> -    for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
>> +    for (i = 1; i < s->maxcpus; i++) {
>>          response = qmp("{ 'execute': 'cpu-add',"
>>                         "  'arguments': { 'id': %d } }", i);
>>          g_assert(response);
>> @@ -56,7 +56,7 @@ static void test_plug_without_cpu_add(gconstpointer data)
>>      QDict *response;
>>  
>>      args = g_strdup_printf("-machine %s -cpu %s "
>> -                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>> +                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>>                             s->machine, s->cpu_model,
>>                             s->sockets, s->cores, s->threads, s->maxcpus);
>>      qtest_start(args);
>> @@ -79,12 +79,12 @@ static void test_plug_with_device_add_x86(gconstpointer data)
>>      unsigned int s, c, t;
>>  
>>      args = g_strdup_printf("-machine %s -cpu %s "
>> -                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>> +                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
>>                             td->machine, td->cpu_model,
>>                             td->sockets, td->cores, td->threads, td->maxcpus);
>>      qtest_start(args);
>>  
>> -    for (s = td->sockets; s < td->maxcpus / td->cores / td->threads; s++) {
>> +    for (s = 1; s < td->sockets; s++) {
>>          for (c = 0; c < td->cores; c++) {
>>              for (t = 0; t < td->threads; t++) {
>>                  char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
>> @@ -113,7 +113,7 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
>>                             td->sockets, td->cores, td->threads, td->maxcpus);
>>      qtest_start(args);
>>  
>> -    for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
>> +    for (c = 1; c < td->cores; c++) {
>>          char *id = g_strdup_printf("id-%i", c);
>>          qtest_qmp_device_add(td->device_model, id, "{'core-id':%u}", c);
>>          g_free(id);
>> @@ -148,7 +148,7 @@ static void add_pc_test_case(const char *mname)
>>      data->sockets = 1;
>>      data->cores = 3;
>>      data->threads = 2;
>> -    data->maxcpus = data->sockets * data->cores * data->threads * 2;
>> +    data->maxcpus = data->sockets * data->cores * data->threads;
>>      if (g_str_has_suffix(mname, "-1.4") ||
>>          (strcmp(mname, "pc-1.3") == 0) ||
>>          (strcmp(mname, "pc-1.2") == 0) ||
>> @@ -203,7 +203,7 @@ static void add_pseries_test_case(const char *mname)
>>      data->sockets = 2;
>>      data->cores = 3;
>>      data->threads = 1;
>> -    data->maxcpus = data->sockets * data->cores * data->threads * 2;
>> +    data->maxcpus = data->sockets * data->cores * data->threads;
>>  
>>      path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
>>                             mname, data->sockets, data->cores,
>> @@ -229,7 +229,7 @@ static void add_s390x_test_case(const char *mname)
>>      data->sockets = 1;
>>      data->cores = 3;
>>      data->threads = 1;
>> -    data->maxcpus = data->sockets * data->cores * data->threads * 2;
>> +    data->maxcpus = data->sockets * data->cores * data->threads;
>>  
>>      data2 = g_memdup(data, sizeof(PlugTestData));
>>      data2->machine = g_strdup(data->machine);
>>
>>
> 

This patch with Igor Signed-off-by:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
