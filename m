Received: from eggs.gnu.org ([2001:4830:134:3::10]:37335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mohun106@gmail.com>) id 1csxf9-0006jx-HT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mohun106@gmail.com>) id 1csxf7-0001N6-NQ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:24:19 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mohun106@gmail.com>) id 1csxf7-0001N1-Fk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:24:17 -0400
Received: by mail-pg0-x22e.google.com with SMTP id n5so75265041pgh.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 13:24:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328201623.GD20211@cbox>
References: <CAC8NTUUWuH4k7SZSus_hz6a6V+OLGYUFcSOUwVbji2YDAZbVdQ@mail.gmail.com>
	<20170328201623.GD20211@cbox>
From: Radha Mohan <mohun106@gmail.com>
Date: Tue, 28 Mar 2017 13:24:15 -0700
Message-ID: <CAC8NTUVPoH=ZiJ51EoOLPKhsyGKo5iszkhHzb5K8Heax3n2KuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] host stalls when qemu-system-aarch64 with kvm and
 pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <cdall@linaro.org>
Cc: qemu-devel@nongnu.org, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>

On Tue, Mar 28, 2017 at 1:16 PM, Christoffer Dall <cdall@linaro.org> wrote:
> Hi Radha,
>
> On Tue, Mar 28, 2017 at 12:58:24PM -0700, Radha Mohan wrote:
>> Hi,
>> I am seeing an issue with qemu-system-aarch64 when using pflash
>> (booting kernel via UEFI bios).
>>
>> Host kernel: 4.11.0-rc3-next-20170323
>> Qemu version: v2.9.0-rc1
>>
>> Command used:
>> ./aarch64-softmmu/qemu-system-aarch64 -cpu host -enable-kvm -M
>> virt,gic_version=3 -nographic -smp 1 -m 2048 -drive
>> if=none,id=hd0,file=/root/zesty-server-cloudimg-arm64.img,id=0 -device
>> virtio-blk-device,drive=hd0 -pflash /root/flash0.img -pflash
>> /root/flash1.img
>>
>>
>> As soon as the guest kernel boots the host starts to stall and prints
>> the below messages. And the system never recovers. I can neither
>> poweroff the guest nor the host. So I have resort to external power
>> reset of the host.
>>
>> ==================
>> [  116.199077] NMI watchdog: BUG: soft lockup - CPU#25 stuck for 23s!
>> [kworker/25:1:454]
>> [  116.206901] Modules linked in: binfmt_misc nls_iso8859_1 aes_ce_blk
>> shpchp crypto_simd gpio_keys cryptd aes_ce_cipher ghash_ce sha2_ce
>> sha1_ce uio_pdrv_genirq uio autofs4 btrfs raid10 rai
>> d456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>> raid6_pq libcrc32c raid1 raid0 multipath linear ast i2c_algo_bit ttm
>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_s
>> ys_fops drm nicvf ahci nicpf libahci thunder_bgx thunder_xcv
>> mdio_thunder mdio_cavium
>>
>> [  116.206995] CPU: 25 PID: 454 Comm: kworker/25:1 Not tainted
>> 4.11.0-rc3-next-20170323 #1
>> [  116.206997] Hardware name: www.cavium.com crb-1s/crb-1s, BIOS 0.3 Feb 23 2017
>> [  116.207010] Workqueue: events netstamp_clear
>> [  116.207015] task: ffff801f906b5400 task.stack: ffff801f901a4000
>> [  116.207020] PC is at smp_call_function_many+0x284/0x2e8
>> [  116.207023] LR is at smp_call_function_many+0x244/0x2e8
>> [  116.207026] pc : [<ffff000008156ecc>] lr : [<ffff000008156e8c>]
>> pstate: 80000145
>> [  116.207028] sp : ffff801f901a7be0
>> [  116.207030] x29: ffff801f901a7be0 x28: ffff000009139000
>> [  116.207036] x27: ffff000009139434 x26: 0000000000000080
>> [  116.207041] x25: 0000000000000000 x24: ffff0000081565d0
>> [  116.207047] x23: 0000000000000001 x22: ffff000008e11e00
>> [  116.207052] x21: ffff801f6d5cff00 x20: ffff801f6d5cff08
>> [  116.207057] x19: ffff000009138e38 x18: 0000000000000a03
>> [  116.207063] x17: 0000ffffb77c9028 x16: ffff0000082e81d8
>> [  116.207068] x15: 00003d0d6dd44d08 x14: 0036312196549b4a
>> [  116.207073] x13: 0000000058dabe4c x12: 0000000000000018
>> [  116.207079] x11: 00000000366e2f04 x10: 00000000000009f0
>> [  116.207084] x9 : ffff801f901a7d30 x8 : 0000000000000002
>> [  116.207089] x7 : 0000000000000000 x6 : 0000000000000000
>> [  116.207095] x5 : ffffffff00000000 x4 : 0000000000000020
>> [  116.207100] x3 : 0000000000000020 x2 : 0000000000000000
>> [  116.207105] x1 : ffff801f6d682578 x0 : 0000000000000003
>>
>> [  150.443116] INFO: rcu_sched self-detected stall on CPU
>> [  150.448261]  25-...: (14997 ticks this GP)
>> idle=47a/140000000000001/0 softirq=349/349 fqs=7495
>> [  150.451115] INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  150.451123]  25-...: (14997 ticks this GP)
>> idle=47a/140000000000001/0 softirq=349/349 fqs=7495
>> [  150.451124]  (detected by 13, t=15002 jiffies, g=805, c=804, q=8384)
>> [  150.451136] Task dump for CPU 25:
>> [  150.451138] kworker/25:1    R  running task        0   454      2 0x00000002
>> [  150.451155] Workqueue: events netstamp_clear
>> [  150.451158] Call trace:
>> [  150.451164] [<ffff000008086188>] __switch_to+0x90/0xa8
>> [  150.451172] [<ffff0000081f6240>] static_key_slow_inc+0x128/0x138
>> [  150.451175] [<ffff0000081f6284>] static_key_enable+0x34/0x60
>> [  150.451178] [<ffff000008843268>] netstamp_clear+0x68/0x80
>> [  150.451181] [<ffff0000080e49a0>] process_one_work+0x158/0x478
>> [  150.451183] [<ffff0000080e4d10>] worker_thread+0x50/0x4a8
>> [  150.451187] [<ffff0000080ebd78>] kthread+0x108/0x138
>> [  150.451190] [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>> [  150.477451]   (t=15008 jiffies g=805 c=804 q=8384)
>> [  150.482242] Task dump for CPU 25:
>> [  150.482245] kworker/25:1    R  running task        0   454      2 0x00000002
>> [  150.482259] Workqueue: events netstamp_clear
>> [  150.482264] Call trace:
>> [  150.482271] [<ffff00000808a530>] dump_backtrace+0x0/0x2b0
>> [  150.482277] [<ffff00000808a804>] show_stack+0x24/0x30
>> [  150.482281] [<ffff0000080fb750>] sched_show_task+0x128/0x178
>> [  150.482285] [<ffff0000080fd298>] dump_cpu_task+0x48/0x58
>> [  150.482288] [<ffff0000081f81e4>] rcu_dump_cpu_stacks+0xa0/0xe8
>> [  150.482297] [<ffff00000813983c>] rcu_check_callbacks+0x774/0x938
>> [  150.482305] [<ffff00000813fcb4>] update_process_times+0x34/0x60
>> [  150.482314] [<ffff000008151b80>] tick_sched_handle.isra.7+0x38/0x70
>> [  150.482319] [<ffff000008151c04>] tick_sched_timer+0x4c/0x98
>> [  150.482324] [<ffff000008140510>] __hrtimer_run_queues+0xd8/0x2b8
>> [  150.482328] [<ffff000008141180>] hrtimer_interrupt+0xa8/0x228
>> [  150.482334] [<ffff0000087f2a2c>] arch_timer_handler_phys+0x3c/0x50
>> [  150.482341] [<ffff00000812c194>] handle_percpu_devid_irq+0x8c/0x230
>> [  150.482344] [<ffff000008126174>] generic_handle_irq+0x34/0x50
>> [  150.482347] [<ffff000008126898>] __handle_domain_irq+0x68/0xc0
>> [  150.482351] [<ffff0000080817e4>] gic_handle_irq+0xc4/0x170
>> [  150.482356] Exception stack(0xffff801f901a7ab0 to 0xffff801f901a7be0)
>> [  150.482360] 7aa0:
>> 0000000000000003 ffff801f6d682578
>> [  150.482364] 7ac0: 0000000000000000 0000000000000020
>> 0000000000000020 ffffffff00000000
>> [  150.482367] 7ae0: 0000000000000000 0000000000000000
>> 0000000000000002 ffff801f901a7d30
>> [  150.482371] 7b00: 00000000000009f0 00000000366e2f04
>> 0000000000000018 0000000058dabe4c
>> [  150.482375] 7b20: 0036312196549b4a 00003d0d6dd44d08
>> ffff0000082e81d8 0000ffffb77c9028
>> [  150.482378] 7b40: 0000000000000a03 ffff000009138e38
>> ffff801f6d5cff08 ffff801f6d5cff00
>> [  150.482382] 7b60: ffff000008e11e00 0000000000000001
>> ffff0000081565d0 0000000000000000
>> [  150.482386] 7b80: 0000000000000080 ffff000009139434
>> ffff000009139000 ffff801f901a7be0
>> [  150.482390] 7ba0: ffff000008156e8c ffff801f901a7be0
>> ffff000008156ecc 0000000080000145
>> [  150.482394] 7bc0: ffff801f901a7be0 ffff000008156e68
>> ffffffffffffffff ffff000008156e8c
>> [  150.482397] [<ffff000008082ff4>] el1_irq+0xb4/0x140
>> [  150.482401] [<ffff000008156ecc>] smp_call_function_many+0x284/0x2e8
>> [  150.482405] [<ffff000008157020>] kick_all_cpus_sync+0x30/0x38
>> [  150.482409] [<ffff00000897c6cc>] aarch64_insn_patch_text+0xec/0xf8
>> [  150.482415] [<ffff000008095978>] arch_jump_label_transform+0x60/0x98
>> [  150.482420] [<ffff0000081f593c>] __jump_label_update+0x8c/0xa8
>> [  150.482423] [<ffff0000081f6088>] jump_label_update+0x58/0xe8
>> [  150.482429] [<ffff0000081f6240>] static_key_slow_inc+0x128/0x138
>> [  150.482434] [<ffff0000081f6284>] static_key_enable+0x34/0x60
>> [  150.482438] [<ffff000008843268>] netstamp_clear+0x68/0x80
>> [  150.482441] [<ffff0000080e49a0>] process_one_work+0x158/0x478
>> [  150.482444] [<ffff0000080e4d10>] worker_thread+0x50/0x4a8
>> [  150.482448] [<ffff0000080ebd78>] kthread+0x108/0x138
>> [  150.482451] [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>>
>> ====================================
>>
>> I am observing that this usually happens when the guest tries to
>> bringup or use the default virtio-net interface.
>> And I am unable to reproduce this when directly booting the guest
>> kernel without UEFI BIOS.
>> So anyone observed similar issue ?
>>
>
> I haven't seen this myself.
>
> Have you tried with other versions of QEMU and the host kernel by any
> chance using the same setup?

The earlier qemu version (atleast 2.5 which is default on ubuntu
16.04) have different issue. The same thing happens when I use
vhost=on but without vhost and with virtio-net didn't see the issue.
The Armband folks have also reported the vhost issue here
https://bugs.launchpad.net/ubuntu/+source/edk2/+bug/1673564

So I am beginning to think the issue could be related to the flash
emulation but wanted to check on ml if anyone else is seeing it. But
if it is flash emulation how can it hose the host like this ?

I will also try with qemu 2.8 and see.

>
> Thanks for reporting this,
> -Christoffer
