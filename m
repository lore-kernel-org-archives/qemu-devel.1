Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E012084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E012084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxcE-0008Pn-7B
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMxRq-00045F-LN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMxRp-0004aE-0b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMxRo-0004Zw-Oa
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:55:52 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6A67C04AC69
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 16:55:51 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id u17so2176848wmd.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H7ugKiL/Kpw5w93fZK98ssWHzL9FBxJXPh5vcqrz8Yw=;
 b=trUXPEjiWfIKMzWp0Hv92Mnm+wmGpxQ7rnXzI9MzHrsLdbzIv3LsvyEp9X2Z6WDH9V
 F1VEzmIksP5fklZBxE3fAldbvVVI28yk0JQ2uCNuvDF5/pYlFkTN+19vQglEk0Mj4ODp
 +BFWF8MpF4wph0dfEJ8YcMUvKDkjaJ8ns4E9Y6pJZZDuw92clI0+2qlJUBF7wPqHBrGO
 JnDj73SHzKk9g95JxTomUrOECdgJMoWwD5i2M7DTki25x53Ob0Aj4WAIlnf6KH86RrTK
 4M6dW5jJQpKA2wsqya596/9ORVGDvA9uALA/6pEjSvG8FKkvLwOJGnjdWbshAn9uoC9E
 LjEw==
X-Gm-Message-State: APjAAAVaALFnswTnwuLeh5iG38mfUpC5AHAD3I3hxCLOtd56N2GindsN
 nC9ZvBBqcdvrINNVp4DTgWovR7Ebh4CkeId94wiaZZxSwC3yAITotIQ7ykOT4TZeCz2daWM21W5
 azW3NimB6HTalL0o=
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr4029589wmg.46.1571763350371; 
 Tue, 22 Oct 2019 09:55:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcAL2ovxEemkcDaBwMIJCIy+WJYc/2M6aoygBw5OKXDjZCR1q5QWxb12G/EVOXqD8pSaQCrw==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr4029572wmg.46.1571763350086; 
 Tue, 22 Oct 2019 09:55:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id h17sm16264637wmb.33.2019.10.22.09.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 09:55:49 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/i386/pc: Extract pc_gsi_create() and
 pc_i8259_create()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018135910.24286-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <22db5316-648a-9416-87b5-a76772e8539e@redhat.com>
Date: Tue, 22 Oct 2019 18:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018135910.24286-1-philmd@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/10/19 15:59, Philippe Mathieu-Daud=C3=A9 wrote:
> These are few patches extracted from the previous too big series:
> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
>=20
> Dropped "Move kvm_i8259_init() declaration to sysemu/kvm.h" (thuth),
> no logical changes:

I queued this, but neither I nor patchew got patch 5.  I just got it
from the PIIX3/i440FX series.

paolo

> $ git backport-diff -u pc_split_i440fx_piix-v1
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/5:[----] [-C] 'hw/i386/pc: Extract pc_gsi_create()'
> 002/5:[----] [--] 'hw/i386/pc: Reduce gsi_handler scope'
> 003/5:[----] [--] 'hw/i386/pc: Move gsi_state creation code'
> 004/5:[----] [--] 'hw/i386/pc: Extract pc_i8259_create()'
> 005/5:[----] [--] 'hw/i386/pc: Remove kvm_i386.h include'
>=20
> Based-on: <20191018134754.16362-1-philmd@redhat.com>
> hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge [v2]
> https://mid.mail-archive.com/20191018134754.16362-1-philmd@redhat.com
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/i386/pc: Extract pc_gsi_create()
>   hw/i386/pc: Reduce gsi_handler scope
>   hw/i386/pc: Move gsi_state creation code
>   hw/i386/pc: Extract pc_i8259_create()
>   hw/i386/pc: Remove kvm_i386.h include
>=20
>  hw/i386/pc.c         | 36 +++++++++++++++++++++++++++++++++++-
>  hw/i386/pc_piix.c    | 23 ++---------------------
>  hw/i386/pc_q35.c     | 28 ++++------------------------
>  include/hw/i386/pc.h |  3 ++-
>  4 files changed, 43 insertions(+), 47 deletions(-)
>=20


