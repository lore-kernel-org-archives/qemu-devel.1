Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A3C33C9E
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 02:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5274120658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 02:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnjNJ23M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5274120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy597-0003EG-FA
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 21:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy58X-0002mZ-7j
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 21:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy58V-0007Mw-7x
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 21:37:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iy58U-0007Kp-VB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 21:37:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id z9so1197702wrs.10
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 18:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O9WN59N7fpzHrHh9IR40pB7RzuYPBqgMSVdcmci4pGg=;
 b=NnjNJ23Mv8rr9FUb5hUUrBzpnf+dV+mVVrtn/SgfUFIjkEor+84O7Vy5MfTSV72Hn9
 YpkplUziAkdQxX7Bs6vbCKZOfgdoC3Wgh5SKgHxXnW74pSi2xsnvkHzL9N+93z6si20K
 TdpGundJtYM7ugRQXlJ2uuzGzWxyblsqlKKwSW2AM3jtpiY87YXL+4uaMxj0Lg+7EVYR
 nu4ig8831PWSBLRXiXflKINClKN438SYZgSz/IbOQ6G9vp6qtbGHEMS+m9D1RPrwqihF
 FLvkkyfP/ZcVuReLWPw+WLw31PuHJzhIKQgtXIV26nsJj4HyCrfBRAE86/JlB3mSDVL2
 OAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=O9WN59N7fpzHrHh9IR40pB7RzuYPBqgMSVdcmci4pGg=;
 b=Tu22ZRFf0p/Y9pVgh7RwutbhbA4JMdvd/2K01Icq8bXW3tHMDb+RVAHevU0RgqOUtx
 CT/CEk6w/A5loL/ZnQgZXl/1GC5niyuvsWEcpHv/j6ktVf97QVBL6gK6/DJi/X4+f0HE
 e/gOFTEAldBum3sE589sPAW1MC9dMxMunPpeuanRJJW1Ejsa2NVDs4cRSz/ejYaeq0ai
 htCdb7X9GF/JnW62h1VEjXG9G913t2hcHBMs6yn3a0nG/pjzeUD4q3xhYhYulQ0Q3pPp
 ue01ue2gM6E/qHCrt+1KQKYH6GvaoR3nX/FIpsT05z/0I2ZWOJeYlZFd3BE9JDsJ8aqy
 Irzg==
X-Gm-Message-State: APjAAAWHzD4Q/5cZlzlIS3/sMAmb+rnLqCjXAwaoUzaiSMNaBKKb5egf
 qZmQqqzns9UWzx/qFknPzus=
X-Google-Smtp-Source: APXvYqzEvkSeI1NApYFFBUea1QMK2XqNxu2qe7ikZW8mNkEkUkSKzcVwlW5SPVjTC1YxwgcZly9rmg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr7382663wrp.203.1580611041488; 
 Sat, 01 Feb 2020 18:37:21 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id u8sm17602073wmm.15.2020.02.01.18.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 18:37:20 -0800 (PST)
Subject: Re: [PULL 32/41] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <20200108034523.17349-33-richard.henderson@linaro.org>
 <7c714bf4-2e5c-c17b-5a06-72d63e06d3a4@amsat.org>
 <51ba939f-b90f-0413-aa37-4af427bb63e3@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <65a95bb8-8ccc-45ef-4163-e878b70eecf8@amsat.org>
