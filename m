Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A74FC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FC521481
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PF7f3QYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FC521481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdgy-00082d-Rg
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kOdfv-0007Vt-Tc
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kOdfs-0007Al-Vs
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601716671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fzLg32yIxL4nuBAaxGzjjdUPzlfMH4ds5vNoj1mFCc=;
 b=PF7f3QYO2zwQNggtWdit2YGXy112+7JBQQvkY8FCa6nJuMgBojorMCpqToN/YqZEr7hgzk
 MJwZwBERVwyROoQ1Dm5V9P5a8AWiIjRowzDUadOWIjkvZabrK23mFRPYE6bnTQ6yIYz7A+
 JPpsh/HbHz2u1xwpU6DhuykyMq09lfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-XzWEcPFZMJi_MD1bMolAxw-1; Sat, 03 Oct 2020 05:17:50 -0400
X-MC-Unique: XzWEcPFZMJi_MD1bMolAxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB50C1868410;
 Sat,  3 Oct 2020 09:17:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3385510013C4;
 Sat,  3 Oct 2020 09:17:45 +0000 (UTC)
Subject: Re: [PATCH v4 04/12] target/arm: Restrict ARMv4 cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-5-philmd@redhat.com>
 <971287b0-fd62-21bb-e80e-8b83c8a5c459@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4488d878-09ff-5ea6-bc4b-69dda534131e@redhat.com>
Date: Sat, 3 Oct 2020 11:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <971287b0-fd62-21bb-e80e-8b83c8a5c459@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2020 10.03, Philippe Mathieu-Daudé wrote:
> On 9/30/20 12:43 AM, Philippe Mathieu-Daudé wrote:
>> KVM requires a cpu based on (at least) the ARMv7 architecture.
>>
>> Only enable the following ARMv4 CPUs when TCG is available:
>>
>>    - StrongARM (SA1100/1110)
>>    - OMAP1510 (TI925T)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/arm/Kconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 7d040827af..b546b20654 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -1,3 +1,7 @@
>> +config ARM_V4
>> +    bool
>> +    select TCG
> 
> This should be 'depends on TCG' because we can not
> *select* TCG, either we enabled it or not.
> 
> The problem is the machines are already selected in
> default-configs/arm-softmmu.mak, so we can not build
> the current config without TCG.

Is it really a problem? If the users disabled TCG and still have these 
machines in their arm-softmmu.mak, it's a configuration issue on their side, 
so it's ok if they get an error in that case.

  Thomas


