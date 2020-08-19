Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1400206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1400206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OTe-0003lD-W1
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OT5-0003HY-RF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OT4-0003FH-8e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:49:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5516EB181;
 Wed, 19 Aug 2020 13:49:54 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 01/14] cpu-timers, icount: new modules
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-2-cfontana@suse.de>
 <10efbc6b-8e10-39f4-53cd-9a627e436f62@linaro.org>
Message-ID: <32b4d35a-a9f9-1303-117e-3d6a981f71f8@suse.de>
Date: Wed, 19 Aug 2020 15:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <10efbc6b-8e10-39f4-53cd-9a627e436f62@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Richard,

On 8/14/20 10:20 PM, Richard Henderson wrote:
> On 8/12/20 11:32 AM, Claudio Fontana wrote:
>> +/*
>> + * Return the icount enablement state:
>> + *
>> + * 0 = Disabled - Do not count executed instructions.
>> + * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
>> + * 2 = Enabled - Runtime adaptive algorithm to compute shift
>> + */
>> +int icount_enabled(void);
> 
> Why does use_icount need to change to a function?


It is not useful at this point, I'll change this.


> 
> If it does, or even if this just comes under the heading of cleanup, it should
> certainly be done in a separate patch.


Yes, I'll move it to a different series entirely.

> 
> Either way, I think we should expose the fact that this is always disabled when
> #ifndef CONFIG_TCG, just like we do for tcg_enabled().

Will do.

> 
>> -        if (use_icount) {
>> -            return cpu_get_icount();
>> +        if (icount_enabled()) {
>> +            return icount_get();
> 
> Renaming of other functions like this should also be done in a separate patch.

Is there a compelling reason to separate the new module/class from what are effectively its methods?
It seemed to me that creating a new icount module would warrant the name changes in the same patch.

> 
> 
> r~
> 

I will be out of office until end of the month,

thanks,

Claudio



