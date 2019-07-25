Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AF5C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDB7229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDB7229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfmE-0007LY-38
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqflp-0006D0-Md
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqflo-0003NX-MM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:35:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqflo-0003N6-FO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:35:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so51293708wrm.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CWd5IHzsND9B5O27c3cZffVz2+l0mVi333xEt87aVGg=;
 b=lbfjQHpPbwT006ZFHPiIJ72XfBMcffEtdJ0KBoa0Z9VlfKR+mlLPFt+wJQX3iEpIyD
 sl7/+r4NYebVGKa1vzY+qbZ9n2yeASuAiJNuAd94XrC2yLgkDMO8uOCBEdcAllEQwSA1
 HRZ2PlVmOP/nQrWqXWVDABkcshZyibL6shNUBrXiYAYUtgWh/nH/Fo2lKJKGKllyVm+z
 EC6S96UEaxpXFJcZw8n2CEFh9hc3FyjgfoSV+5YUkgnDIYsS9OiPF9/VqbtkGpWPVXrc
 xfT/4tGQYziEWQOomcDXZWRxZODC6KNvkCbWFO+nOGBb4cXO3+y4cTbVmaTjyc2QcPcB
 3DYQ==
X-Gm-Message-State: APjAAAWs0oI7ZAxP3Pfk76GMXxmmMzvJTrD6oNbEAcKwtiM8O2GQ9pLp
 GPuAZZq2nVAqJJd2nnbShKxKBQ==
X-Google-Smtp-Source: APXvYqxslSrJKN+VrkUH65jndCOptlMZZUGVju4w8YYpC/22dgelBQzchrkLUG16f9uPdef7oPv+mg==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr98857468wrw.304.1564068903277; 
 Thu, 25 Jul 2019 08:35:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id s188sm40667406wmf.40.2019.07.25.08.35.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 08:35:02 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com> <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
 <20190725104331-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6d318abf-4afa-a1dc-a4e8-3a2d0a6de297@redhat.com>
Date: Thu, 25 Jul 2019 17:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725104331-mutt-send-email-mst@kernel.org>
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>, "Montes,
 Julio" <julio.montes@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 16:46, Michael S. Tsirkin wrote:
> Actually, I think I have a better idea.
> At the moment we just get an exit on these reads and return all-ones.
> Yes, in theory there could be a UR bit set in a bunch of
> registers but in practice no one cares about these,
> and I don't think we implement them.
> So how about mapping a single page, read-only, and filling it
> with all-ones?

Yes, that's nice indeed. :)  But it does have some cost, in terms of
either number of VMAs or QEMU RSS since the MMCONFIG area is large.

What breaks if we return all zeroes?  Zero is not a valid vendor ID.

Paolo

