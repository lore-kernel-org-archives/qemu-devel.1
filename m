Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2430FC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFB821743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFB821743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngrb-0002cU-2B
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hngrQ-0002DZ-Mh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hngrK-0000j5-QU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:08:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hngrI-0000hw-MJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:08:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so21524337wmj.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 03:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4pb89/+4zq7H/Ld2QmNntFZ9nQJLHwhJfPb5IeUQS0w=;
 b=BROb5nhcATQR1D5Ceru5Tjn7cf4l1KhfwDjwUO5QHPPPGMysh1xCxlY9JDHVDZnveE
 Ngfz6FYFlLaERNZEUcxh0z/nD5+oDTcWpuAuj79ReESJcovmUhBtB8lYtXTnt1ZW+fKZ
 NilZjtV8HL6EFhgna8yDs8/FnWfAsyoNFlCK6MtFwxVh+9aycgC7FNLUPDaxte+MPdbh
 HkYc5Nf89qNzDmTAQvKz0qst4gVUsnwXHK0vTzYvytaGbOZ5/A4VXnlFKEjG3p+osOw9
 O0wJbLwhcz/kZ8JX2vjNpeVtkFVjhF5uhgFpzyM3ZnTREVBe5q9xD3Zs0OxVHNRCpg08
 nTfA==
X-Gm-Message-State: APjAAAVRNJJZHDmmT1FyYZlbZhllO7SP9+OCmdFSOE8aB7s/vADnkSpj
 7APpHVIKOWmgIN4vsjD9NkPcHg==
X-Google-Smtp-Source: APXvYqzXHINw1gq/MzX4vSImIYWqB0W9SzTPsjKo3RZRhoTXNixm4H+fzrCDiHEPghNmZZSO/y02qw==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr35142447wmj.20.1563358103446; 
 Wed, 17 Jul 2019 03:08:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id u1sm22474989wml.14.2019.07.17.03.08.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 03:08:22 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
 <1563343596429.3033@bt.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8391cc14-3fc3-789e-b5a6-91b707a3a5a8@redhat.com>
Date: Wed, 17 Jul 2019 12:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563343596429.3033@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 2/4] memory: Single byte swap along the I/O
 path
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

On 17/07/19 08:06, tony.nguyen@bt.com wrote:
> +
> +static inline MemOp MEMOP(unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        return MO_8;
> +    case 2:
> +        return MO_16;
> +    case 4:
> +        return MO_32;
> +    case 8:
> +        return MO_64;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

FWIW, this is just "ctz(size)".

My main concern is that MO_BE/MO_LE/MO_TE do not really apply to the 
memory.c paths.  MO_BSWAP is never passed into the MemOp, even if target 
endianness != host endianness.

Therefore, you could return MO_TE | MO_{8,16,32,64} from this function, 
and change memory_region_endianness_inverted to test 
HOST_WORDS_BIGENDIAN instead of TARGET_WORDS_BIGENDIAN.  Then the two
MO_BSWAPs (one from MO_TE, one from adjust_endianness because
memory_region_endianness_inverted returns true) cancel out if the
memory region's endianness is the same as the host's but different
from the target's.

Some care is needed in virtio_address_space_write and zpci_write_bar.  I 
think the latter is okay, while the former could do something like this:

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ce928f2429..61885f020c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -541,16 +541,16 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         val = pci_get_byte(buf);
         break;
     case 2:
-        val = cpu_to_le16(pci_get_word(buf));
+        val = pci_get_word(buf);
         break;
     case 4:
-        val = cpu_to_le32(pci_get_long(buf));
+        val = pci_get_long(buf);
         break;
     default:
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIED);
+    memory_region_dispatch_write(mr, addr, val, size_memop(len) & ~MO_BSWAP, MEMTXATTRS_UNSPECIFIED);
 }
 
 static void


Paolo

