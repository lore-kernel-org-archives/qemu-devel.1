Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686FC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A2F22ADA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2F22ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfqW-0002BX-Bu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqfqL-0001jb-T4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqfqL-0004qJ-3e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:39:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqfqK-0004qA-UN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:39:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so51239837wrt.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1O6dLeeHQYUqm93JMYA7YAeCKp/NGxYm6dNvskwvhWU=;
 b=rIrfwHtWaCTbrpHTuu4g2ljpCdObn7M8ccl7A8cE4olvJk8pxA1VTMy/LbAzO2RwBE
 w6VR4hq1Y3xL/p3DNNvP9PpwvrOfKj2yRTbKNZU4UcSnqLRmHMPjKSMahYv8KP91vG+u
 7wmVNZTLTJhJVgWgLRz/45RASkf2rgiLxoFTu7GOAmTmNgDWaOYDsE4AGfoMDXGlO0ol
 u+cSD75DFijqsbXRhJCLiMZArwRticsVSbYPRDk4jrw83FEGiUJV4XtL7I1dAvAbsFYR
 36lnPsUDiQtArbt2r4lPfIMjcxepbGNEVGnXUpC5Gdx+VRDp+nWz7FiEVF52rv/JyXNm
 BaEA==
X-Gm-Message-State: APjAAAWvjlb/WnWou8jigRcC7eUAGUG0EuLCur6Rwebdm1H5H5MlK5BA
 +a4WYprlslZ20xIGqJ1EUPPTEA==
X-Google-Smtp-Source: APXvYqwlRI7r7csoVL6rYAiQ9VVohuaE4MtQvrihLOYnZALtnRVH5bsaqgLLuupIaRqz73E1ke28gQ==
X-Received: by 2002:adf:e705:: with SMTP id c5mr47078265wrm.270.1564069183957; 
 Thu, 25 Jul 2019 08:39:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id w7sm58670004wrn.11.2019.07.25.08.39.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 08:39:42 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com> <87muh2mazh.fsf@redhat.com>
 <20190725104721-mutt-send-email-mst@kernel.org>
 <20190725110114-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cdc6e86c-ce05-fd48-c8a3-0e6cec894d4e@redhat.com>
Date: Thu, 25 Jul 2019 17:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725110114-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
 Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 17:01, Michael S. Tsirkin wrote:
>> It would be educational to try to enable ACPI core but disable all
>> optional features.

A lot of them are select'ed so it's not easy.

> Trying with ACPI_REDUCED_HARDWARE_ONLY would also be educational.

That's what the NEMU guys experimented with.  It's not supported by our
DSDT since it uses ACPI GPE, and the reduction in code size is small
(about 15000 lines of code in ACPICA, perhaps 100k if you're lucky?).

Paolo

