Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D87C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192F025372
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F025372
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSOFT-0006ks-18
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSOEq-0006IP-Hz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:37:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSOEn-000359-V2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:37:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 67D4CAF2C;
 Tue, 13 Oct 2020 17:37:24 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] replay: do not build if TCG is not available
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201013143806.14321-1-cfontana@suse.de>
 <20201013143806.14321-4-cfontana@suse.de>
 <edc078b6-71b4-0650-1c23-fd437cd3fd25@redhat.com>
 <4dd4ba40-159c-d581-1dbb-93a79bb06b8b@suse.de>
 <496ee664-bf68-f6c9-f943-02b5ab122c1b@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <aa72e4a7-885d-8709-981a-72f6ab054b66@suse.de>
Date: Tue, 13 Oct 2020 19:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <496ee664-bf68-f6c9-f943-02b5ab122c1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 7:25 PM, Paolo Bonzini wrote:
> On 13/10/20 19:17, Claudio Fontana wrote:
>>> This is definitely better, but I'll defer to Kevin with respect to the
>>> naming of the function; having a bdrv_* function that has nothing to do
>>> with the block layer is still smelly of a sub-optimal API, and I'm not
>>> sure why the API change belongs in the series.
>>>
>>> Paolo
>>>
>> Hi Paolo,
>>
>> I am not attached to the specific name, if someone has a better naming / proposes a better prefix I will replace of course.
> 
> Can you just unbreak TCG in this series, and we can then revisit the
> topic of functional code in stubs later?
> 
> Paolo
> 
> 

Hi Paolo, probably just a typo there, it's non-tcg (--disable-tcg) that's broken, not TCG.

If nothing else would be acceptable and we are in a hurry, sure lets close the nose and do it,
it's just a tiny bit of some duplicated code in stubs.

I'd prefer if we have something a bit better that's all, but if this is hurting badly lets do it!

Ciao,

Claudio





