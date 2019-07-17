Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A795C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64CA21743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64CA21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngsP-0003U0-T6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hngsF-000362-6u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hngsE-0001K9-92
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:09:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hngsE-0001JD-1l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:09:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so24140100wrr.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 03:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sBelC1IJe9XNbdmsMt1UhNhhysTd8hW3FZZ//QE04vk=;
 b=anWSxPb4CJ8z22tZVfo6gUSDYrBf6i4mKM0NdojJwNEwtOLzOYnnsZYxlloED7XHXl
 +7FmEHmfmxAo4c3qhbDg9ZN8RqffllXlnwlbbKdCBY2VaMXHm7jLnhbCV59C4RS4RRc6
 m02bMTqPmFy5wjf0jfD5cn+vGK8ZKEkgsPAen11IpCW142jUsLmGiCX8CG198w8ZBmWR
 9GFNdcQlGfKgK1ocKbifWV4uQa/UCEXvNCS6dvTWjDBMfP0qVBW4aANs2Kj7HJjx/8D4
 jqIU4PmC6b9eKZwm8JfZbXnN5g2dtqneG91zYQmMroA5+0rYjz80R2miXs9P8pPuPywt
 yhuA==
X-Gm-Message-State: APjAAAWBIaWzItfmYSVJbXOrcNPFldrJIwdC4HfyTYCjtgxklsv+pms9
 49m3yRkfblgTiYwTYmOqbHXEoA==
X-Google-Smtp-Source: APXvYqzODTh9QVDY9RZ8Inn4uVRfg/JZ8DwxM8sDGv1VPX3WCaFrP+2zFaU0K8SZzwP4ChOKV9oH0A==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr42752434wrm.24.1563358160846; 
 Wed, 17 Jul 2019 03:09:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id w24sm19477116wmc.30.2019.07.17.03.09.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 03:09:20 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <521daf39-6984-f20d-9436-e79f23a071ff@redhat.com>
Date: Wed, 17 Jul 2019 12:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 0/4] Invert Endian bit in SPARCv9 MMU TTE
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
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 07:57, tony.nguyen@bt.com wrote:
> This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.
> 
> It is an attempt of the instructions outlined by Richard Henderson to Mark
> Cave-Ayland.
> 
> Tested with OpenBSD on sun4u. Solaris 10 is my actual goal, but unfortunately a
> separate keyboard issue remains in the way.

It's very good, I'm just a bit worried that the meaning of MemOp is
slightly different between memory API and TCG.  I've replied to patch 2
with the details.

Paolo

