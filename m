Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E248EC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFCC2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFCC2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRlY-0005nO-QZ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 08:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoRlO-0005Nr-3h
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoRlN-0005Y0-9s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:13:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoRlN-0005X9-3U
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:13:25 -0400
Received: by mail-wr1-f46.google.com with SMTP id n9so6975721wrr.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 05:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JRgG0Xb5vhz5ANjlFTctXBA+oY08VXqfEZlVsiKgjAA=;
 b=QUy8KHB1fd2eyMH3ZMkhHoaP/hCZwsE3RIQRUfybb4uEYeFEZ85oELlkhwHftP3Iad
 NlYs4h/8RKvpzUNXKBtlVtd1CmsKgmxzMU1TtaKFFzPue1F6wWzo/hrGcaDeBEozYIh9
 bU/cGt7JRvLJ2P6Dvuf6HbvhXRQYyRG2WfekiHRqVxpiHy2AxchIWtUuTyLAlV4Usc+f
 LkeY0J1TlWsvA67s4EAESpgIi2vexIHVXS4DbrhHJye0H2IDXnsdPoyyuNJUsuMD7ts4
 GXKkevHeYbiqwyW4aRWxfWG2w8iDgIDpKekzmqGSHN1tpB+j+QBx+lCaTMjm1+xHzx3o
 d51w==
X-Gm-Message-State: APjAAAXdNBgp3DNVPDUUtwEuev1fbts1viaLwYuBhb61ZkKT1R/UmNPm
 leRjHipRTkKf0VxnF4ZHincK1w==
X-Google-Smtp-Source: APXvYqwOnqh37bqmtT8QyXW3FMR2u2MIq1ofF6h8Xa8w2Cz14pNWUI58LbhYfK+/4+SnuyeQmuw75w==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr50709880wrt.227.1563538403877; 
 Fri, 19 Jul 2019 05:13:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id o7sm27826541wmf.43.2019.07.19.05.13.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 05:13:23 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190719112315.14432-1-philmd@redhat.com>
 <1f5ee7a6-d78c-8d60-40ef-68032d7ef923@redhat.com>
 <CAFEAcA_hvqgH6cjJLARN7jfq+iJLoGPsx_RqVedc+SEtrRDu2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1863219c-ef52-b8e2-d6fc-fd70240d3d5a@redhat.com>
Date: Fri, 19 Jul 2019 14:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_hvqgH6cjJLARN7jfq+iJLoGPsx_RqVedc+SEtrRDu2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1] target/i386: Correct misplaced
 break statement in gen_shiftd_rm_T1()
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
Cc: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 13:51, Peter Maydell wrote:
>> I haven't looked closely at the code but I would guess that the
>> fallthrough is intended, because the default label has an "ot == MO_16"
>> condition.
> Yeah, this code is really weird -- if TARGET_X86_64 then
> MO_16 falls through into MO_32, but if only i386 then
> MO_16 falls through into the default case ?!?

Yes, and in either case MO_16 falls through into the 32-bit code.
However, the i386 32-bit version and the x86-64 64-bit version are
unified into a single piece of code for TARGET_LONG_BITS-bit operands.

Almost, because you still need that ugly special case for MO_16 in the
default label.

Paolo

