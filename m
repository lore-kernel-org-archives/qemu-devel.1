Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4595E207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i51HvJJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4595E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6CKs-0002hc-Fv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k6CJM-0001QS-Li
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:26:24 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k6CJK-0003Eh-T4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:26:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id 189so2096195pgg.13
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fecvo+dx1PLdLDHSkp6XpVInl4ld6x8XcMudkHyqd5w=;
 b=i51HvJJPsqJy9bZSK8a+NCSYDBeUDXH6JGd7M2pyqOBdYbTHAOgDHj9Q/zYSTQ57gH
 LgpeCCaCaUavscIAfOupWtXn9rRUjDSDod/h4YtYcSv73SeoQT3jYe0ETwWr29JJDWIE
 SUacZOHLc/UOpbsY1OSaSKRI3nchkhY2s6qgFPhG6bdtfaXos3eaHwADqMlSgu/oLEWQ
 NWI9dz/kzhYvcdlY2bydwqs98mCKIMHkrosYj9SmY8wGnoVtWaS/dqcYbU/RA2Y/pDzH
 3Lnzum74F4BKZT8q/u0SHYh6xSlO9W9HuGZsLHtslp2SzrRURLLL9wW0T2JfqFmpFb1k
 Yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fecvo+dx1PLdLDHSkp6XpVInl4ld6x8XcMudkHyqd5w=;
 b=VFU7C8q4aoGmqPF2jvep+ka4ssFrnVcOMaDOCRufSv2Y2V8iN4fC91Ku+uSk81yAyx
 rHYBrticgkIFSe3UHbBlg9rilvP52P5B0wKw0N45eIzSNTEl1almFHCTDGZKYcZiarUs
 UbKOjWF2lH6OZfWUl6I435B+EnIHmCewpvoTjd3vCBvw/HWquCP7dlvV9e40nIEwVY6l
 P0GHs4AJz9YOdV6MhWwRiK++bieTFN/Dfhcang6E2Rir0h9QJa0XEFIjHqhK1qApSIEe
 0Z41XINKLf7f2JpHq2eGYf7NojQoqYM1wON8H6kJjMRwOM1RSlyopejzuS96r80Bl9F8
 kChg==
X-Gm-Message-State: AOAM530OQyUBAgFo68OAI6kZuPPHQnNAWyrw6pM/8JXL1ds66vHLyCDd
 OUg0NVXwHbsJt5MOeN8Lo+s4RTz+NjRN1WKqxFXTHg==
X-Google-Smtp-Source: ABdhPJzOgyD6p6qdx4xY9eHwxyDX6BgaDBG4OvnAGXu7pHRIFQODqwNlODOBw2xtl8MSUEWETPXxFczcQ8tUCCQ+BEs=
X-Received: by 2002:a62:7dd5:: with SMTP id y204mr4275769pfc.318.1597321580917; 
 Thu, 13 Aug 2020 05:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
 <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
 <CAAeHK+zD3ZdjpZOBny3QuYtKe-qzhmEfd9w+nr3NrzEuzHHRvw@mail.gmail.com>
 <CAFKCwrjSU89jiUbzd8Ys8nV6NDCJer=FbUnGWv8m0p0E+9MdVg@mail.gmail.com>
 <f3e2717b-878c-f6cf-51dc-fe2c372a7b41@arm.com>
In-Reply-To: <f3e2717b-878c-f6cf-51dc-fe2c372a7b41@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 13 Aug 2020 14:26:08 +0200
Message-ID: <CAAeHK+zKVGPOy9sRmNR9TLSa8Kz98UUrrGUNcqpfRq6H=A3=sw@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Evgenii Stepanov <eugenis@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>,
 Branislav Rankov <Branislav.Rankov@arm.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 Elena Petrova <lenaptr@google.com>, Kostya Serebryany <kcc@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=andreyknvl@google.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Aug 13, 2020 at 12:01 PM Kevin Brodsky <kevin.brodsky@arm.com> wrot=
e:
>
> On 12/08/2020 20:06, Evgenii Stepanov wrote:
>
> On Wed, Aug 12, 2020 at 11:03 AM Andrey Konovalov <andreyknvl@google.com>=
 wrote:
>>
>> On Wed, Aug 12, 2020 at 7:52 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>> >
>> > On 8/12/20 10:38 AM, Andrey Konovalov wrote:
>> > > On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
>> > > <richard.henderson@linaro.org> wrote:
>> > >>
>> > >> As reported by Andrey, I was missing the complete ISS info for
>> > >> the Data Abort raised upon a synchronous tag check fail.
>> > >>
>> > >> The following should fix that.  All the twisty little rules for
>> > >> the ISS.ISV bit are already handled by merge_syn_data_abort.
>> > >> Probably the most important bit that was missing was ISS.WnR,
>> > >> as that is independent of ISS.ISV.
>> > >>
>> > >> Andrey, will you please test?
>> > >
>> > > Looks like WnR is now being set properly, but SAS is still always 0.
>> >
>> > Are you looking at ESR_EL1?
>> >
>> > On page D13-2992 of revision F.a:
>> >
>> > # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.
>> >
>> > which means that ISS[23:14] are RES0, which includes SAS.
>>
>> +more Arm and Google people
>>
>> Is this known? Do we not get access size when MTE fault happens?
>
>
> It sounds like this applies to all data abort exceptions, no matter MTE o=
r not.
>
>
> Correct. For data aborts in general, the extra syndrome information in IS=
S[23:14] is only provided at EL2, in order to help hypervisors emulate simp=
le loads/stores (that access device memory) by looking at ESR_EL2 without h=
aving to decode the trapped instruction.

OK, got it.

The WnR bit works properly though, so

Tested-by: Andrey Konovalov <andreyknvl@google.com>

for the series.

> Did you have any particular use-case in mind for SAS being set even in ES=
R_EL1?

Yes, we could use that to extract the size of the access that caused
the fault to print more informative KASAN reports. We usually have a
header like:

BUG: KASAN: slab-out-of-bounds in usb_destroy_configuration+0x636/0x6d0
Read of size 8 at addr ffff8881c7e3c758 by task kworker/1:7/3434

