Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F8AC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2BC218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2BC218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeCT-0006mM-SH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqeCJ-0006Mr-VQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqeCI-0003xI-Ra
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:54:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqeCI-0003wz-NK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:54:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id v22so36447042qkj.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/E71BZIb+jh/GZEIRucOCuQ+V3aBDD4v9txMUAqPg6c=;
 b=h6f4BChC/nJ3M3td3Hm5/tp0vF84gZm9agY9ar7GqZdVuubu1GeY4T5mN9+/0G5TML
 EW283GAIDWT64brK5Ie8+1bGVlfviBQIe4mEzRxIgsW7NTVr/FXa9KkD/ZHKaqgl/xej
 MosM88oTIWnIORNjYX8MZYtAxn6W7D97I6kYjsMiST37pX1Tp3iWgGex/L9MneIMgofk
 VUbrwHKUtfdoSlOE9RqfxrbiK9jdxfdIH9ppk3PiDKM99uW92n/+zo//zBMLUmn8/je6
 p8g2mIxqHzfKS1gIzZs7WII4v/pM+0xxkes5Z6MED7iPF0EFwfxYf6mZGBXOoBs6Fju/
 9Pnw==
X-Gm-Message-State: APjAAAXlHEQoy93rKo840S8heBVeNEDNbCCUnBryA9OGbZmTgwK3FjRg
 FyIYMXx0q6rU9uBo90AypMYM2g==
X-Google-Smtp-Source: APXvYqyau5tB5GpOQmJqCs/WH/wL0/biYoXKXc4fKk8/Glo7bGAuzdXe9paO0q78QOJIPoIuZkvlAw==
X-Received: by 2002:a37:b843:: with SMTP id i64mr56200664qkf.77.1564062858244; 
 Thu, 25 Jul 2019 06:54:18 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 b13sm30572380qtk.55.2019.07.25.06.54.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 06:54:17 -0700 (PDT)
Date: Thu, 25 Jul 2019 09:54:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725094837-mutt-send-email-mst@kernel.org>
References: <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
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
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 03:43:12PM +0200, Paolo Bonzini wrote:
> On 25/07/19 15:26, Stefan Hajnoczi wrote:
> > The microvm design has a premise and it can be answered definitively
> > through performance analysis.
> > 
> > If I had to explain to someone why PCI or ACPI significantly slows
> > things down, I couldn't honestly do so.  I say significantly because
> > PCI init definitely requires more vmexits but can it be a small
> > number?  For ACPI I have no idea why it would consume significant
> > amounts of time.
> 
> My guess is that it's just a lot of code that has to run. :(
> 
> > Until we have this knowledge, the premise of microvm is unproven and
> > merging it would be premature because maybe we can get into the same
> > ballpark by optimizing existing code.
> > 
> > I'm sorry for being a pain.  I actually think the analysis will
> > support microvm, but it still needs to be done in order to justify it.
> 
> No, you're not a pain, you're explaining your reasoning and that helps.
> 
> To me *maintainability is the biggest consideration* when introducing a
> new feature.  "We can do just as well with q35" is a good reason to
> deprecate and delete microvm, but not a good reason to reject it now as
> long as microvm is good enough in terms of maintainability.  Keeping it
> out of tree only makes it harder to do this kind of experiment.  virtio
> 1 seems to be the biggest remaining blocker and I think it'd be a good
> thing to have even for the ARM virt machine type.

Yep. E.g. virtio-iommu guys wanted that too.

> FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
> and ~25 ms in the kernel.

How did you measure the qemu time btw?

>  I must say that's pretty good, but it's still
> 30% of the whole boot time and reducing it is the hardest part.  If
> having microvm in tree can help reducing it, good.  Yes, it will get
> users, but most likely they will have to support pc or q35 as a fallback
> so we could still delete microvm at any time with the due deprecation
> period if it turns out to be a failed experiment.
> 
> Whether to use qboot or SeaBIOS for microvm is another story, but it's
> an implementation detail as long as the ROM size doesn't change and/or
> we don't do versioned machine types.  So we can switch from one to the
> other at any time; we can also include qboot directly in QEMU's tree,
> without going through a submodule, which also reduces the infrastructure
> needed (mirrors, etc.) and makes it easier to delete it.
> 
> Paolo
> 
> (*) I measured 15ms in SeaBIOS and 5ms in qboot from the first to the
> last write to 0xcf8.  I suspect part of qboot's 10ms boot time actually
> end up measured as PCI in SeaBIOS, due to different init order, so the
> real firmware cost of PAM and PCI initialization should be 5ms for qboot
> and 10ms for SeaBIOS.

