Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C587206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7axevgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C587206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGP23-0000iI-9b
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGP08-00068i-Qk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGP07-00072r-L8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGP07-00072a-Gc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584977307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5FFIL32Xk4JS/YnTAd3rqMntVvEjC0v+56CjlZ2pWQ=;
 b=Z7axevgr/OXExDdkYztpPG2yNYYO0eErmb5k/ehqL0LuALIcW3WddVILdFjJD9NLVpdLqe
 xZ5HkPiciGA+4vDrvzvhHsnCZ7UbRFXVWCItJwc3Q2B7BBlILoqv1u+ozc7TnueZgmX5hD
 hO+nvEGAMv1NfDGLq7dra2djgKwgzH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-yQT2iSwgNKepr-t3oESiqw-1; Mon, 23 Mar 2020 11:28:25 -0400
X-MC-Unique: yQT2iSwgNKepr-t3oESiqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7BD68017CE;
 Mon, 23 Mar 2020 15:28:23 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 206121000337;
 Mon, 23 Mar 2020 15:28:11 +0000 (UTC)
Date: Mon, 23 Mar 2020 16:28:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 09/10] tests/bios-tables-test: Update arm/virt memhp
 test
Message-ID: <20200323162810.5b4f0124@redhat.com>
In-Reply-To: <20200311172014.33052-10-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, david@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, mst@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 17:20:13 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

SUBJ is pointless,
s/Update.../
arm/virt: test pc-dimm and nvdimm coldplug

> Since we now have both pc-dimm and nvdimm support, update
> test_acpi_virt_tcg_memhp() to include those.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v2 -> v3
>  -Moved addition of empty table files to the previous patch
> ---
>  tests/qtest/bios-tables-test.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a597bbacf..c9843829b3 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -927,12 +927,17 @@ static void test_acpi_virt_tcg_memhp(void)
>      };
>  
>      data.variant = ".memhp";
> -    test_acpi_one(" -cpu cortex-a57"
> +    test_acpi_one(" -machine nvdimm=on"
> +                  " -cpu cortex-a57"
>                    " -m 256M,slots=3,maxmem=1G"
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


