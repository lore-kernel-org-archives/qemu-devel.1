Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E73F2076A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYlO3QR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E73F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUJF-0007v7-Om
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtUHx-00071g-7i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:00:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtUHv-00047b-Bj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594292422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JZtGMU0rYpWvJs31gsoJmLUjThr3Lv9mSlyuLD+P62o=;
 b=XYlO3QR09IKKOfAfzJVpS2aH7S0LFjheFy2/mH87+t72Ne1AVykVao9pidGQiDyD++hry5
 WRS72LUDO5opSe3U4SmaUwxKgqShQINrK2GUc6QMOeEyQ4mU22SE/cTsKErdKLmX5Dw76/
 fQzBia9HLmcVquvleYLgnmAxFsPaRWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-NxmIE0BRMkWSU1LQfIw4aA-1; Thu, 09 Jul 2020 07:00:20 -0400
X-MC-Unique: NxmIE0BRMkWSU1LQfIw4aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E121089;
 Thu,  9 Jul 2020 11:00:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8595610AF;
 Thu,  9 Jul 2020 10:59:59 +0000 (UTC)
Subject: Re: [PATCH] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200709053456.4900-1-thuth@redhat.com>
 <20200709105121.GB511889@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <64e5ec54-a2f8-d6bb-4b1c-de7cf1eed372@redhat.com>
Date: Thu, 9 Jul 2020 12:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200709105121.GB511889@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 12.51, Stefan Hajnoczi wrote:
> On Thu, Jul 09, 2020 at 07:34:56AM +0200, Thomas Huth wrote:
>> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
>> index f0b66320e1..a4e6446ed9 100644
>> --- a/util/coroutine-ucontext.c
>> +++ b/util/coroutine-ucontext.c
>> @@ -237,19 +237,15 @@ Coroutine *qemu_coroutine_new(void)
>>  }
>>  
>>  #ifdef CONFIG_VALGRIND_H
>> -#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>>  /* Work around an unused variable in the valgrind.h macro... */
>>  #pragma GCC diagnostic push
>>  #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
>> -#endif
> 
> What about !defined(__clang__)? Looks like this will break clang builds:
> 
>   warning: unknown warning option '-Wunused-but-set-variable'; did you mean '-Wunused-const-variable'? [-Wunknown-warning-option]

Oh, I didn't hit this problem in the CI:

 https://gitlab.com/huth/qemu/-/jobs/629814877#L2287

... which version of Clang are you using? Anyway, I'll put the
!defined(__clang__) back here, thanks for reporting it!

 Thomas


