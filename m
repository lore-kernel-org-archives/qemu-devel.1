Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8980AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D973420BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fufuac3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D973420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGBeD-0000tN-RB
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 21:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kGBdf-0000KV-7D
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:44:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kGBdd-0005xR-0N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599702275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RPj9Qp0z36BonbrcDYUwQZd9deZsAjgza1p42Kqf4w=;
 b=fufuac3pNbb8udxfbbtTZ4ZxRXkF5sBFRKxTPBnCG/QIZi9taVCPTkqgon4neKRulj4L//
 Umt1m5uvztkAJ9WDGJzarEyNSRjwB8GA4grhzHMzFqMgZFSHBRFK4k527cX1Xjlmw6Uzyj
 fAgfCDNjQaLES6917L77KdMQe6K2plA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-xaOzj8VGPXK5bIGMKuoVww-1; Wed, 09 Sep 2020 21:44:33 -0400
X-MC-Unique: xaOzj8VGPXK5bIGMKuoVww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FDC425D8;
 Thu, 10 Sep 2020 01:44:32 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12E797E175;
 Thu, 10 Sep 2020 01:44:29 +0000 (UTC)
Subject: Re: [PATCH 0/2] hw/net/opencores_eth: Trivial patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200608091508.19838-1-f4bug@amsat.org>
 <e472244f-d764-6cd6-70cd-86d71358b999@amsat.org>
 <9836f385-ccb8-981f-4677-95d22b2c0a90@amsat.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7f34876-7939-b27f-b00b-01cac2955086@redhat.com>
Date: Thu, 10 Sep 2020 09:44:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9836f385-ccb8-981f-4677-95d22b2c0a90@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 19:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/10 上午2:00, Philippe Mathieu-Daudé wrote:
> On 9/2/20 2:26 PM, Philippe Mathieu-Daudé wrote:
>> On 6/8/20 11:15 AM, Philippe Mathieu-Daudé wrote:
>>> Remove unnecessary mask, use #define instead of magic.
>>>
>>> Philippe Mathieu-Daudé (2):
>>>    hw/net/opencores_eth: Use definitions instead of magic values
>>>    hw/net/opencores_eth: Remove unnecessary address masking
>>>
>>>   hw/net/opencores_eth.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>> Ping to Jason as the series is reviewed :)
> Ping^2
>

Applied.

Thanks


