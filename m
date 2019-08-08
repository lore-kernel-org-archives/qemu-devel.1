Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97749C32751
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B731217F5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 01:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B731217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvXSC-0004tS-OK
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 21:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <star.zeng@intel.com>) id 1hvXRm-0004TC-GT
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <star.zeng@intel.com>) id 1hvXRk-0002tn-Ix
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:42:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:15159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <star.zeng@intel.com>) id 1hvXRi-0002re-MS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 21:42:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 18:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; d="scan'208";a="203404457"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2019 18:42:18 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 18:42:17 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 18:42:17 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.204]) with mapi id 14.03.0439.000;
 Thu, 8 Aug 2019 09:42:15 +0800
From: "Zeng, Star" <star.zeng@intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to
 use goto for the last check
Thread-Index: AQHVRm8sI9RcDIduCkeWmeFT3LDTHabwhy4g
Date: Thu, 8 Aug 2019 01:42:14 +0000
Message-ID: <0C09AFA07DD0434D9E2A0C6AEB0483104038F59D@shsmsx102.ccr.corp.intel.com>
References: <20190730003740.20694-1-richardw.yang@linux.intel.com>
 <20190730003740.20694-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190730003740.20694-2-richardw.yang@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to use
 goto for the last check
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "Zeng, Star" <star.zeng@intel.com>,
 "david@redhat.com" <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+star.zeng=3Dintel.com@nongnu.org] On Behalf Of Wei Yang
> Sent: Tuesday, July 30, 2019 8:38 AM
> To: qemu-devel@nongnu.org
> Cc: imammedo@redhat.com; david@redhat.com; Wei Yang
> <richardw.yang@linux.intel.com>; mst@redhat.com
> Subject: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to use
> goto for the last check
>=20
> We are already at the last condition check.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c index
> 5f2c408036..df3261b32a 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -186,7 +186,6 @@ static uint64_t
> memory_device_get_free_addr(MachineState *ms,
>      if (!range_contains_range(&as, &new)) {
>          error_setg(errp, "could not find position in guest address space=
 for "
>                     "memory device - memory fragmented due to alignments"=
);
> -        goto out;

Is it better to return 0 (or set new_addr to 0) for this error path and ano=
ther remaining "goto out" path?


Thanks,
Star

>      }
>  out:
>      g_slist_free(list);
> --
> 2.17.1
>=20


