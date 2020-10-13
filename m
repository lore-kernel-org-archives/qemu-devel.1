Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE71C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08D62078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08D62078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFgi-0003Tl-RV
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSFfo-0002Kh-R9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:28:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSFfn-0003yM-Ce
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A02D3AF87;
 Tue, 13 Oct 2020 08:28:41 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] unbreak non-tcg builds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20201012214527.1780-1-cfontana@suse.de>
 <d32be762-ece9-c9cb-1bdc-3d7e65c5a7bc@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <4b561396-f6ea-599f-1108-8fc679f61c31@suse.de>
Date: Tue, 13 Oct 2020 10:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d32be762-ece9-c9cb-1bdc-3d7e65c5a7bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 10:25 AM, Philippe Mathieu-Daudé wrote:
> On 10/12/20 11:45 PM, Claudio Fontana wrote:
>> This series now unbreaks current non-tcg builds
>> (!CONFIG_TCG).
>>
>> tests Makefiles need to avoid relying on all non-native
>> archs binaries to be present,
>>
>> bios-tables-test needs to skip tests that are tcg-only,
>>
>> and notably the replay framework needs to consider that
>> it might not be functional (or its code present at all)
>> without TCG.
>>
>> Tested ok target x86_64-softmmu on x86_64 host with:
>>
>> ./configure --enable-tcg --disable-kvm
>> ./configure --enable-kvm --disable-tcg
>> ./configure --enable-tcg --enable-kvm
>>
>> running make check-qtest
> 
> If you want to avoid these configurations to bitrot,
> please cover them adding Gitlab jobs.
> 
> Thanks,
> 
> Phil.
> 

Hi, yes I was about to ask :-) We have only minimal coverage of --disable-tcg and only for s390 IIRC.

Ciao,

Claudio

