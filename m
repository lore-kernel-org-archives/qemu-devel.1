Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC19C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECDF20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clHdwUue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECDF20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrK3-0001hP-Ik
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrI5-0005xY-Hc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:55:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrI3-0007qa-RR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590090938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc4Xp9iP+y8ib2misl6Q6rQMS1Tn4Or4Kjqx/XnGrz4=;
 b=clHdwUuetl4RqJt0aBdFeuFIyackAB45klWWsTSkU0jCHdHMf1jJkKegx/ekunOx56Duyz
 S6LU1+kNQQqVk4vigRWCPUsNi0mnBsdMydexdn6pYE4C+4d5tuWKnKwlc64vB7QovqkhFz
 csfnaa2Uwmn3bvo23qTG364KX1rpDi8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-6W5ntqHkNge5GITUVnZFyQ-1; Thu, 21 May 2020 15:55:36 -0400
X-MC-Unique: 6W5ntqHkNge5GITUVnZFyQ-1
Received: by mail-wm1-f69.google.com with SMTP id j132so1524356wma.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wc4Xp9iP+y8ib2misl6Q6rQMS1Tn4Or4Kjqx/XnGrz4=;
 b=KB2Rv6OVjI8179f2P1PIeMQYZDL5TRPWCCBDCrEgoKHn9purs5QrmQ5QuneVMFxzyW
 /HFDss+SLeYP3nCMUln54KVnuIXnk9iOjd5t1ksyzZAfxw9rxWBzk+elTLdN1UfP6eEE
 Zy3gZycQVHd+dVkJQx+dFq7UsN9IkBZv1E+2vkReECE8o0llZte1DS6gxyCCc6d5uaMx
 nH1eWYeQCsnoMLMdz3Ha0D5p4i6hnJkk3yAK8y5vZdSxId+/BnazIMHXpxK8LH/rkxsp
 Vdw5LJ2tN/2Rhbb+CyT1OX4AKV7v3bF2nr+TmPcZxb9adoODKybVxaC4GLwsJSqDeaN1
 jS9w==
X-Gm-Message-State: AOAM532pOb0OUMEnIKEwYC/qZFZPayCa2TKI4E/R5QHyoLbYLSScggoV
 xH/B5GaFAbkTMJRXqrARFC4kc4iEKpXUBGU7NaVNK9c1xUWdopJWbBKhYrZsSCjEW/kh2WkioFF
 6GnIKaPnQNz0tX+M=
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr10217265wmf.186.1590090935430; 
 Thu, 21 May 2020 12:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw43/kqG0dsZ4AnRCLKoBgnNvFOF0SLgu16wnIZcENRLS8rbsa4da0XeebevXsV75Alchvrw==
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr10217230wmf.186.1590090935136; 
 Thu, 21 May 2020 12:55:35 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l19sm7846585wmj.14.2020.05.21.12.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 12:55:34 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] hw/semihosting: Make the feature depend of TCG, 
 and allow to disable it
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
 <20200515170804.5707-11-philmd@redhat.com>
 <a67da86e-8486-9fea-ae1c-db65bf5c4acc@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2810165c-62f9-1cc0-d610-115525d6a06a@redhat.com>
Date: Thu, 21 May 2020 21:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a67da86e-8486-9fea-ae1c-db65bf5c4acc@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:44 PM, Richard Henderson wrote:
> On 5/15/20 10:08 AM, Philippe Mathieu-Daudé wrote:
>> +++ b/hw/semihosting/Kconfig
>> @@ -1,3 +1,5 @@
>>   
>> +# default is 'n'
>>   config SEMIHOSTING
>> -       bool
>> +    bool
>> +    depends on TCG
>> diff --git a/target/arm/Kconfig b/target/arm/Kconfig
>> new file mode 100644
>> index 0000000000..3224cac4ad
>> --- /dev/null
>> +++ b/target/arm/Kconfig
>> @@ -0,0 +1,2 @@
>> +config SEMIHOSTING
>> +    default y if TCG
> 
> Do you really have to duplicate the TCG condition?

How so? The semihosting default table is:

       TCG KVM XEN
       y n y n y n
TCG y - - y y y y
     n   - n n n n
KVM y     - - n n
     n         n n
XEN y         - -
     n           -

So checking for TCG is the simpler way.

Maybe I'm not understanding well your question.

The logic is if TCG is selected, SEMIHOSTING is too.


