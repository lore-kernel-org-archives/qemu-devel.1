Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89DA21532
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Olf7KCOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DA21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlol5-00018g-0D
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlok8-0000Cy-My
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:13:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlok6-0004uH-SO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592464425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjb8sU9fu+eZZJRNs4f1lRA0vqLpGuc9yXn2rSYBbr0=;
 b=Olf7KCOsL87l44MpPEVyh0emyW1hsWu1wNnPRhTHf5Y/MwGDTLUllITf2azoD+FRCWra/o
 51yA2ewgfJNw443nh8RTYbhyVdZhkWGVl4YVwhxbLY4LVFRKv39yKWHMddg24YRQlC/ss1
 Z/JQelOQZazdYbT5KuL7CkaBo8ydEB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ws55Xe9VNjqXBssgWbupGA-1; Thu, 18 Jun 2020 03:13:42 -0400
X-MC-Unique: ws55Xe9VNjqXBssgWbupGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9C6018A8220;
 Thu, 18 Jun 2020 07:13:40 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 810685D9E4;
 Thu, 18 Jun 2020 07:13:33 +0000 (UTC)
Subject: Re: [PATCH v4 6/8] tests: Add updated DSDT
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-7-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <99de0c4c-bf9a-90f3-053e-db8872e4557c@redhat.com>
Date: Thu, 18 Jun 2020 09:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-7-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/17/20 4:23 PM, Stefan Berger wrote:
> Add the updated DSDT following the interrupt enablement.
> 
> @@ -5,13 +5,13 @@
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/q35/DSDT.tis, Mon Jun 15 09:57:05 2020
> + * Disassembly of /tmp/aml-Y77YL0, Mon Jun 15 09:57:05 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x000020A5 (8357)
> + *     Length           0x000020A8 (8360)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0xAD
> + *     Checksum         0x77
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
> @@ -3162,6 +3162,8 @@
>                          0xFED40000,         // Address Base
>                          0x00005000,         // Address Length
>                          )
> +                    IRQNoFlags ()
> +                        {13}
>                  })
>                  OperationRegion (TPP2, SystemMemory, 0xFED45100, 0x5A)
>                  Field (TPP2, AnyAcc, NoLock, Preserve)
> **
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-id: 20200616205721.1191408-7-stefanb@linux.vnet.ibm.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/data/acpi/q35/DSDT.tis                | Bin 8357 -> 8360 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
> index 56b6fb0c3298517d080e38fea05a748b9f1dba54..3f9db960aa05d399fa7f8449e6db688788211832 100644
> GIT binary patch
> delta 64
> zcmZ4LxWbXkCD<iog#rTuWBEp|KeC)oS~2m#PVoX>llkS`nVeK7N60A%iEs(FaWXJ6
> UFkJb^5Wv8o#GtUbT~3Y(068!Z;Q#;t
> 
> delta 61
> zcmZ4CxYUu$CD<iosR9E7<Jyf}e`GoRHDls~o#F-DC-cj>Gx@7bj*wH}7v$n=<78lD
> RV7T&+A%KBlbC;YP695=#58(g+
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index bb4ce8967b..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.tis",
> 


