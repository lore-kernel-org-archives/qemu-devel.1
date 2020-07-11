Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EA0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B631206A5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdv00lGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B631206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBzp-0003J5-Pw
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1juBz4-0002a9-5b
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1juBz1-0004Xc-F2
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594460385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4XfImlVl/gb7TZJN6rJiv9jnEqnDhryzaYWdOVQ/KQ=;
 b=Kdv00lGAssvGqw2n/ATgOchr+Qg8ay6oo9Q3atHlE+CSMzC6dizwscTTZCsiuHW+ODj84T
 O9fx8WTyIlyJeT3N7KPpapQAKxYpmezxSbXxKrKR1/BkJQPHpGCP332DIocXb12BEkmWSv
 uGBrCm1aNfogMUIE3IJnPQ0Kug9upbs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-9_Hnc7SLNXCkQhMlcXFAxA-1; Sat, 11 Jul 2020 05:39:43 -0400
X-MC-Unique: 9_Hnc7SLNXCkQhMlcXFAxA-1
Received: by mail-wr1-f70.google.com with SMTP id c6so9392517wru.7
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 02:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4XfImlVl/gb7TZJN6rJiv9jnEqnDhryzaYWdOVQ/KQ=;
 b=LG3Ma93SUPFixDhZU8rDhyNsd3oSbX2XAOmeVPd+w4b2Rinw68cLBX8+/DNyseOVfC
 W3JbyAuyMzeM+3DPSacG25Rg6b6REvm7wu64XA3yFIxmOy+/l5tBaCbIK1/83ghgpIdS
 yo7fOCO6USzbC6/SYfmqdqtJGz94QShAixKYY/94xsKWBngyS08nHhYp+PGefOHvu7di
 wJCAyTOroD1I46vdWMm/kn8a9/Y3j3e966rlUURzBpVQk2v4rifhZmlmXz8+GyOkmb16
 h5OdEI9uvG+ZUbVch1ZDcOczce2G+zdDTAsAdUIzt6U65S2zEBUnOBaDIEdVVBB4p16p
 K0XQ==
X-Gm-Message-State: AOAM530vHHjjx9qzoIragt6v2acqVccqgbk8N9vvNAdDVPplORWr7uKU
 hrOq2epmb537gQlNGUVN4wak44b98VnUNkdjAxO8bH1eL8BMH5Ysmcfh8bYdxbje6l9eCqDcl2q
 xFu30bnHEVZ410Ls=
X-Received: by 2002:adf:f751:: with SMTP id z17mr74688815wrp.114.1594460382487; 
 Sat, 11 Jul 2020 02:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPloKEq72Vx4b+L/gdiV8/H4DQFntmKX5nc2lNjbdxJgdWzHzOiNSuBoZ9t4u9AcyDgn62pA==
X-Received: by 2002:adf:f751:: with SMTP id z17mr74688787wrp.114.1594460382156; 
 Sat, 11 Jul 2020 02:39:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ef:39d9:1ecb:6054?
 ([2001:b07:6468:f312:ef:39d9:1ecb:6054])
 by smtp.gmail.com with ESMTPSA id h23sm12565626wmb.3.2020.07.11.02.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 02:39:41 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
 <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
 <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <76aac4ac-40f5-4870-ed2b-bab8b68b0a64@redhat.com>
Date: Sat, 11 Jul 2020 11:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 05:39:45
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/20 11:14, Claudio Fontana wrote:
> On 7/11/20 12:45 AM, Paolo Bonzini wrote:
>> On 10/07/20 06:36, Thomas Huth wrote:
>>>
>>> In short this goes away if I again set icount to enabled for qtest,
>>> basically ensuring that --enable-tcg is there and then reenabling icount.
>>>
>>> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
>>> instead of using a separate counter.
>>
>> Why would it need a separate counter?  In both cases it's a
>> manually-updated counter that is used for QEMU_CLOCK_VIRTUAL.  The only
>> difference is that shift > 0 doesn't make sense for qtest.
> 
> I think I would reverse the question. Why reuse for qtest a counter that has absolutely nothing to do with it?
> 
> qtest has nothing to do with instruction counting.

Apart from the name, icount is more like deterministic execution than
instruction counting (it's not a coincidence that record/replay is
fundamentally based on icount).  qtests need to be deterministic and
describe which qtest instructions run before a given timer fires and
which run after.

And in both cases, determinism is achieved by controlling the
advancement of QEMU_CLOCK_VIRTUAL.  It's only this central component of
icount that is shared by qtest and TCG, and I think the problem is that
this patch conflates all of them together:

- the basic "is QEMU_CLOCK_VIRTUAL software-driven" part is embedded in
qemu-timer and should not be carved out into a separate module.  This
includes the use_icount variable, which should be kept in core QEMU code.

- the fact qtest uses -icount instead of configuring the variables
directly is definitely a hack and can be removed.

- the adaptive frequency adjustment is definitely TCG specific, and so
are the particular functions in cpus.c that test icount_enabled() and
broke with this patch.  All this code should be included in the TCG
module only or, before that, should be made conditional on $(CONFIG_TCG).

So I think this patch should have been the last, not the first. :)  Once
you move all the accelerator runtime code from cpus.c to separate files,
it will be possible to move the frequency adjustment and deadline
management code into accel/tcg.  And then it will be obvious which code
is not TCG-specific and can be extracted for convenience into a
cpu-timers.c file.

Thanks,

Paolo


