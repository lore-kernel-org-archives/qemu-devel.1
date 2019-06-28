Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3533A205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3533A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrt7-0005Oh-GK
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgqpJ-00085s-8e
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgqp9-00010c-Rk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:21:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgqp9-0000cg-IV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:21:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so8961476wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 06:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OtOpn/4idTysfu5MYEQUK4bxWnONBeIPIldfMjNmhBI=;
 b=elhPYXrQuhhw30/4wPfTo6nMpBMdk+JrTmtcJGg8D40cWjoyGzw74rCur0Q5MNrxLX
 U2hU51T4xQNVj0yRIpPmonCmtloNwFj5xbp2faxC6rZPQjXlM4DEexhrXQODx9ikfXJv
 5OL2rUfN53ym6/U8XIpV1fg238LUJg0dyYRhtPxQid61oRdYwMqL7+yx/I+1WhxBdIf+
 SHZ2rnvIxvsurIAuJiAinFfSV0UlZn9sir1AJq22ZgR5TPHn1+sWbv6xP+CUe/9yEMNZ
 u5tuWAEIq2h8Ohz0MSx9mrP8e4zwPOdPvZWLUcF816VRTBvRhcSYnDbjhGiRR/Phkb81
 Pf7g==
X-Gm-Message-State: APjAAAW6C1PPfHsERgKvpLFHR1OVpYkU61OlLxLK43JNfAVocx5NQa4D
 NQ+8kOXPmQF4aC79Go7fGuPkOTFjOKM=
X-Google-Smtp-Source: APXvYqxGcIu+B/7QDTBVo2M1nlow7xrIAp/FZXLg6s5pDLurbKn7vEjpz8mAbbGWFbchVOfyzU1A5g==
X-Received: by 2002:a05:600c:389:: with SMTP id
 w9mr6910918wmd.139.1561728107658; 
 Fri, 28 Jun 2019 06:21:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d4d:4830:bcdf:9bf9?
 ([2001:b07:6468:f312:5d4d:4830:bcdf:9bf9])
 by smtp.gmail.com with ESMTPSA id k125sm2470032wmf.41.2019.06.28.06.21.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 06:21:46 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com
References: <20190628115349.60293-1-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <283ec3e9-92e9-e43b-66c9-419b302d90ca@redhat.com>
Date: Fri, 28 Jun 2019 15:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628115349.60293-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduce the microvm machine type
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/19 13:53, Sergio Lopez wrote:
> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>  -kernel vmlinux -append "console=ttyS0 root=/dev/vda" \
>  -nodefaults -no-user-config \
>  -drive id=test,file=test.img,format=raw,if=none \
>  -device virtio-blk-device,drive=test \
>  -netdev tap,id=tap0,script=no,downscript=no \
>  -device virtio-net-device,netdev=tap0 \
>  -serial stdio

I think the "non-legacy" mode can be obtained from the "legacy" one just
with -nodefaults (which all sane management should be using anyway), so
legacy=on can actually be the default. :)

I think this is interesting.  I'd love to have it optionally provide a
device tree as well.  It's not very common on x86 and most distro
kernels don't support device tree, but it would provide a more
out-of-the-box experience and it may even be a drop-in replacement for
q35 or pc as far as Kata is concerned.

Paolo

