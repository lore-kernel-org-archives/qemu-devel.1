Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DBC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD48217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD48217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqXDu-0003ET-OF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 02:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqXDj-0002ot-RK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqXDi-0006Jl-W0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:27:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqXDi-0006JG-OP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:27:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so49347163wrf.11
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 23:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VLqFEGXCMxwSO2guo/XuIBWYtDI1Cc6NAs7rmAlwxro=;
 b=Be3nC/OvCikOEYGvcOFJ3XrvvdfO6XF53M+tv8AUy4TOuMeqSJUgs9TLBsmlvA9Qs4
 iQjy7xZaNJoxm892FTv1z1U80q6Tie5eTLCcMzo7JpGwpW3G1V1vtC89/XdwvsRqxcxf
 kTgvhgE39vg4YKMvTI77kOBC5vu74cPOJ60eG4M+bjYHtHOxbMLWpidNwjLIX5/mGh3I
 hR7I4zqBX8zEAe7mVlIQfhq62NkVL7YirlI4Hs4RYQMdFkkjyvbxSkjc+lMWtJ+pE1JP
 gtnbMhfB7W3eKHML6zYidxxbOfljEuhKBolJyblfdeRe6HDOSgrrPHDAVL6iyDMf0OVs
 herA==
X-Gm-Message-State: APjAAAUU70o6RRPV2cGH+Re3jgOGEFzL3YQN0WVqfx0ntGz7e1RZazwj
 tkwrq9PpEdjBUV+Fgh3Ua3CM/g==
X-Google-Smtp-Source: APXvYqzgtL0zN4KkGoXPf95FAAe8saDboZPckXaMjPPJPlkXSkNGe2f1wphxPiYHltELGBNuuaOW5Q==
X-Received: by 2002:adf:f601:: with SMTP id t1mr92427644wrp.337.1564036037269; 
 Wed, 24 Jul 2019 23:27:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id p14sm39442046wrx.17.2019.07.24.23.27.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 23:27:16 -0700 (PDT)
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
 <156395787270.510.3319575187228105326.stgit@pasha-Precision-3630-Tower>
 <968ae3fd-0482-24f2-b24d-459152ff226d@redhat.com>
 <000601d542ad$947a5c00$bd6f1400$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <10e809c4-8374-2a17-759c-4852c170fcfa@redhat.com>
Date: Thu, 25 Jul 2019 08:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <000601d542ad$947a5c00$bd6f1400$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.2 14/14] icount: clean up cpu_can_io
 before jumping to the next block
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 07:55, Pavel Dovgalyuk wrote:
>>
>> I think you do not need this patch if you remove the assignment in
>> cpu_tb_exec, and compile a "move 0 to cpu->can_do_io" in gen_tb_start
>> instead.
> "move 0 to cpu->can_do_io" only for icount mode?

Yes, using CF_ICOUNT.

> And we'll also need to set can_do_io to 1 somewhere, because it
> is checked in non-icount mode too.

It is already set in qemu_tcg_cpu_thread_fn.

Paolo

