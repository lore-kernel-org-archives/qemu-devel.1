Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7CEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3765C212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765C212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDZX-0007xP-B9
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hZCjT-0005zE-Mm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hZCjR-0002Zr-2U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:08:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hZCjM-0002KK-Tu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:08:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id r18so1718968wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xAN5x32itYHsExlt58dM3Q1jhGvK/Oi1PGkIm5kb9No=;
 b=dN9uAFxGld9LJmMH9HX/i5y0YvRBBUc3j13YTcr1IlMwYdxRuzZg0KgjYlOh3J1EAx
 kfI7ahmersfbjA6/c4RL6zxBKti8ifCOYzBKR+IqEhaF7IPcFLjoY26c69kiVOh8Ig71
 iZAjcbi52fiuwWpKIEluCDPlKhkdk9GMC2BTaY2l+Sf/0LklW00GtxXnhdXDfoRNo6bG
 slecCiT0CF10cJfwcnDePj32P20CwgxltDgP22NzbTIj6jSJuK24/ljGbK0GlFyX+Fgj
 Ib6+MLfrd4K/YmCvpZcv+TgVOSOY6Ck0BbbGO4OpSGIIqjjEnNFwgEPy1/LWD5/NlDPg
 J3Qg==
X-Gm-Message-State: APjAAAVzZd0kktHGifGTPMjE4yKlkCnXBEvCBq57zDnmALNnZxWSk80F
 n2Pb7UZapO/jsZ1WmznBFVFYd06WCP4=
X-Google-Smtp-Source: APXvYqxblyXgRWCxrbgpUrfJJ6Y8Ok05cDZrvjJ98Dr3JtPpYOgZiPyR+I+o0roU6PY3S4P05b68Aw==
X-Received: by 2002:adf:b689:: with SMTP id j9mr12008058wre.76.1559905698818; 
 Fri, 07 Jun 2019 04:08:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775?
 ([2001:b07:6468:f312:d43d:6da3:9364:a775])
 by smtp.gmail.com with ESMTPSA id f21sm1720346wmb.2.2019.06.07.04.08.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 04:08:18 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org
References: <20190417195355.16123-1-mlevitsk@redhat.com>
 <20190417195355.16123-2-mlevitsk@redhat.com>
 <d1ab2f6e-a5b1-466b-7ad9-df47b8739579@redhat.com>
 <7b9baac9a0b652105cebb681e9759cb4e9d3877b.camel@redhat.com>
 <601a2a78-0ddb-ccc9-f3c2-46aa16e18629@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfd777d8-1241-7361-193d-02442a0d79ab@redhat.com>
Date: Fri, 7 Jun 2019 13:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <601a2a78-0ddb-ccc9-f3c2-46aa16e18629@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/5] block/nvme: don't flip
 CQ phase bits
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/19 23:23, John Snow wrote:
> So: This looks right; does this fix a bug that can be observed? Do we
> have any regression tests for block/NVMe?

I don't think it fixes a bug; by the time the CQ entry is picked up by
QEMU, the device is not supposed to touch it anymore.

However, the idea behind the phase bits is that you can decide whether
the driver has placed a completion in the queue.  When we get here, we have

	le16_to_cpu(c->status) & 0x1) == !q->cq_phase

On the next pass through the ring buffer q->cq_phase will be flipped,
and thus when we see this element we'll get

	le16_to_cpu(c->status) & 0x1) == q->cq_phase

and not process it.  Since block/nvme.c flips the bit, this mechanism
does not work and the loop termination relies on the other part of the
condition, "if (!c->cid) break;".

So the patch is correct, but it would also be nice to also either remove
phase handling altogether, or check that the phase handling works
properly and drop the !c->cid test.

Paolo

