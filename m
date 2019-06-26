Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA6C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE51120663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE51120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3GX-0003KD-VP
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg3FT-0001qI-K7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg3FR-00036G-M1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:25:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg3FP-000340-Kx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:25:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so853570pgv.10
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=LFOzV1HAB5YbrrLVn2QUxks4Drn2dBZT/z9iHtEY4oI=;
 b=RlsMEyadkNerhyuphvSnt/Jmai71uwypFnbbsDoNw9tDP3KsZJWgNCp9nXhzyva30a
 gxHXWX45sp0MbK6pLuECVUzXjCwzooT+UAisUPudU30HWpXs0Jafy11tWZbnirPltSS1
 uouxRVEUyYIoOuBQYtVi7HSi8hcT/Swg32/CE16NbPieY8ZBbH091uEZwGN14pzi7G4z
 aaMiNlHgxLw5D8awDvBk/6ST/1UP6eVEVzp+Re3JoDjwo/78vm2mSyGst5hVSX3Jt33u
 o3bUiFVolqHocXAYfJ6vJc/Lc27eEb28u6uFAqvEZshxcAZyoFcwaLSFF6CJQlUH74sp
 CgPA==
X-Gm-Message-State: APjAAAWQGD6lTlSsqhkw8YdhzeGJA1beTs6NGCJWZYHT+UxSlKRAXYf4
 y6lYGSWo4N4rWNOMt6/JrBgLug==
X-Google-Smtp-Source: APXvYqxKpVZG8tQf1EG/3D2pbXuyChU/70OPQomkiN+YjtggcGg9JX+he3hoR6QxQgXKohCKi/giTQ==
X-Received: by 2002:a63:d756:: with SMTP id w22mr1736304pgi.156.1561537541046; 
 Wed, 26 Jun 2019 01:25:41 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id t13sm2154363pjo.13.2019.06.26.01.25.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 01:25:40 -0700 (PDT)
Date: Wed, 26 Jun 2019 01:25:40 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2019 01:24:35 PDT (-0700)
In-Reply-To: <5711ab6f-610c-b05a-c728-4a35a0963a2b@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-c3bf2d26-25cd-4f80-bfe9-741f9a969b3f@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 joel@sing.id.au, Alistair Francis <Alistair.Francis@wdc.com>, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 00:48:51 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/26/19 8:07 AM, Palmer Dabbelt wrote:
>> On Tue, 25 Jun 2019 08:36:28 PDT (-0700), richard.henderson@linaro.org wrote:
>>> On 6/24/19 8:08 PM, Joel Sing wrote:
>>>> Regarding the alignment for reservations, the
>>>> specification does require this, although I do not recall seeing any
>>>> enforcement
>>>> of this by qemu itself.
>>>
>>> Ah, I see it now.  Enforcement begins here:
>>>
>>> static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>>> {
>>>     REQUIRE_EXT(ctx, RVA);
>>>     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>>>                            ^^^^^^^^
>>>
>>> This will force softmmu (but notably not linux-user; a design limitation) to
>>> generate an alignment fault for an unaligned address.
>>
>> That was probably correct at the time the code went in, as the ISA used to
>> allow these to succeed but not be atomic.  No implementations did this, so as
>> part of the ratification process we just mandated that unaligned atomics always
>> trap.
>>
>> Is there a better way to fix this than just doing the alignment check
>> explicitly?
>
> You misunderstand.  The code is exactly correct as-is.  The alignment check
> happens implicitly as a part of the softmmu tlb resolution.

Sorry, I thought you said it wasn't happening for linux-user?  If it happens
for both then we're good.

