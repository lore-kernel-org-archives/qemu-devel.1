Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A685ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6953320B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNemTB8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6953320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIec-0000kr-5l
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIG1x-0003yu-IV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIG1v-0006IM-Sf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:45:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIG1v-0006Gh-7q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:45:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so3554039wma.5
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yvzTtE61LlSGrYWSiYlzQrdkE1Q+mKQ77cfhNLNMlug=;
 b=WNemTB8uVXHwNv392rTJ7LxGFk3ZbtgGNQdi/8M83/zcGK5BRjBEdK6JlKMitsdAQa
 3T03Rn/BhrrOTdnthk+v5PoNsP5KdhS3hkrrwR//bkv1wxFXLsAVg9VBC5FFqd1cCHpi
 R6LZqM6RyDZ1TxiWqckQYCGCmUyxz7gTSoN5cgKraty3c1tdnF0+WJ0CZ4O7UtpSCUpu
 udo+QIHdYDc6eON86hoUEFLKmUjIbni0vSQ2OlcL3iEbi5T+6XMTFCyy1kV+H1wu7RI7
 epWIC4NPTYqcoLc1jpKRsyyGfae5pDT/a3VEbe82RIfHkDiKOuIIxoKaL1HQOu1vSUHG
 ronA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yvzTtE61LlSGrYWSiYlzQrdkE1Q+mKQ77cfhNLNMlug=;
 b=gxOkJY4RvbOZhX18i17hhMNrXtW9e3QLhcKmPy8meTgTnEXvbDZDBjCKzehYzPf+x4
 qCKPPecn+kzNOx32NYVNT5DiM2RUPVtsvsROw+WK7+bHuuQYdTDaav4veyQz2OnbQ49d
 3TMWURgtsvMuEnqwalXcI1Rl8+UU3wSRvBCn/Ek+gJqscX/80zmD0V/WZFYlFgg5/5pg
 VuuWyttnguz+s6TjMx7rMM+oyo6XNYZovjr4G15bk+aHmZXKw6VlctWcuBhCA+51XjRN
 9Xq4CuAjIEnNjktmiAOZxtIIuT04eG2Tm8BNcV1u3CRF6xEkWZEVOkyO0i0jguqXcDpk
 SvkQ==
X-Gm-Message-State: APjAAAUIYE4+h8hCcuCkZCw6hBbzpPEGMeVr4wotA0miFoyXMkPurUVz
 HEcWbbMIDjIdPa0sYthSpsSbPA==
X-Google-Smtp-Source: APXvYqzaUiGbDcKHLy2IbOHAH7wFSSRSxTofbK80k7hfpwyCFFWKjpwFMss4wwUWAHT5BQH1kItaSA==
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr3659127wme.60.1570643138885; 
 Wed, 09 Oct 2019 10:45:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 90sm4264847wrr.1.2019.10.09.10.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 10:45:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F19EC1FF87;
 Wed,  9 Oct 2019 18:45:36 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-25-alex.bennee@linaro.org>
 <20190801141431.GK5034@quinoa.localdomain>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Subject: Re: [PATCH v4 24/54] plugins: implement helpers for resolving hwaddr
In-reply-to: <20190801141431.GK5034@quinoa.localdomain>
Date: Wed, 09 Oct 2019 18:45:36 +0100
Message-ID: <877e5dn77j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard
 Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Jul 31 17:06, Alex Benn=C3=A9e wrote:
>> We need to keep a local per-cpu copy of the data as other threads may
>> be running. We use a automatically growing array and re-use the space
>> for subsequent queries.
>
> [...]
>
>> +bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
>> +                       bool is_store, struct qemu_plugin_hwaddr *data)
>> +{
>> +    CPUArchState *env =3D cpu->env_ptr;
>> +    CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);
>> +    target_ulong tlb_addr =3D is_store ? tlb_addr_write(tlbe) : tlbe->a=
ddr_read;
>> +
>> +    if (tlb_hit(tlb_addr, addr)) {
>> +        if (tlb_addr & TLB_MMIO) {
>> +            data->hostaddr =3D 0;
>> +            data->is_io =3D true;
>> +            /* XXX: lookup device */
>> +        } else {
>> +            data->hostaddr =3D addr + tlbe->addend;
>> +            data->is_io =3D false;
>> +        }
>> +        return true;
>> +    }
>> +    return false;
>> +}
>
> In what cases do you expect tlb_hit() should not evaluate to true here?
> Will returns of false only be in error cases, or do you expect it can
> occur during normal operation? In particular, I'm interested in ensuring
> this is as reliable as possible, since some plugins may require physical
> addresses.

Only if the API is misused and a call made outside of the hooked memory
operation. An assert would be too strong as the plugin could then bring
down QEMU - I guess we could use some sort of error_report...

>
>> +struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t=
 info,
>> +                                                  uint64_t vaddr)
>> +{
>> +    CPUState *cpu =3D current_cpu;
>> +    unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
>> +    struct qemu_plugin_hwaddr *hwaddr;
>> +
>> +    /* Ensure we have memory allocated for this work */
>> +    if (!hwaddr_refs) {
>> +        hwaddr_refs =3D g_array_sized_new(false, true,
>> +                                        sizeof(struct qemu_plugin_hwadd=
r),
>> +                                        cpu->cpu_index + 1);
>> +    } else if (cpu->cpu_index >=3D hwaddr_refs->len) {
>> +        hwaddr_refs =3D g_array_set_size(hwaddr_refs, cpu->cpu_index + =
1);
>> +    }
>
> Are there one or more race conditions with the allocations here? If so,
> could they be solved by doing the allocations at plugin initialization
> and when the number of online cpu's changes, instead of lazily?

It might be easier to just keep a __thread local array here and let TLS
deal with it.

--
Alex Benn=C3=A9e

