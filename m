Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53532C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEC120859
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEC120859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYD0m-00086t-D0
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:14:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYD00-0007nJ-JS
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCzz-0004yn-6h
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:13:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYCzz-0004yO-2I
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:13:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so14694343qto.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 10:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=3lE+9X7pwAsz/e6j1Xj+FZVr6kk6Av0U/9MA4AYZKLY=;
	b=WAVopGviB8xt+zicQdj+elcDp5hMbDqdZKeHfPqn0VCwpYgTvuTo2bwVv0RDRLoW+o
	OJ7XYTsSzvcqPGyZANHwjfzOtSiJzflS4Zv1MNkGt4VyTnGOmCgcZKwfXYXRmo2WNrhw
	DVBZFctpvyWETKwLsSyaRkyxetAwx5CoIJLumabd4cULkAp5+IfesohZfLqiX7I9q1q7
	zeUgxUiXWth33uZdt2es7d53Wy08BRBjZaGFdJpQtS9DHeQgVJcBsJT3f1rm95TxIEcE
	Eruprf/C+XS1sAMRbvTroHm942u2w5Yan/+0XFz1vGkdICuSKwuMOEgKYyBShf+GhFRl
	EoXg==
X-Gm-Message-State: APjAAAUi/hsNcCxpZNZezDoPxAldB8K51MYT+L0S1fXkYCNufXV7Xfug
	95+MK9z4FujCB6hka/YUePK6Dw==
X-Google-Smtp-Source: APXvYqziUUWrf6WpYrP3vH5bYIBpvYWDYhBQrR1DY4CKTQtdVWeVj6cvhh8P869eGzjse5gNev+A9w==
X-Received: by 2002:ac8:2fce:: with SMTP id m14mr9965864qta.22.1559668402501; 
	Tue, 04 Jun 2019 10:13:22 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	d141sm5167522qke.3.2019.06.04.10.13.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 10:13:21 -0700 (PDT)
Date: Tue, 4 Jun 2019 13:13:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190604131243-mutt-send-email-mst@kernel.org>
References: <1559560929-260254-1-git-send-email-imammedo@redhat.com>
	<1559560929-260254-3-git-send-email-imammedo@redhat.com>
	<9e26a7e9-31a5-c0ef-45f2-617051fd02b7@redhat.com>
	<20190604135133.28b25ea8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604135133.28b25ea8@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
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
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 01:51:33PM +0200, Igor Mammedov wrote:
> On Mon, 3 Jun 2019 18:08:12 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
> > On 06/03/19 13:22, Igor Mammedov wrote:
> > > adds simple arm/virt test case that starts guest with
> > > bios-tables-test.aarch64.iso.qcow2 boot image which
> > > initializes UefiTestSupport* structure in RAM once
> > > guest is booted.
> > > 
> > >  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > v6:
> > >   * Since aarch64 TCG is broken on 32 bit arm host,
> > >     blacklist it till it's fixed
> > >   * add aarch64 to rebuild script list
> > > v4:
> > >   * force test to use TCG accelerator
> > > v3:
> > >   * use firmware blobs directly from pc-bios directory
> > >   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
> > >   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
> > >     previos version (Laszlo)
> > >   * add Makefile rule to include bios-tables-test into
> > >     check-qtest-aarch64 target
> > > v2:
> > >   * specify in test_data where board's RAM starts and RAM size
> > > 
> > >  tests/Makefile.include                  |  4 ++++
> > >  tests/bios-tables-test.c                | 18 ++++++++++++++++++
> > >  tests/data/acpi/rebuild-expected-aml.sh |  2 +-
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index 1865f6b..2334969 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -267,6 +267,10 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
> > >  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> > >  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> > >  check-qtest-aarch64-y += tests/migration-test$(EXESUF)
> > > +# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional  
> > 
> > I think you could also capture the following link here, in a comment:
> > 
> > # https://bugs.launchpad.net/qemu/+bug/1830872
> Michael,
>  could you fix it up on commit?

I prefer just seeing a fixed up patch.

> or we could merge v4
>    [PATCH v4 13/15] tests: acpi: add simple arm/virt  testcase
> which is the same modulo this blacklisting hunk, if
>    [RFC PATCH] cputlb: use uint64_t for interim values  for unaligned load
> fix is used as prerequisite.
> 
> > 
> > > +ifneq ($(ARCH),arm)  
> > 
> > Can we exclude all 32-bit host arches, not just ARM? The discussion in
> > LP#1830872 indicates aarch64-on-i386 can fail too (not this specific
> > guest payload FWIW, but the "tests/memory" test).
> I'd guess it's topic for a separate discussion (considering bios-tables-test
> isn't affected it's probably not upto me to pull this trigger).
> 
> > 
> > Other than that:
> > 
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Thanks!
> 
> > 
> > Thanks,
> > Laszlo
> > 
> > 
> > > +check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
> > > +endif
> > >  
> > >  check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
> > >  
> > > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > > index 28d7d42..1242d63 100644
> > > --- a/tests/bios-tables-test.c
> > > +++ b/tests/bios-tables-test.c
> > > @@ -830,6 +830,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
> > >      test_acpi_tcg_dimm_pxm(MACHINE_PC);
> > >  }
> > >  
> > > +static void test_acpi_virt_tcg(void)
> > > +{
> > > +    test_data data = {
> > > +        .machine = "virt",
> > > +        .accel = "tcg",
> > > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > > +        .ram_start = 0x40000000ULL,
> > > +        .scan_len = 128ULL * 1024 * 1024,
> > > +    };
> > > +
> > > +    test_acpi_one("-cpu cortex-a57", &data);
> > > +    free_test_data(&data);
> > > +}
> > > +
> > >  int main(int argc, char *argv[])
> > >  {
> > >      const char *arch = qtest_get_arch();
> > > @@ -858,6 +874,8 @@ int main(int argc, char *argv[])
> > >          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
> > >          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
> > >          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> > > +    } else if (strcmp(arch, "aarch64") == 0) {
> > > +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> > >      }
> > >      ret = g_test_run();
> > >      boot_sector_cleanup(disk);
> > > diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> > > index ff7e622..d285321 100755
> > > --- a/tests/data/acpi/rebuild-expected-aml.sh
> > > +++ b/tests/data/acpi/rebuild-expected-aml.sh
> > > @@ -12,7 +12,7 @@
> > >  # This work is licensed under the terms of the GNU GPLv2.
> > >  # See the COPYING.LIB file in the top-level directory.
> > >  
> > > -qemu_bins="x86_64-softmmu/qemu-system-x86_64"
> > > +qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
> > >  
> > >  if [ ! -e "tests/bios-tables-test" ]; then
> > >      echo "Test: bios-tables-test is required! Run make check before this script."
> > >   
> > 

