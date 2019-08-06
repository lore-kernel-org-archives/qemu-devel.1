Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DBCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C8820C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C8820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huzCK-0007Pn-D2
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1huzBp-0006xq-06
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1huzBn-00050Z-Vm
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:07:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1huzBn-00050J-QW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:07:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so87834082wrr.5
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 06:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uV8V2AkArB7xqn1NYcpBE0VNz2+UneT9RBJBvzGLbHo=;
 b=R9FUdZ8C8nNrrzm7V5ckQ8FdgeW0LrwLSAZDH3urwwsVMmjDjC1z/+2cHAqsTA5Kwo
 WyTU6/aeHW6+BQAVaT8DFy8jA+z+blxXgO1dAgGhj+uSjixOuZ87V7v5wsq6xT4c6Tci
 m9owbf7Wi0O1mSP+qAY/8IJov11Qf3yc/V0E6BXrcOVXS0fp/vXJrKmGc0XWIwd5D/Lz
 Oho4EDUYdkejNq7ok2bFF7EOtC/ShgjquilzAsxvpN4mnGybq2Yq4QPvsj4onZjuUopd
 e9QfU+jtgXURAVnafhT+bdzHZ0zKv12U7cy/jcBKchgj+ygiIpbN8ymkcSiJ5IIjTvEs
 47Cg==
X-Gm-Message-State: APjAAAVbh22G5jyfaydtvpptON/cIwFGNw7oKDyah3fx09aQyMhPFl7/
 CUk/j6qqrC+hoC5hAmh1BmEVVZ0j4uY=
X-Google-Smtp-Source: APXvYqwhFyYptK6mlVUJk72KXgQYlx4aRYRRsmHiwylTVkd03vUEOf4vQ8DiOBmeR/R5CMezoRmRuw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr5036130wru.305.1565096861708; 
 Tue, 06 Aug 2019 06:07:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id b2sm121096206wrp.72.2019.08.06.06.07.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 06:07:41 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1565075475-15313-1-git-send-email-pbonzini@redhat.com>
 <20190806094140.GB14887@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ad9692cc-7aa2-7f09-0bf7-7c674e2d0d92@redhat.com>
Date: Tue, 6 Aug 2019 15:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806094140.GB14887@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] crypto: move common bits for all emulators
 to libqemuutil
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/19 11:41, Daniel P. Berrangé wrote:
> On Tue, Aug 06, 2019 at 09:11:15AM +0200, Paolo Bonzini wrote:
>> qcrypto_random_*, AES and qcrypto_init do not need to be linked as a whole
>> and are the only parts that are used by user-mode emulation.  Place them
>> in libqemuutil, so that whatever needs them will pick them up automatically.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  MAINTAINERS                         | 3 +++
>>  Makefile                            | 4 +---
>>  Makefile.objs                       | 1 -
>>  Makefile.target                     | 2 --
>>  crypto/Makefile.objs                | 7 -------
>>  util/Makefile.objs                  | 5 +++++
>>  {crypto => util}/aes.c              | 0
>>  crypto/init.c => util/crypto-init.c | 0
>>  {crypto => util}/random-gcrypt.c    | 0
>>  {crypto => util}/random-gnutls.c    | 0
>>  {crypto => util}/random-platform.c  | 0
> 
> Ewww, definitely do not want to see these files moved as it spreads the
> crypto related code over multiple locations again, which is exactly what
> I spent time fixing when introducing the crypto/ directory.
> 
> Placing them to libqemuutil.a shouldn't mean we need to move the code too.

Fair enough, will do in v2.

Paolo


