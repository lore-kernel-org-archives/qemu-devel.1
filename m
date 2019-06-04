Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA9C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC62249DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC62249DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY8Bg-0004Wd-4B
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 08:05:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hY84W-0007vE-GD
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hY7ym-0008Bl-4j
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hY7yl-0008Ap-Tc
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:51:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62A4230BB559;
	Tue,  4 Jun 2019 11:51:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCCA35B683;
	Tue,  4 Jun 2019 11:51:37 +0000 (UTC)
Date: Tue, 4 Jun 2019 13:51:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190604135133.28b25ea8@redhat.com>
In-Reply-To: <9e26a7e9-31a5-c0ef-45f2-617051fd02b7@redhat.com>
References: <1559560929-260254-1-git-send-email-imammedo@redhat.com>
	<1559560929-260254-3-git-send-email-imammedo@redhat.com>
	<9e26a7e9-31a5-c0ef-45f2-617051fd02b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 04 Jun 2019 11:51:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 2/2] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 18:08:12 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 06/03/19 13:22, Igor Mammedov wrote:
> > adds simple arm/virt test case that starts guest with
> > bios-tables-test.aarch64.iso.qcow2 boot image which
> > initializes UefiTestSupport* structure in RAM once
> > guest is booted.
> > 
> >  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v6:
> >   * Since aarch64 TCG is broken on 32 bit arm host,
> >     blacklist it till it's fixed
> >   * add aarch64 to rebuild script list
> > v4:
> >   * force test to use TCG accelerator
> > v3:
> >   * use firmware blobs directly from pc-bios directory
> >   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
> >   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
> >     previos version (Laszlo)
> >   * add Makefile rule to include bios-tables-test into
> >     check-qtest-aarch64 target
> > v2:
> >   * specify in test_data where board's RAM starts and RAM size
> > 
> >  tests/Makefile.include                  |  4 ++++
> >  tests/bios-tables-test.c                | 18 ++++++++++++++++++
> >  tests/data/acpi/rebuild-expected-aml.sh |  2 +-
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 1865f6b..2334969 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -267,6 +267,10 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
> >  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> >  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> >  check-qtest-aarch64-y += tests/migration-test$(EXESUF)
> > +# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional  
> 
> I think you could also capture the following link here, in a comment:
> 
> # https://bugs.launchpad.net/qemu/+bug/1830872
Michael,
 could you fix it up on commit?
or we could merge v4
   [PATCH v4 13/15] tests: acpi: add simple arm/virt  testcase
which is the same modulo this blacklisting hunk, if
   [RFC PATCH] cputlb: use uint64_t for interim values  for unaligned load
fix is used as prerequisite.

> 
> > +ifneq ($(ARCH),arm)  
> 
> Can we exclude all 32-bit host arches, not just ARM? The discussion in
> LP#1830872 indicates aarch64-on-i386 can fail too (not this specific
> guest payload FWIW, but the "tests/memory" test).
I'd guess it's topic for a separate discussion (considering bios-tables-test
isn't affected it's probably not upto me to pull this trigger).

> 
> Other than that:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Thanks!

> 
> Thanks,
> Laszlo
> 
> 
> > +check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
> > +endif
> >  
> >  check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
> >  
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 28d7d42..1242d63 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -830,6 +830,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
> >      test_acpi_tcg_dimm_pxm(MACHINE_PC);
> >  }
> >  
> > +static void test_acpi_virt_tcg(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .accel = "tcg",
> > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > +        .ram_start = 0x40000000ULL,
> > +        .scan_len = 128ULL * 1024 * 1024,
> > +    };
> > +
> > +    test_acpi_one("-cpu cortex-a57", &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      const char *arch = qtest_get_arch();
> > @@ -858,6 +874,8 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
> >          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
> >          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> > +    } else if (strcmp(arch, "aarch64") == 0) {
> > +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> >      }
> >      ret = g_test_run();
> >      boot_sector_cleanup(disk);
> > diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> > index ff7e622..d285321 100755
> > --- a/tests/data/acpi/rebuild-expected-aml.sh
> > +++ b/tests/data/acpi/rebuild-expected-aml.sh
> > @@ -12,7 +12,7 @@
> >  # This work is licensed under the terms of the GNU GPLv2.
> >  # See the COPYING.LIB file in the top-level directory.
> >  
> > -qemu_bins="x86_64-softmmu/qemu-system-x86_64"
> > +qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
> >  
> >  if [ ! -e "tests/bios-tables-test" ]; then
> >      echo "Test: bios-tables-test is required! Run make check before this script."
> >   
> 


