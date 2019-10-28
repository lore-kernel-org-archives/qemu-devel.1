Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4521B20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4521B20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0a0-0006EB-Fi
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iP0ZA-0005bT-9B
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iP0Z8-0002vK-JL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iP0Z8-0002v7-AT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:39:54 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 451958535C
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:39:53 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id r2so8274997qkb.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B2/I9VN2H/YPukqYzULlfW5wiVJz9mYA12C7O5f8Ne4=;
 b=WFssqhU+fTBCwWt+xQuloDbinW3QWLcURYcdj84brmiyG1MVFnAxhgMZcExL+NxS+Y
 n88jlFQ3CArDKatxynXXzoo0QOLwRXVN8VXCxMkfnokKIy89ryyNltUAXBApxUugcnt5
 MxRGXqEVBO54r+bchE4yhvar0LrFKGTKATYCnZk1gL+ui0bUcnszhRN1The3eMIvNrwt
 pdMa5Y/VOMexfCHftLxKffgdZhFz+3P8c6b5ffQU7v2IPQ4LmZm8H5gHo+XNjlfTc4+E
 J1IlxdmBaRc5vnkdSNF7/uCGgJPxScd3fxHAs94SZ2lZ4YysYXAKNHOs+fB8G4UfC0z3
 nufQ==
X-Gm-Message-State: APjAAAWpa8gTkWByFq8u3fQ0XH4+/NghNT+i1uDS4FoHStQCjhedDvNy
 m4dPaEx8wdQ34R87X7lgQXu1D7ejOXulN0WLtpPk0DtvSn5BCDQhyjh/IOlq5StIRBonLl6OARO
 Od12f1exmkp/TL9M=
X-Received: by 2002:a37:b8e:: with SMTP id 136mr14453218qkl.306.1572251992526; 
 Mon, 28 Oct 2019 01:39:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx41fwB2p8omZOaFyGV8N9tdae8HBveiQbCyyr6+PSgFSh75tGPLfAlBGQsmN+h5WC1QBxB4w==
X-Received: by 2002:a37:b8e:: with SMTP id 136mr14453197qkl.306.1572251992222; 
 Mon, 28 Oct 2019 01:39:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x26sm5115293qto.21.2019.10.28.01.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 01:39:51 -0700 (PDT)
Date: Mon, 28 Oct 2019 04:39:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v14 11/11] tests/bios-tables-test: add test cases for
 ACPI HMAT
Message-ID: <20191028043831-mutt-send-email-mst@kernel.org>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-12-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028075220.25673-12-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, Daniel Black <daniel@linux.ibm.com>,
 armbru@redhat.com, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 03:52:20PM +0800, Tao Xu wrote:
> ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
> Heterogeneous Memory with boot option '-numa node'.
> 
> Add test cases on PC and Q35 machines with 2 numa nodes.
> Because HMAT is generated when system enable numa, the
> following tables need to be added for this test:
>   tests/acpi-test-data/pc/*.acpihmat
>   tests/acpi-test-data/pc/HMAT.*
>   tests/acpi-test-data/q35/*.acpihmat
>   tests/acpi-test-data/q35/HMAT.*
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> No changes in v14.
> 
> Changes in v13:
>     - Use decimal notation with appropriate suffix for cache size

As you have seen adding tests like this breaks CI.
Pls see the comment at the beginning of tests/bios-tables-test.c
for how to add tests without breaking CI.



> ---
>  tests/bios-tables-test.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0b33fb265f..96803c1f20 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -947,6 +947,48 @@ static void test_acpi_virt_tcg_numamem(void)
>  
>  }
>  
> +static void test_acpi_tcg_acpi_hmat(const char *machine)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = machine;
> +    data.variant = ".acpihmat";
> +    test_acpi_one(" -machine hmat=on"
> +                  " -smp 2,sockets=2"
> +                  " -m 128M,slots=2,maxmem=1G"
> +                  " -object memory-backend-ram,size=64M,id=m0"
> +                  " -object memory-backend-ram,size=64M,id=m1"
> +                  " -numa node,nodeid=0,memdev=m0"
> +                  " -numa node,nodeid=1,memdev=m1,initiator=0"
> +                  " -numa cpu,node-id=0,socket-id=0"
> +                  " -numa cpu,node-id=0,socket-id=1"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=5ns"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=500M"
> +                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10ns"
> +                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-cache,node-id=0,size=10K,level=1,assoc=direct,"
> +                  "policy=write-back,line=8"
> +                  " -numa hmat-cache,node-id=1,size=10K,level=1,assoc=direct,"
> +                  "policy=write-back,line=8",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
> +}
> +
> +static void test_acpi_piix4_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_PC);
> +}
> +
>  static void test_acpi_virt_tcg(void)
>  {
>      test_data data = {
> @@ -991,6 +1033,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_hmat);
> +        qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
>      } else if (strcmp(arch, "aarch64") == 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>          qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
> -- 
> 2.20.1