Date: Sun, 2 Feb 2020 03:37:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <51ba939f-b90f-0413-aa37-4af427bb63e3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/1/20 11:07 PM, Philippe Mathieu-Daudé wrote:
> On 2/1/20 9:12 PM, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 1/8/20 4:45 AM, Richard Henderson wrote:
>>> The separate suffixed functions were used to construct
>>> some do_##insn function switched on mmu_idx.  The interface
>>> is exactly identical to the *_mmuidx_ra functions.  Replace
>>> them directly and remove the constructions.
>>>
>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> I'm seeing a regression since commit 7dd547e5a (however I'm not sure
>> this particular commit introduced the regression, or instead revealed it).
>>
>> I get a hang when booting a I6400 CPU on Malta:
>>
>> $ qemu-system-mips64el -cpu I6400 -serial stdio \
>>   -kernel vmlinux \
>>   -append "clocksource=GIC console=ttyS0 printk.time=1"
> 
> FYI this binary was built using:
> 
>   ./configure --target-list=mips64el-softmmu --disable-xen
> --disable-spice --disable-vnc --disable-rdma --disable-vde --disable-rbd
> --disable-smartcard --disable-libusb --disable-glusterfs --disable-tpm
> --disable-vhdx --disable-tools --disable-guest-agent --disable-docs
> --disable-vhost-vsock --extra-cflags='-Wno-format-truncation
> -Wno-stringop-truncation -Wno-address-of-packed-member'
> 
>> Linux version 4.7.0-rc1 (@859affe05464) (gcc version 6.3.0 20170516
>> (Debian 6.3.0-18) ) #2 SMP Sat Feb 1 18:16:17 UTC 2020
>> GCRs appear to have been moved (expected them at 0x1fbf8000)!
>> earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
>> bootconsole [uart8250] enabled
>> MIPS CPS SMP unable to proceed without a CM
>> CPU0 revision is: 0001a900 (MIPS I6400)
>> FPU revision is: 20f30300
>> MSA revision is: 00000300
>> MIPS: machine is mti,malta
>> Software DMA cache coherency enabled
>> Determined physical RAM map:
>>  memory: 0000000008000000 @ 0000000000000000 (usable)
>> Zone ranges:
>>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>   Normal   empty
>> Movable zone start for each node
>> Early memory node ranges
>>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
>> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
>> Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
>> percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u81920
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8163
>> Kernel command line: clocksource=GIC console=ttyS0 printk.time=1
>> [    0.000000] PID hash table entries: 512 (order: -2, 4096 bytes)
>> [    0.000000] Dentry cache hash table entries: 16384 (order: 3, 131072
>> bytes)
>> [    0.000000] Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
>> [    0.000000] Writing ErrCtl register=00000000
>> [    0.000000] Readback ErrCtl register=00000000
>> [    0.000000] MAAR configuration:
>> [    0.000000]   [0]: 0x0000000000010000-0x0000000007ffffff speculate
>> [    0.000000]   [1]: disabled
>> [    0.000000]   [2]: disabled
>> [    0.000000]   [3]: disabled
>> [    0.000000]   [4]: disabled
>> [    0.000000]   [5]: disabled
>> [    0.000000]   [6]: disabled
>> [    0.000000]   [7]: disabled
>> [    0.000000] Memory: 121728K/131072K available (5253K kernel code,
>> 380K rwdata, 1276K rodata, 304K init, 278K bss, 9344K reserved, 0K
>> cma-reserved)
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  Build-time adjustment of leaf fanout to 64.
>> [    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
>> [    0.000000] NR_IRQS:256
>> [    0.000000] CPU frequency 200.00 MHz
>> [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 19112598155 ns
>> [    0.000223] sched_clock: 32 bits at 100MHz, resolution 9ns, wraps
>> every 21474829307ns
>> [    0.008011] Console: colour dummy device 80x25
>> [    0.012181] Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
>> [    0.164015] pid_max: default: 32768 minimum: 301
>> [    0.165920] Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
>> [    0.166244] Mountpoint-cache hash table entries: 2048 (order: 0,
>> 16384 bytes)
>> [    0.202498] Brought up 1 CPUs
>> [    0.213199] devtmpfs: initialized
>> [    0.228877] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 19112604462750000 ns
>> [    0.236181] NET: Registered protocol family 16
>> [    0.253496] clocksource: pit: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 1601818034827 ns
>> [    0.254012] pm-cps: no CM, non-coherent states unavailable
>> [    0.257508] ------------[ cut here ]------------
>> [    0.258085] WARNING: CPU: 0 PID: 1 at fs/kernfs/dir.c:502
>> __kernfs_remove+0x250/0x258
>> [    0.258489] Modules linked in:
>> [   21.494186] INFO: rcu_sched detected stalls on CPUs/tasks:
>> [   21.494530]  (detected by 0, t=2102 jiffies, g=-299, c=-300, q=1)
>> [   21.494921] All QSes seen, last rcu_sched kthread activity 2101
>> (4294939419-4294937318), jiffies_till_next_fqs=1, root ->qsmask 0x0

I have been using this test:

---
class MaltaMachineI6400(Test):

    count = 15
    timeout = 50 * count

    def do_test_mips_malta_i6400_stall(self):
        """
        :avocado: tags=arch:mips64el
        :avocado: tags=machine:malta
        :avocado: tags=cpu:i6400
        """
        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
                      'a5966ca4b5/mips/malta/mips64el/'
                      'vmlinux-4.7.0-rc1.I6400.gz')
        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
        kernel_path_gz = self.fetch_asset(kernel_url,
asset_hash=kernel_hash)
        kernel_path = self.workdir + "vmlinux"
        archive.gzip_uncompress(kernel_path_gz, kernel_path)

        self.vm.set_console()
        kernel_command_line = ('printk.time=1 ' +
                               'clocksource=GIC console=tty0 console=ttyS0')
        self.vm.add_args('-kernel', kernel_path,
                         '-cpu', 'I6400',
                         '-smp', '8',
                         '-append', kernel_command_line)
        self.vm.launch()
        success_message = 'VFS: Cannot open root device "(null)"'
        wait_for_console_pattern(self, success_message,
                                 failure_message='detected stall')
        self.vm.shutdown()

    def test_mips_malta_i6400_stall(self):
        """
        :avocado: tags=arch:mips64el
        :avocado: tags=machine:malta
        :avocado: tags=cpu:i6400
        """
        logger = logging.getLogger('console')
        for i in range(self.count):
            logger.debug('\n' + '=' * 80)
            self.do_test_mips_malta_i6400_stall()
---

I started bisecting from current master to v2.9.1.

With v4.0.0 I get the stall:
console: [   23.066200] INFO: rcu_sched detected stalls on CPUs/tasks:

With v3.1.0 I couldn't.
PASS (305.11 s)

To be able to build and test multiple commits in parallel, I used the
'-p qemu_bin' option:

$ avocado --show=app,console run -t cpu:i6400 \
  -p qemu_bin=v4.0.0/mips64el-softmmu/qemu-system-mips64el \
  tests/acceptance/

Stats for the day:

$ ccache -s
stats zero time                     Sat Feb  1 13:48:09 2020
cache hit (direct)                 12001
cache hit (preprocessed)            7463
cache miss                         39856
cache hit rate                     32.81 %
called for link                    16945
called for preprocessing             187
compile failed                        65
preprocessor error                   210
couldn't find the compiler             1
unsupported compiler option          429
no input file                        293
cleanups performed                     0
files in cache                    104406
cache size                           7.9 GB

I'll stop commenting in this thread and create a launchpad bug.

Regards,

Phil.

