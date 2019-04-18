Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809EC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3402083D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3402083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH699-0001ZI-4u
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:28:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH68I-0001Bk-Of
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH68H-0007xE-O0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH68H-0007wU-HU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:27:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so2551062wmj.3
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=z2t0MKFLxw73rw5qRebhf4LAb+imxO7d7A747fpacW8=;
	b=cZg2BnWWOfi5LI8w98fMKuZUh2qkjaRYnSLB//r5LjVe8naVHWba466uFyUwFPdW2u
	tMMDAAbh7TZbb4QdbrxuIc+Ca0YSRKg+lvoT9RvAsWSxT7KMAEPCc4KSdU1vlWYingdY
	G1UVLtOgwsyhqRPZ6okphyqHQF3cGS0gvOw2NCBRuQTsqAQhvIDah2Or0I69mBxSMeCK
	d8tw90pVEU6ChWy3dSVTNRrYxHi+JXLMo3iJQA0pCBHwQpd5nIaMleTpl/KWBLQhFUhC
	L1OCF+t3kC5KcrGytO3P2fhmWzrl7wG1BXYEh23HinYjzAupNjNOSu+gUKhtqt0izPnK
	qOVA==
X-Gm-Message-State: APjAAAVnI1fDAjAdfPhpIUfWFimPTjCoAu2cSLrlhenUVprd5PFKer8L
	swMmzfDz63qqz1aDXKQ+mgev0g==
X-Google-Smtp-Source: APXvYqyQu4hqko7oJJtMFN7Per2hgZ07MUW1DytNngJrIlG9V43WBsboEZMRJKHgKM0Kdxgfb95CKA==
X-Received: by 2002:a05:600c:249:: with SMTP id
	9mr2897884wmj.149.1555590432427; 
	Thu, 18 Apr 2019 05:27:12 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	g19sm1826065wmh.17.2019.04.18.05.27.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 05:27:11 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
	<20190417014038.26018-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a96d8f02-4a90-9205-2f7e-82e68e88bca3@redhat.com>
Date: Thu, 18 Apr 2019 14:27:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417014038.26018-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 1/6] q35: acpi: do not create dummy MCFG
 table
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	shannon.zhaosl@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418122710.z3TqMXDBbwgkUSiKJ4SNo706Ku-ya45yIiUf11Rr1FA@z>

On 4/17/19 3:40 AM, Wei Yang wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> Dummy table (with signature "QEMU") creation came from original SeaBIOS
> codebase. And QEMU would have to keep it around if there were Q35 machine
> that depended on keeping ACPI tables blob constant size. Luckily there
> were no versioned Q35 machine types before commit:
>   (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
> which obsoleted need to keep ACPI tables blob the same size on source/destination.
> 
> Considering the 1st versioned machine is pc-q35-2.4, the dummy table
> is not really necessary and it's safe to drop it without breaking
> cross version migration in both directions unconditionally.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/acpi-build.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b17d4a711d..d009176072 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2401,7 +2401,6 @@ static void
>  build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
>      AcpiTableMcfg *mcfg;
> -    const char *sig;
>      int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>  
>      mcfg = acpi_data_push(table_data, len);
> @@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>      mcfg->allocation[0].start_bus_number = 0;
>      mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
>  
> -    /* MCFG is used for ECAM which can be enabled or disabled by guest.
> -     * To avoid table size changes (which create migration issues),
> -     * always create the table even if there are no allocations,
> -     * but set the signature to a reserved value in this case.
> -     * ACPI spec requires OSPMs to ignore such tables.
> -     */
> -    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> -        /* Reserved signature: ignored by OSPM */
> -        sig = "QEMU";
> -    } else {
> -        sig = "MCFG";
> -    }
> -    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
>  
>  /*
> @@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      }
>      mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>      qobject_unref(o);
> +    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> +        return false;
> +    }
>  
>      o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>      assert(o);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

