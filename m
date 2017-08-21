Received: from eggs.gnu.org ([2001:4830:134:3::10]:42121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djkoL-0002GV-Pf
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djkoI-0004bg-GV
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:24:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44614
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djkoI-0004ao-4c
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:23:58 -0400
References: <1502847935-20483-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<9e5b10ce-6259-a21b-01dc-13f57d28a0ef@cn.fujitsu.com>
	<20170818164852.GZ3108@localhost.localdomain>
	<e67b5c35-5077-2603-f0ca-6abcade205db@cn.fujitsu.com>
	<20170821105708.4391e201@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <6d8a9fae-fce8-c739-3e23-293cd201b91f@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 19:23:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170821105708.4391e201@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/acpi-build: Fix SRAT memory building
 when there is no memory in node0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

Hi, Igor

[...]
>>
>> Ok, I will do it right now.
>
> see commit 6b9c1dd2c for example of adding test case,
> currently test has base SRAT tables that is reused by all tests.
> When you create testcase that produces different SRAT table,
> 'make check' will print warnings that ables do not match
> you can add "V=1" env. var. 'make V=1 check' to get detailed
> diff of what's changed.
>
> also see how 'test_data.variant' is handled to get idea how to use
> it to differentiate specific test case vs shared ACPI tables baseline blobs.
>

Thanks for teaching me that, it's very helpful to me.

Except for adding a new case, can we except memhp testcase with
node RAM check? just like following shows:

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..c79ece4 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -788,7 +788,7 @@ static void test_acpi_q35_tcg_memhp(void)
      data.machine = MACHINE_Q35;
      data.variant = ".memhp";
      test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -numa node -numa node,mem=128"
                    " -numa dist,src=0,dst=1,val=21",
                    &data);
      free_test_data(&data);
@@ -802,7 +802,7 @@ static void test_acpi_piix4_tcg_memhp(void)
      data.machine = MACHINE_PC;
      data.variant = ".memhp";
      test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -numa node -numa node,mem=128"
                    " -numa dist,src=0,dst=1,val=21",
                    &data);
      free_test_data(&data);


Thanks,
	dou.
