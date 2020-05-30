Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4AAC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 06:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F33206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 06:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXTPHUBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F33206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jevSf-0006UZ-Jn
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 02:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jevS4-0005MK-HZ
 for qemu-devel@nongnu.org; Sat, 30 May 2020 02:58:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jevS2-0005uc-CQ
 for qemu-devel@nongnu.org; Sat, 30 May 2020 02:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590821916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWIbs4J/EbIvpRSbKH/3vS9JAfgt+uNV30yTh7SQu0Y=;
 b=AXTPHUBU7yMfz2BYxJwjb2EDcXzPn6iWRAjQ5gerPVZxEK0QILprUdnTHOeldkLgd2BTjQ
 CHMGYMGTtOx/7xWrI4tw/2VgTfZq7CeWCvCONc1FNgSY/O0S0NgDRLCW28ZLi3hfjisIEe
 e6B60Mzh1wwFygVIT/vqaSxS6yR1StI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-67Mg1J_xMy2HdzPQc1QePA-1; Sat, 30 May 2020 02:58:28 -0400
X-MC-Unique: 67Mg1J_xMy2HdzPQc1QePA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9912C460;
 Sat, 30 May 2020 06:58:27 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0905B2BFF9;
 Sat, 30 May 2020 06:58:22 +0000 (UTC)
Subject: Re: [PATCH] acpi: tpm: Do not build TCPA table for TPM 2
To: Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 mst@redhat.com
References: <20200529192840.3921141-1-stefanb@linux.vnet.ibm.com>
 <5df0df78-817d-d80e-648b-c4f733972ff2@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <09068557-260d-a49f-6c2f-c818ec04f76f@redhat.com>
Date: Sat, 30 May 2020 08:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5df0df78-817d-d80e-648b-c4f733972ff2@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 01:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan

On 5/30/20 12:23 AM, Stefan Berger wrote:
> On 5/29/20 3:28 PM, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Do not build a TCPA table for TPM 2 anymore but create the log area when
>> building the TPM2 table. The TCPA table is only needed for TPM 1.2.

Now I understand the purpose of the tcpalog arg in build_tpm2() ;-)

Reviewed-by: Eric Auger <eric.auger@redhat.com>

I will send shortly 2 series, the one related to ARM/ACPI support and a
new one introducing ACPI table tests based on this new patch as both
conflict with this patch.

Thanks

Eric

> 
> Specs are here:
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
> 
> 
> TCPA is a TPM 1.2 table and TPM2 tables is sufficient for TPM 2.0.
> 
> 
> 
> 


