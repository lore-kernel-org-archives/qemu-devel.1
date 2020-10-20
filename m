Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C8A2224E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5pGKnQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C8A2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoMe-0000zY-G0
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUoLt-0008U5-C2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUoLr-0004Dh-JK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KgGYGpnLC1uOVxKz0kFw94mmZd132z/7pJevCY16i4=;
 b=E5pGKnQV8ll956ws0eFuggQh2OKMDpsZPHjats/32o5D5dfq56QR8qiTrZIJ+YXSmBh0Oj
 omLt938cWql7QYhEqevsxIM+0VCAlBr3HmvidRoFP/QNdPsBLir4GqXguXr8IExRiWknEa
 scxw+938UPPY2DWOXGHMDaCLIjeQoos=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-LHNkTootMEyTbai90b9_rg-1; Tue, 20 Oct 2020 05:54:41 -0400
X-MC-Unique: LHNkTootMEyTbai90b9_rg-1
Received: by mail-wr1-f69.google.com with SMTP id f11so588731wro.15
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 02:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1KgGYGpnLC1uOVxKz0kFw94mmZd132z/7pJevCY16i4=;
 b=NA9ePAQj1eQh42QKijMpiZG06WDjObt4W6fq2m2SKBKmv5eKNf1sZleMMo6acsqxdY
 uYzG9JBnCW7XNaSoNBaLzEHO8CECmjAgootgXQ9SniIANcGJyJRlcw7BeuY2oLF4gDKf
 X25dj3VpFcvbF46CPTT3PccMUY/tUGSvFODSrLkJlHQkX95nodT4iwZqd7Bzg86O3VmF
 iUu6uX2xFm4H/hGCEsqwKa8l5vwU6DS6vnSZ8WDfnM2DOtUQ8nvVpN0QS5rjf2jfHwIt
 xrdf+C4m+NzdGj7ebfsxmsRJgTZ7OEfnuhksRKSz6un7cQvSkHV78FdD+4LavO8/0OJO
 kDDw==
X-Gm-Message-State: AOAM533rdYNfUnfZ/ptIpa8eMHsaVlOU5maMh2IAM5LdaNi5FE7s5lQC
 wwbKeVchWUt4hArSxmVEs6b1QtDv5vxMr+YOamZF8ewHykfIo3vNgFBgjTk8oOtT/hQOeMsFltF
 gA1iAXxMW5i40l78=
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr2085394wmb.32.1603187679825; 
 Tue, 20 Oct 2020 02:54:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydol1q2+Nj4hGa9CAigMImUUJF0X9tz3HYOpw4T9xVtmqNecFrnWCeh+GdlqVY19IexcxCmw==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr2085372wmb.32.1603187679560; 
 Tue, 20 Oct 2020 02:54:39 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b63sm2079535wme.9.2020.10.20.02.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 02:54:38 -0700 (PDT)
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
 <20201020094419.GF287149@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e196d48-6735-5116-ade5-a9b138020aea@redhat.com>
Date: Tue, 20 Oct 2020 11:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020094419.GF287149@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Olaf Hering <olaf@aepfle.de>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 11:44 AM, Daniel P. Berrangé wrote:
> On Tue, Oct 20, 2020 at 11:29:01AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Olaf,
>>
>> On 10/20/20 11:16 AM, Olaf Hering wrote:
>>> This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f
>>>
>>> On Mon, Sep 07, Laszlo Ersek wrote:
>>>
>>>> In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
>>>> 2020-04-16), part of edk2-stable202005, the Brotli compressor /
>>>> decompressor source code that edk2 had flattened into BaseTools was
>>>> replaced with a git submodule.
>>>>
>>>> This means we have to initialize edk2's own submodules before building
>>>> BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
>>>> the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
>>>> well.
>>>
>>>> +++ b/roms/Makefile
>>>>    edk2-basetools:
>>>> +	cd edk2/BaseTools && git submodule update --init --force
>>>>    build-edk2-tools:
>>>> +	cd $(edk2_dir)/BaseTools && git submodule update --init --force
>>>
>>>
>>> This change can not possibly be correct.
>>>
>>> With current qemu.git#master one is forced to have network access to
>>> build the roms. This fails with exported (and complete) sources in an
>>> offline environment.
>>
>> The EDK2 roms are only used for testing, we certainly don't want them
>> to be used by distributions. I suppose the question is "why is this
>> rule called if tests are not built?".
> 
> I don't believe that is correct - the pc-bios/edk*  ROMs and the
> corresponding  pc-bios/descriptor files are there for real world
> end user consumption.   roms/edk2 should (must) match / reflect
> the content used to build the pci-bios/edk* blobs.
> 
> Many distros have a policy requiring them to build everything
> from source, so they will ignore the pre-built edk2 ROMs, but
> regular end users taking QEMU directly from upstream can certainly
> use our edk2 ROMs.

Well I'm lost (and I don't think mainstream QEMU have the
bandwidth to follow mainstream EDK2 security fixes) so I'm
giving up, waiting for clarification from Laszlo.

> 
> 
> Regards,
> Daniel
> 


