Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41373C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08699206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODGNdg1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08699206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4vl-0006SL-BK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jw4u8-00054e-Oh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:30:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jw4u7-0006Ma-26
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594909830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9R3SehxOrX5AVdyncYMnApnKrjD7aIjCkRs+BHjo2Rs=;
 b=ODGNdg1gMN1KlM5evEVsSFjSLQ2y9ckyEZjVhLhfrt7P6jTJWyLegBZM5MKJk2OzduCAZ+
 /UEMnHGIlVv6SdhJ1/5QAZ+zTsjxcPsuDxneNiP7JN6KEXH3gTAzmtKn5wxCzDFABTpdjN
 2754oayOgCNTj0F2v1q3QkkeMhyaaeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-8P2TeEvoMhmOVnM_bVKWVg-1; Thu, 16 Jul 2020 10:30:28 -0400
X-MC-Unique: 8P2TeEvoMhmOVnM_bVKWVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C36F107BEF8;
 Thu, 16 Jul 2020 14:30:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0CD6FDD1;
 Thu, 16 Jul 2020 14:30:26 +0000 (UTC)
Subject: Re: [RFC PATCH] configure: Fix atomic64 test for --enable-werror on
 macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200716131101.18462-1-thuth@redhat.com>
 <2922420.RJvhEBMbDd@silver>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e79b4ae5-83fb-9953-edd2-fc118305cb2c@redhat.com>
Date: Thu, 16 Jul 2020 16:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2922420.RJvhEBMbDd@silver>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/2020 16.15, Christian Schoenebeck wrote:
> On Donnerstag, 16. Juli 2020 15:11:01 CEST Thomas Huth wrote:
>> When using --enable-werror for the macOS builders in the Cirrus-CI,
>> the atomic64 test is currently failing, and config.log shows a bunch
>> of error messages like this:
>>
>>  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
>>  '__atomic_load_8' is invalid in C99
>> [-Werror,-Wimplicit-function-declaration] y = __atomic_load_8(&x, 0);
>>       ^
>>  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
>>  prototype [-Werror,-Wstrict-prototypes]
> 
> Well, __atomic_*_8() functions do exist on macOS, but it does not look like 
> they are supposed to be 'officially' used.
> 
> You can compile sources with these functions, and yes they are linking fine 
> despite the warning, but IMO not a good idea to use them, as AFAICS they are 
> not defined by any public header file.
> 
>> Suppress the warnings to make it pass.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Not sure whether this is the best way to fix this issue ... thus marked
>>  as RFC.
> 
> Probably it is better to switch to their official C11 counterpart functions 
> for this test, like e.g. __atomic_load() instead of __atomic_load_8(), etc.
> That's what the actual qemu code base is using actually anyway.

Thanks, that sounds like a good idea! I'll have a try when I've got some
spare minutes...

 Thomas


