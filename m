Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB713C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31652247F8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTw6ywe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31652247F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXp9c-0004op-7K
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXog1-0003Wi-3a
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXofy-0002ZK-PV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Phy71BlvZvSpwjfqb4wJ9xMsH4abi54EHUl4tEHZUac=;
 b=fTw6ywe9HMJhAu5kT2OHklNCIdVoe00ERZJT03s1QysIgj5I/uVGy7vQRBvHi2MVTiDWAH
 a+n1ax/YzhSSCvMq9XVC3vMoY8vU5rF2PBMdK0ETHs++qTfDDUlqearfgQcZFLutKLga/6
 9w7Amh1VEtHK0INuVYiNSzq8TjluRY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-zpCtPXPSMBmWJWAybVS8nw-1; Wed, 28 Oct 2020 12:51:51 -0400
X-MC-Unique: zpCtPXPSMBmWJWAybVS8nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CA58107B26E;
 Wed, 28 Oct 2020 16:51:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-124.ams2.redhat.com [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7FB95C1D7;
 Wed, 28 Oct 2020 16:51:46 +0000 (UTC)
Subject: Re: [PATCH 1/9] target/i386: silence the compiler warnings in
 gen_shiftd_rm_T1
To: Richard Henderson <richard.henderson@linaro.org>,
 Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-2-kuhn.chenqun@huawei.com>
 <30ca9af0-dfc2-e236-5575-068cec679508@redhat.com>
 <d1d59436-1a8a-7aa3-7983-4344e16ab881@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9aac453d-2826-1b5e-db12-386b18f38eba@redhat.com>
Date: Wed, 28 Oct 2020 17:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d1d59436-1a8a-7aa3-7983-4344e16ab881@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/2020 16.31, Richard Henderson wrote:
> On 10/28/20 5:57 AM, Thomas Huth wrote:
>> On 28/10/2020 05.18, Chen Qun wrote:
>>> The current "#ifdef TARGET_X86_64" statement affects
>>> the compiler's determination of fall through.
>>>
>>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>>> target/i386/translate.c: In function ‘gen_shiftd_rm_T1’:
>>> target/i386/translate.c:1773:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>          if (is_right) {
>>>             ^
>>> target/i386/translate.c:1782:5: note: here
>>>      case MO_32:
>>>      ^~~~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  target/i386/translate.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>>> index caea6f5fb1..4c353427d7 100644
>>> --- a/target/i386/translate.c
>>> +++ b/target/i386/translate.c
>>> @@ -1777,9 +1777,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
>>>          } else {
>>>              tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
>>>          }
>>> -        /* FALLTHRU */
>>> -#ifdef TARGET_X86_64
>>> +        /* fall through */
>>>      case MO_32:
>>> +#ifdef TARGET_X86_64
>>>          /* Concatenate the two 32-bit values and use a 64-bit shift.  */
>>>          tcg_gen_subi_tl(s->tmp0, count, 1);
>>>          if (is_right) {
>>
>> The whole code here looks a little bit fishy to me ... in case TARGET_X86_64
>> is defined, the MO_16 code falls through to MO_32 ... but in case it is not
>> defined, it falls through to the default case that comes after the #ifdef
>> block? Is this really the right thing here? If so, I think there should be
>> some additional comments explaining this behavior.
>>
>> Richard, maybe you could help to judge what is right here...?
> 
> It could definitely be rewritten, but it's not wrong as is.

Ok, thanks for the clarification! In that case:

Reviewed-by: Thomas Huth <thuth@redhat.com>


