Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB0BC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DD82238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DD82238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqe1o-0001gV-6u
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqe1d-0001Ek-Fk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqe1c-0006rg-9k
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:43:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqe1c-0006rA-3S
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:43:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so50903431wrm.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zkQ7sQnwDMorLIlhTNPq0HCM/JDwJ4UrU6fFo56wPg0=;
 b=UYJDzUVJ1gJvdeL3anlCUr1KPdlq17mEsFxngpAkEwmZOI8lG/xMe4C58enSn9JsAj
 7olFaTwUmjfyOwad6yJYsLhflLo6kpywa+QRZ+oDvxJ9CR6s//w+TmgBcVShwMNPfd7Q
 76VBQUAfrNq32D+tVHOl8D9ToTrwrMY4rCZ0JW+L8MPMmhGWVSY6J4VCLNlbBBBf8bvw
 +tG/36+yiFfSC8x3c1o9kg4cM/Wi72Lo6dtBxGUaslfDPga70sW56JAVlmW+Kq3nepxo
 NrDeJYNY9H/oOv4Zy7Fdhom7TSK5bUtBYc3SEYzXu9pwYS63Z1VSwzrKGfxUkjLz5yT/
 pV2A==
X-Gm-Message-State: APjAAAXP8e6MrxA4cL3aUeka2Qpttjof7AXn3gUWwfzrRhBl698wFCrA
 pNVVBahdvRWjkGLMmZ3yEtWHSA==
X-Google-Smtp-Source: APXvYqzLR4YYuzhLqLajJEcnf4sNLYY+510NwGnNM0G+dB3BCBZAAx4UE0y0k2LrJALE4SLW5a3+lA==
X-Received: by 2002:a05:6000:112:: with SMTP id
 o18mr14028790wrx.153.1564062194365; 
 Thu, 25 Jul 2019 06:43:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id v18sm53570436wrs.80.2019.07.25.06.43.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 06:43:13 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
Date: Thu, 25 Jul 2019 15:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 15:26, Stefan Hajnoczi wrote:
> The microvm design has a premise and it can be answered definitively
> through performance analysis.
> 
> If I had to explain to someone why PCI or ACPI significantly slows
> things down, I couldn't honestly do so.  I say significantly because
> PCI init definitely requires more vmexits but can it be a small
> number?  For ACPI I have no idea why it would consume significant
> amounts of time.

My guess is that it's just a lot of code that has to run. :(

> Until we have this knowledge, the premise of microvm is unproven and
> merging it would be premature because maybe we can get into the same
> ballpark by optimizing existing code.
> 
> I'm sorry for being a pain.  I actually think the analysis will
> support microvm, but it still needs to be done in order to justify it.

No, you're not a pain, you're explaining your reasoning and that helps.

To me *maintainability is the biggest consideration* when introducing a
new feature.  "We can do just as well with q35" is a good reason to
deprecate and delete microvm, but not a good reason to reject it now as
long as microvm is good enough in terms of maintainability.  Keeping it
out of tree only makes it harder to do this kind of experiment.  virtio
1 seems to be the biggest remaining blocker and I think it'd be a good
thing to have even for the ARM virt machine type.

FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
and ~25 ms in the kernel.  I must say that's pretty good, but it's still
30% of the whole boot time and reducing it is the hardest part.  If
having microvm in tree can help reducing it, good.  Yes, it will get
users, but most likely they will have to support pc or q35 as a fallback
so we could still delete microvm at any time with the due deprecation
period if it turns out to be a failed experiment.

Whether to use qboot or SeaBIOS for microvm is another story, but it's
an implementation detail as long as the ROM size doesn't change and/or
we don't do versioned machine types.  So we can switch from one to the
other at any time; we can also include qboot directly in QEMU's tree,
without going through a submodule, which also reduces the infrastructure
needed (mirrors, etc.) and makes it easier to delete it.

Paolo

(*) I measured 15ms in SeaBIOS and 5ms in qboot from the first to the
last write to 0xcf8.  I suspect part of qboot's 10ms boot time actually
end up measured as PCI in SeaBIOS, due to different init order, so the
real firmware cost of PAM and PCI initialization should be 5ms for qboot
and 10ms for SeaBIOS.

