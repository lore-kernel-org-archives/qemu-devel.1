Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7659A2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfKA-0002KL-8I
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNdsR-00033Y-69
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNdsQ-00037b-2D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNdsP-00036x-Bk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:14:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61973C049E12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:14:07 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v8so12053877wrt.16
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G0Md8s6CdlET5hdyzfeMGq57+JfqtM8PWGHbNWw9yJA=;
 b=TIeflt9bPHK6UnBdztJUBBvAL9QvNH0uyOWhIY1yPOdmyC6GTRIthOxeHu64K5+K/v
 sqxuCHzWTKpJ6mB97zXCSoBZVcRv7qKND1ZXmqWF900o38Hgn2yHl+Y5hxK3CwWloVmS
 aTw43UjueLBeumZ6ZRPw//ccL/QPk5oD96rqo4Yr9o/ahfwcQd23Q3PJ1880+lwoEere
 TN4X3DpzEsZfkRtwqNDZch6bpxnJkroRox6LLXT2YsoqxaE3C+OGR6LY085InZjg4Jb2
 RL4j95M2bBUSHZicnf4Xce8raq27lCezTejLWDQnnOCRvSEX98I3yR0o+X1rH3dceU1X
 HsZw==
X-Gm-Message-State: APjAAAUMs8rE93rNJCe/mr7FGTlsuYz488STPL9d8Ama+IL+cnDSc6J2
 sMAasQHjvL9+1tCi4Gu0utsmwb+Z02mPXA8ZbwTb+DboZeIszQIXsK164Oj71FrbHnJvjgwbZIq
 pup4dYnc/GYnUEac=
X-Received: by 2002:a1c:a551:: with SMTP id o78mr4852291wme.4.1571926445955;
 Thu, 24 Oct 2019 07:14:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwotk77Lz+dGfc3FcB3lDFzQ7rZxwOkk2939qkRpQM1/9lwo3N+bDvdHN7po3fpzcZFEuFTw==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr4852257wme.4.1571926445639;
 Thu, 24 Oct 2019 07:14:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6887:47f9:72a7:24e6?
 ([2001:b07:6468:f312:6887:47f9:72a7:24e6])
 by smtp.gmail.com with ESMTPSA id z189sm3243798wmc.25.2019.10.24.07.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:14:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-2-richard.henderson@linaro.org>
 <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
 <e41a98e4-189a-1e0f-7b29-51a6e00e4d7e@redhat.com>
 <26cb0551-fbac-e059-c1bf-9c17420528b7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <af5b2cb5-49b5-68c2-e55b-a1077ad4df28@redhat.com>
Date: Thu, 24 Oct 2019 16:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26cb0551-fbac-e059-c1bf-9c17420528b7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/19 16:06, Richard Henderson wrote:
> On 10/24/19 8:04 AM, Paolo Bonzini wrote:
>> On 24/10/19 13:52, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>>> index ad9ab85eb3..255bb186ac 100644
>>>> --- a/include/exec/cpu-all.h
>>>> +++ b/include/exec/cpu-all.h
>>>> @@ -220,7 +220,7 @@ extern int target_page_bits;
>>>> =C2=A0 =C2=A0 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>>>> =C2=A0 #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
>>>> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) &
>>>> TARGET_PAGE_MASK)
>>>> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>>>> =C2=A0 =C2=A0 /* Using intptr_t ensures that qemu_*_page_mask is sig=
n-extended even
>>>> =C2=A0=C2=A0 * when intptr_t is 32-bit and we are aligning a long lo=
ng.
>>>> @@ -228,9 +228,8 @@ extern int target_page_bits;
>>>> =C2=A0 extern uintptr_t qemu_host_page_size;
>>>> =C2=A0 extern intptr_t qemu_host_page_mask;
>>>> =C2=A0 -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size=
 - 1) &
>>>> qemu_host_page_mask)
>>>> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) +
>>>> qemu_real_host_page_size - 1) & \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_r=
eal_host_page_mask)
>>>> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
>>>> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr),
>>>> qemu_real_host_page_size)
>>>> =C2=A0 =C2=A0 /* same as PROT_xxx */
>>>> =C2=A0 #define PAGE_READ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0001
>>>>
>>
>> Isn't this the patch where Richard pointed out that the compiler
>> generates worse code?
>=20
> Richard confused ROUND_UP with QEMU_ALIGN_UP.

Uh, those are both really badly named.  Especially considering that
DIV_ROUND_UP divides the result of QEMU_ALIGN_UP.  Should we consider
swapping them?!?

Paolo


