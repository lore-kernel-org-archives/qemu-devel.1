Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA03C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6249E2184D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6249E2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsW8-0006Tc-Ff
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQsVF-0005vu-Tw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:32:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kQsVC-00089g-Nh
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:32:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2644EAC23;
 Fri,  9 Oct 2020 13:32:05 +0000 (UTC)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
 <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
 <48641901-68e7-7e34-5046-31eea3967701@suse.de>
 <eba000db-c0d1-8474-15cc-6fa6e864bb88@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <41cce7d1-ed3e-46ff-aaee-98ded342f6a2@suse.de>
Date: Fri, 9 Oct 2020 15:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <eba000db-c0d1-8474-15cc-6fa6e864bb88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 23:20:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:49 PM, Paolo Bonzini wrote:
> On 09/10/20 12:28, Claudio Fontana wrote:
>> Running test qtest-x86_64: qos-test
>> ERROR qtest-x86_64: bios-tables-test - too few tests run (expected 23, got 22)
>> make: *** [Makefile.mtest:1326: run-test-187] Error 1
>> make: *** Waiting for unfinished jobs....
>>
>> What am I missing here?
> 
> This is something else that is crashing.
> 
> You want to do (as for any other test; this should be documented)
> 
>   make -j12 check-qtest V=1
> 
> and then cut-and-paste the bios-tables-test line, which should be something like
> 
>   QTEST_QEMU_IMG=./qemu-img \
>     G_TEST_DBUS_DAEMON=/home/pbonzini/work/upstream/qemu/tests/dbus-vmstate-daemon.sh \
>     QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>     tests/qtest/bios-tables-test --tap -k
> 
> Paolo
> 

Hi Paolo,

I now just found out that bios-tables-test actually was segfaulting, but even with V=1
there was no indication or hint about it from the tests, maybe there should be?

Segfault seems to be stemming from a missing check for NULL in the free function for the test data,
with that change things seem to finally work for bios-tables-test.

Now to the next failing test.. (qos-test buzzes with no output, we'll see..)

Thanks,

Claudio




