Received: from eggs.gnu.org ([2001:4830:134:3::10]:54690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqGM-000502-HN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqGI-0002rV-9b
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:26:54 -0500
Received: from [59.151.112.132] (port=26226 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqGH-0002pL-A2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:26:50 -0500
References: <148474442644.214.12638212197331646848@790289a7ca88>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <21a27c35-8495-3b55-b809-5499118660b9@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 21:26:36 +0800
MIME-Version: 1.0
In-Reply-To: <148474442644.214.12638212197331646848@790289a7ca88>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] cpu: numa: Fix the mapping
 initialization of VCPUs and NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, imammedo@redhat.com, vilanova@ac.upc.edu

Hi, All

> **
> ERROR:/tmp/qemu-test/src/tests/vhost-user-test.c:668:test_migrate: assertion failed: (qdict_haskey(rsp, "return"))
> GTester: last random seed: R02Sf52546c4daff8087416f43fa7c146db8
> ftruncate: Permission denied
> ftruncate: Permission denied
> qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> Broken pipe

I don't know What's the meaning of this log ?

Is the qemu-system-aarch64 can't recognize the
qom/cpu.c:346: assert(cpu->cpu_index < max_cpus);

Thanks,
	Liyang


> GTester: last random seed: R02Sa39aa674143b4b48a89276d59eee19b3
> qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> Broken pipe
> GTester: last random seed: R02Sbd557f67296de3764183db6b2105d88b
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> Broken pipe
> GTester: last random seed: R02S79c36cf5f50e19956d11fbc925f86df0
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> Broken pipe
> GTester: last random seed: R02S1186d0871ff44bed258ec179722caf91
> qemu-system-aarch64: /tmp/qemu-test/src/qom/cpu.c:346: cpu_common_map_numa_node: Assertion `cpu->cpu_index < max_cpus' failed.
> Broken pipe
> GTester: last random seed: R02S3429594491b10489f9abab73dcc15151
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-3q9yfmbs/src'
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>
