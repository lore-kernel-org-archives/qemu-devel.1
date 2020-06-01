Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C13C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3546620734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYhjlz/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3546620734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfdoR-0004CN-F4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 02:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdnl-0003ht-JB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:20:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdnj-0000wj-2a
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590992397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cYruizeJ/rIOK3cK0cm1JFZilzI0quqyXTyEfoKqqF4=;
 b=hYhjlz/rlb1ryKGqEVYANxBO7x0VLyuggzDqWYF4pKXyspQetXAH4guq8i/wLiqYFzdPKL
 A7zUPJOaRO9jW6twae/l8oTfkMkU7C1rtNFXxZf8CRlTQk7em5SSdKSOwl85K7W7IFZadX
 MYifDZUIIJzDr0Ghwa1i1kUb9yn5rr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-0MR-lhDCPLmsIylA0KO_qw-1; Mon, 01 Jun 2020 02:19:54 -0400
X-MC-Unique: 0MR-lhDCPLmsIylA0KO_qw-1
Received: by mail-wr1-f72.google.com with SMTP id t5so4443694wro.20
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 23:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rK2XJJTmQjaq1lTJxBKe/RFIaXAMzyN5WbVE2l5yOT8=;
 b=fgj7Y3s2KklByTNIQwDOQbwuTK7kz6rfioK9xzIaWY5cBMS7m/NvHjrhTCd5PffOHR
 4GTjy8iD0KPgLVUiNuwTBq/MWlcCv+2RaEjucXhPhUPIDmvzNR2S8KBN/mTwb7YQzw2U
 2h5ayEVXdTX53Of/KzUEg/HYIYizLGfqLbmh/SFfMnq0GTTPai6Lig34aokrslQI85TT
 b/NswVCtjerxjdtyN4jy4rZRy3dSV37C2g3+mHTMiWrCuZY8mp93ugD4nHoqWhjTIbzc
 UeSjM25YzC7XigFSaELcL2JJeKy2MpHU8XerW5mMgssGs1rFFxr/HOashna0mnAhPhGe
 awTA==
X-Gm-Message-State: AOAM532P3mOIS1UJuple0zpbmPpk5FDRXd9fMw9dmkqjila7KhWPMu5W
 hpXYidocnbE/dnbM8ApsKbgg5JfBGPPJBuqt9VsHvDO7AxyNwpJ+591uuRESpOEXya+OvO8OmgI
 wHuzO7bzPrVC3tRE=
X-Received: by 2002:a1c:7517:: with SMTP id o23mr5844255wmc.7.1590992393019;
 Sun, 31 May 2020 23:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa7RfWZKfO9ty7JKrGpSrVWix/8ObE7yIFZjb+wgHF4eo3ItZ6VockT0V0LZdOWHALkYVm0A==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr5844239wmc.7.1590992392717;
 Sun, 31 May 2020 23:19:52 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id u74sm10223307wmu.13.2020.05.31.23.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 23:19:51 -0700 (PDT)
Subject: Re: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
To: Robert Henry <robhenry@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <BL0PR2101MB1026CD468E4F0929086C177FD68D0@BL0PR2101MB1026.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <0670bf89-5b16-3a58-ef2f-d063ee9d5a5e@redhat.com>
Date: Mon, 1 Jun 2020 08:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <BL0PR2101MB1026CD468E4F0929086C177FD68D0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:19:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Robert.

Top-posting is difficult to read on technical lists,
it's better to reply inline.

Cc'ing the X86 FPU maintainers:

./scripts/get_maintainer.pl -f target/i386/fpu_helper.c
Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)

On 6/1/20 1:22 AM, Robert Henry wrote:
> Here's additional information.
> 
> All of the remill tests of the legacy MMX instructions fail. These
> instructions work on 64-bit registers aliased with the lower 64-bits of
> the x87 fp80 registers.  The tests fail because remill expects the
> fxsave64 instruction to deliver 16 bits of 1's (infinity or nan prefix)
> in the fp80 exponent, eg bits 79:64.  Metal does this, but QEMU does not.

Metal is what matters, QEMU should emulate it when possible.

> 
> Reading of Intel Software development manual, table 3.44
> (https://www.felixcloutier.com/x86/FXSAVE.html#tbl-3-44) says these 16
> bits are reserved, but another version of the manual
> (http://math-atlas.sourceforge.net/devel/arch/ia32_arch.pdf) section
> 9.6.2 "Transitions between x87 fpu and mmx code" says a write to an MMX
> register sets those 16 bits to all 1s.

You are [1] here answering [2] you asked below.

> 
> In digging through the code for the implementation of the SSE/mmx
> instruction pavgb I see a nice clean implementation in the SSE_HELPER_B
> macro which takes a MMXREG which is an MMREG_UNION which does not
> provide, to the extent that I can figure this out, a handle to bits
> 79:64 of the aliased-with x87 register.
> 
> I find it hard to believe that an apparent bug like this has been here
> "forever". Am I missing something?

Likely the developer who implemented this code didn't have all the
information you found, nor the test-suite, and eventually not even the
hardware to compare.

Since you have a good understanding of Intel FPU and hardware to
compare, do you mind sending a patch to have QEMU emulate the correct
hardware behavior?

If possible add a test case to tests/tcg/i386/test-i386.c (see
test_fxsave there).

> 
> Robert Henry
> ------------------------------------------------------------------------
> *From:* Robert Henry
> *Sent:* Friday, May 29, 2020 10:38 AM
> *To:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> *Subject:* ia-32/ia-64 fxsave64 instruction behavior when saving mmx
>  
> Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy
> SSE mmx registers. The mmx registers are saved as if they were fp80
> values. The lower 64 bits of the constructed fp80 value is the mmx
> register.  The upper 16 bits of the constructed fp80 value are reserved;
> see the last row of table 3-44
> of https://www.felixcloutier.com/x86/fxsave#tbl-3-44
> 
> The Intel core i9-9980XE Skylake metal I have puts 0xffff into these
> reserved 16 bits when saving MMX.
> 
> QEMU appears to put 0's there.
> 
> Does anybody have insight as to what "reserved" really means, or must
> be, in this case?

You self-answered to this [2] in [1] earlier.

> I take the verb "reserved" to mean something other
> than "undefined".
> 
> I came across this issue when running the remill instruction test
> engine.  See my
> issue https://github.com/lifting-bits/remill/issues/423 For better or
> worse, remill assumes that those bits are 0xffff, not 0x0000
> 

Regards,

Phil.


