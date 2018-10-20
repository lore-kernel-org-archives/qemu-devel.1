Received: from eggs.gnu.org ([2001:4830:134:3::10]:49582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDo0u-0000qJ-RM
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 05:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDo0r-0007TV-Je
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 05:57:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDo0r-0007T3-AM
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 05:57:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so5803937wmf.1
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 02:57:41 -0700 (PDT)
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-4-f4bug@amsat.org>
	<0553e4ed-fab7-f286-52a0-8bd5240172a0@redhat.com>
	<1110cc09-cec1-23f6-bcd8-524e89ca0c73@redhat.com>
	<2c2566b9-21ce-7e88-aa9e-d1ba859a6561@redhat.com>
	<4b97ea06-f5fd-e9d9-cc57-bbbbc6c14dc0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36b5ae19-e97a-e53f-2b35-dff0d709b06c@redhat.com>
Date: Sat, 20 Oct 2018 11:57:36 +0200
MIME-Version: 1.0
In-Reply-To: <4b97ea06-f5fd-e9d9-cc57-bbbbc6c14dc0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests/acceptance: Add
 test_mips_4kc_malta in BootLinuxConsole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 20/10/2018 00:51, Cleber Rosa wrote:
> 
> 
> On 10/19/18 5:17 PM, Cleber Rosa wrote:
>>
>>
>> On 10/19/18 2:41 PM, Philippe Mathieu-Daudé wrote:
>>> On 19/10/2018 19:42, Cleber Rosa wrote:
>>>>
>>>>
>>>> On 10/13/18 11:15 AM, Philippe Mathieu-Daudé wrote:
>>>>> Similar to the test_x86_64_pc test, this boots a Linux kernel on a
>>>>> Malta board (MIPS 4Kc big-endian) and verify the serial is working.
>>>>>
>>>>> This test requires the dpkg-deb tool (apt/dnf install dpkg) to
>>>>> extract the kernel from the Debian package.
>>>>>
>>>>
>>>> Debian packages are really "ar" archives, with a control.tar.gz and
>>>> data.tar.gz in them.  More on that later.
>>>>
>>>>>   $ avocado --show=console run -p arch=mips tests/acceptance/boot_linux_console.py
>>>>>   console: [    0.000000] Initializing cgroup subsys cpuset
>>>>>   console: [    0.000000] Initializing cgroup subsys cpu
>>>>>   console: [    0.000000] Linux version 2.6.32-5-4kc-malta (Debian 2.6.32-48) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 Sat Feb 16 12:43:42 UTC 2013
>>>>>   console: [    0.000000]
>>>>>   console: [    0.000000] LINUX started...
>>>>>   console: [    0.000000] bootconsole [early0] enabled
>>>>>   console: [    0.000000] CPU revision is: 00019300 (MIPS 24Kc)
>>>>>   console: [    0.000000] FPU revision is: 00739300
>>>>>   console: [    0.000000] Determined physical RAM map:
>>>>>   console: [    0.000000]  memory: 00001000 @ 00000000 (reserved)
>>>>>   console: [    0.000000]  memory: 000ef000 @ 00001000 (ROM data)
>>>>>   console: [    0.000000]  memory: 005b7000 @ 000f0000 (reserved)
>>>>>   console: [    0.000000]  memory: 03958000 @ 006a7000 (usable)
>>>>>   console: [    0.000000] Wasting 54496 bytes for tracking 1703 unused pages
>>>>>   console: [    0.000000] Initrd not found or empty - disabling initrd
>>>>>   console: [    0.000000] Zone PFN ranges:
>>>>>   console: [    0.000000]   DMA      0x00000000 -> 0x00001000
>>>>>   console: [    0.000000]   Normal   0x00001000 -> 0x00003fff
>>>>>   console: [    0.000000] Movable zone start PFN for each node
>>>>>   console: [    0.000000] early_node_map[1] active PFN ranges
>>>>>   console: [    0.000000]     0: 0x00000000 -> 0x00003fff
>>>>>   console: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16255
>>>>>   console: [    0.000000] Kernel command line: console=ttyS0 printk.time=0
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>>  tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
>>>>>  1 file changed, 46 insertions(+)
>>>>>
>>>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>>>>> index 3aa4dbe5f9..81c96fc338 100644
>>>>> --- a/tests/acceptance/boot_linux_console.py
>>>>> +++ b/tests/acceptance/boot_linux_console.py
>>>>> @@ -9,6 +9,7 @@
>>>>>  # later.  See the COPYING file in the top-level directory.
>>>>>  
>>>>>  import logging
>>>>> +import subprocess
>>>>
>>>> It's definitely your call, but I like to think that
>>>> avocado.utils.process provides simpler and more capable functions:
>>>>
>>>> https://avocado-framework.readthedocs.io/en/65.0/api/utils/avocado.utils.html#avocado.utils.process.run
>>>
>>> OK
>>>
>>>>
>>>>>  
>>>>>  from avocado_qemu import Test
>>>>>  
>>>>> @@ -47,3 +48,48 @@ class BootLinuxConsole(Test):
>>>>>                  break
>>>>>              if 'Kernel panic - not syncing' in msg:
>>>>>                  self.fail("Kernel panic reached")
>>>>> +
>>>>> +    def test_mips_4kc_malta(self):
>>>>> +        """
>>>>> +        This test requires the dpkg-deb tool (apt/dnf install dpkg) to extract
>>>>> +        the kernel from the Debian package.
>>>>> +
>>>>> +        The kernel can be rebuilt using this Debian kernel source [1] and
>>>>> +        following the instructions on [2].
>>>>> +
>>>>> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official
>>>>> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-source-2.6.32_2.6.32-48
>>>>> +
>>>>> +        :avocado: tags=arch:mips
>>>>> +        """
>>>>> +        if self.arch != 'mips': # FIXME use 'arch' tag in parent class?
>>>>> +            self.cancel('Currently specific to the %s target arch' % self.arch)
>>>>> +
>>>>
>>>> I missed how the arch tag in the parent class (common to all tests here)
>>>> would be useful for this specific test.
>>>
>>> I probably forgot to remove it.
>>>
>>
>> I think I now know what you meant.  With the current approach we have:
>>
>> $ avocado run -p arch=x86_64 tests/acceptance/boot_linux_console.py
>> JOB ID     : 3209c26bceffc372f245b121d6ac77a7e36e7134
>> JOB LOG    :
>> /home/cleber/avocado/job-results/job-2018-10-19T16.58-3209c26/job.log
>>  (1/2)
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:
>> PASS (2.05 s)
>>  (2/2)
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta:
>> CANCEL: Currently specific to the x86_64 target arch (0.00 s)
>> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
>> CANCEL 1
>> JOB TIME   : 2.21 s
>>
>> There's a bug in the CANCEL message, because the test is "mips" specific
>> and not specific to the arch parameter given.  I believe you'd like to
>> reuse the arch given in the "tags=", right?
>>
> 
> Continuing on this assumption (that it can be useful to access the tags
> during the test) I prototype this:
> 
> https://github.com/clebergnu/avocado/commit/7c5b04ed76bad5570f05e24ce168c8477283424d
> 
> And with that, this on top of this commit:
> 
> https://github.com/clebergnu/qemu/commit/359b8b4e10575646a2efa1bcb58ab74053233514
> 
> Basically, it allows one to run many arch specific tests at once,
> without specifying/restricting one arch:
> 
> $ avocado run tests/acceptance/boot_linux_console.py
> JOB ID     : 3ade8b6c547f853e1b169cd1846f69f5221fd9f0
> JOB LOG    :
> /home/cleber/avocado/job-results/job-2018-10-19T18.30-3ade8b6/job.log
>  (1/2)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:
> PASS (2.00 s)
>  (2/2)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta:
> PASS (0.53 s)
> RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
> CANCEL 0
> JOB TIME   : 2.70 s
> 
> And the proper behavior when setting a arch:
> 
> $ avocado run -p arch=mips tests/acceptance/boot_linux_console.py
> JOB ID     : 75902f6b02707c9c0d509229f092e14e8b2f3933
> JOB LOG    :
> /home/cleber/avocado/job-results/job-2018-10-19T18.50-75902f6/job.log
>  (1/2)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:
> CANCEL: Currently specific to the targets: x86_64 (0.00 s)
>  (2/2)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_malta:
> PASS (0.54 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
> CANCEL 1
> JOB TIME   : 0.71 s
> 
> How does that look?

YES! This is _exactly_ what I wanted and how I plan to use this framework :)

> 
> - Cleber.
> 
>> - Cleber.
>>
>>>>
>>>>> +        deb_url = ('http://snapshot.debian.org/archive/debian/20130217T032700Z/'
>>>>> +                   'pool/main/l/linux-2.6/'
>>>>> +                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
>>>>> +        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
>>>>> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>>> +        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self.workdir]) # FIXME move to avocado ...
>>>>
>>>> This could become:
>>>>
>>>>  # from avocado.utils.process import run
>>>>  run("ar p %s data.tar.gz | tar zxf - -C %s
>>>> ./boot/vmlinux-2.6.32-5-4kc-malta" % (deb_path, self.workdir), shell=True)
>>>
>>> OK!
>>>
>>>>
>>>>> +        kernel_path = self.workdir + '/boot/vmlinux-2.6.32-5-4kc-malta'          # FIXME ... and use from assets?
>>>>> +
>>>>
>>>> Putting produced/processed files back into the cache would be nice
>>>> addition to the asset fetcher (or related tools).  Not there yet, though.
>>>
>>> OK :/
>>>
>>>>
>>>>> +        self.vm.set_arch(self.arch)
>>>>> +        self.vm.set_machine('malta')
>>>>> +        self.vm.set_console("") # XXX this disable isa-serial to use -serial ...
>>>>
>>>> See the comments on the previous patch.  Basically, if a machine doesn't
>>>> need an explicit console device to be added, set_console() should do
>>>> just that (not add one).  The ideal API would be to call set_console()
>>>> without any explicit parameter IMO.
>>>
>>> Sure.
>>>
>>>>
>>>> That assumes, what I believe to be true, that we don't want to setup
>>>> multiple *console* devices per QEMUMachine, right?
>>>
>>> There might be weird corner-cases but usually machines only have one
>>> type of (default) console.
>>>
>>>>
>>>> Regards,
>>>> - Cleber.
>>>>
>>>>> +        kernel_command_line = 'console=ttyS0 printk.time=0'
>>>>> +        self.vm.add_args('-m', "64",
>>>>> +                         '-serial', "chardev:console", # XXX ... here.
>>>>> +                         '-kernel', kernel_path,
>>>>> +                         '-append', kernel_command_line)
>>>>> +
>>>>> +        # FIXME below to parent class?
>>>>> +        self.vm.launch()
>>>>> +        console = self.vm.console_socket.makefile()
>>>>> +        console_logger = logging.getLogger('console')
>>>>> +        while True:
>>>>> +            msg = console.readline()
>>>>> +            console_logger.debug(msg.strip())
>>>>> +            if 'Kernel command line: %s' % kernel_command_line in msg:
>>>>> +                break
>>>>> +            if 'Kernel panic - not syncing' in msg:
>>>>> +                self.fail("Kernel panic reached")
>>>>>
>>>>
>>
> 
