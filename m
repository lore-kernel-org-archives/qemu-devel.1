Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F74C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCDF247A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHH4dA93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCDF247A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmg8-00052u-Kj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXmev-0004Te-Rz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXmeu-0001de-3m
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603896158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFCLjXrCbVDnSB06L+2FCYKJI5t/01be0QHHgg3oi1g=;
 b=XHH4dA93O02CBJZ/RQgHS8yeLTj3EI81bgrRnSKhxSqp0Oo05KQxvepczSe5pg7M/wYZ6L
 iokfm0VQgKLnvLWQ15BGBrH57sOduX9NKRkbFWqVHHR1PW6mELjy0UU0vaLo+1Dn8i5D9X
 R54oCx+yxu2W/NcsT9PLHccgiXCehP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-FlTAmPSBOkKEqrV-egdI9g-1; Wed, 28 Oct 2020 10:42:36 -0400
X-MC-Unique: FlTAmPSBOkKEqrV-egdI9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1615B1DDFB;
 Wed, 28 Oct 2020 14:42:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-124.ams2.redhat.com [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E840B1974D;
 Wed, 28 Oct 2020 14:42:32 +0000 (UTC)
Subject: Re: [PATCH 7/9] ppc: silence the compiler warnings
To: David Gibson <david@gibson.dropbear.id.au>,
 Chen Qun <kuhn.chenqun@huawei.com>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-8-kuhn.chenqun@huawei.com>
 <20201028042900.GC5604@yekko.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ddcb887d-42ec-2021-1785-a6fb0d13d6b9@redhat.com>
Date: Wed, 28 Oct 2020 15:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201028042900.GC5604@yekko.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/2020 05.29, David Gibson wrote:
> On Wed, Oct 28, 2020 at 12:18:17PM +0800, Chen Qun wrote:
>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>> hw/ppc/ppc.c: In function ‘ppc6xx_set_irq’:
>> hw/ppc/ppc.c:118:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   118 |             if (level) {
>>       |                ^
>> hw/ppc/ppc.c:123:9: note: here
>>   123 |         case PPC6xx_INPUT_INT:
>>       |         ^~~~
>>
>> Add the corresponding "fall through" comment to fix it.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
>> ---
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/ppc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index 4a11fb1640..f9eb8f21b4 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -120,6 +120,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int level)
>>              } else {
>>                  cpu_ppc_tb_stop(env);
>>              }
>> +            /* fall through */
>>          case PPC6xx_INPUT_INT:
>>              /* Level sensitive - active high */
>>              LOG_IRQ("%s: set the external IRQ state to %d\n",
> 

Is that fall through actually really the right thing to do here? I'd rather
expect to see a PPC_INTERRUPT_DECR instead of a PPC_INTERRUPT_EXT in case
someone messes with the TBEN pin? So I assume this is likely rather bug and
we should a "break" statement here instead?

 Thomas


