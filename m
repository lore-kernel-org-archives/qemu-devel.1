Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49407C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A0C2465B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgiW6RXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A0C2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTnZ-0004e5-UC
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwTkB-0008Qg-TP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwTkA-0003wp-Tp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwTkA-0003we-Qc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580228978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BPjbUQr0PkniWzjK2e36N9k9NYI3RAspVa2CKg/NsI=;
 b=PgiW6RXySR8IMC+N2wDFjWix0JjWluzD4nx6kEWM6H+A2CplZT6f5kxau+A3Ap9ct5QSuJ
 5SRLeCiNveaiBmcMuBMdPsPgYRWblBNC9CSulkXMBT3yn6VhiClDSgSLgmwvItAiA+Q0pT
 bth+waiOO63GCF33kR6pNU5j9jyg/9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360--GBZOLopMhKHxYr9v-PLCA-1; Tue, 28 Jan 2020 11:29:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0702910BAD8F;
 Tue, 28 Jan 2020 16:29:33 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A534919C58;
 Tue, 28 Jan 2020 16:29:26 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp test
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6cdba6ae-928d-696b-19b2-f4f81f341f3a@redhat.com>
Date: Tue, 28 Jan 2020 17:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -GBZOLopMhKHxYr9v-PLCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 1/17/20 6:45 PM, Shameer Kolothum wrote:
> Since we now have both pc-dimm and nvdimm support, update
> test_acpi_virt_tcg_memhp() to include those.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  tests/data/acpi/virt/NFIT.memhp | 0
>  tests/data/acpi/virt/SSDT.memhp | 0
Is it normal to have those 2 above void files? I lost track about the
process.
>  tests/qtest/bios-tables-test.c  | 9 +++++++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp
>  create mode 100644 tests/data/acpi/virt/SSDT.memhp
> 
> diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.memhp
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f1ac2d7e96..695d2e7fac 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -913,12 +913,17 @@ static void test_acpi_virt_tcg_memhp(void)
>      };
>  
>      data.variant = ".memhp";
> -    test_acpi_one(" -cpu cortex-a57"
> +    test_acpi_one(" -machine nvdimm=on"
nit: maybe keep the same order as before ...
> +                  " -cpu cortex-a57"
>                    " -m 256M,slots=3,maxmem=1G"
and simply add ,nvdimm=on to above line.
>                    " -object memory-backend-ram,id=ram0,size=128M"
>                    " -object memory-backend-ram,id=ram1,size=128M"
>                    " -numa node,memdev=ram0 -numa node,memdev=ram1"
> -                  " -numa dist,src=0,dst=1,val=21",
> +                  " -numa dist,src=0,dst=1,val=21"
> +                  " -object memory-backend-ram,id=ram2,size=128M"
> +                  " -object memory-backend-ram,id=nvm0,size=128M"
> +                  " -device pc-dimm,id=dimm0,memdev=ram2,node=0"
> +                  " -device nvdimm,id=dimm1,memdev=nvm0,node=1",
>                    &data);
>  
>      free_test_data(&data);
> 
Thanks

Eric


