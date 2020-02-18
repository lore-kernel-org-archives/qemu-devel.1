Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F50C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB232173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crkLfZKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB232173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42pO-0008VT-20
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j42nk-0006Zv-M1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j42nj-0000WT-GC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:36 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j42ni-0000W5-QE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:20:34 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so20018760oie.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e33XSujeVPSmM69bxmP6PPG5hbSgevpcKoYxIW+BlSA=;
 b=crkLfZKYA8VWOgld1aUF2vc2YhylK3y7pcJIwzBAtU/nSt6lKyRXUL3ZmjuZo58acw
 SdBiXb2k8+mBiyRkFfKjyIKnzXeMPyZ+R3Wr9LT27l2G5HLPQdiMCs6Fh7RphEWx9bHV
 To9mpwdHJq+LPEvmHATmPo75AddPV5zZyOqxmd91TZglfCaJNdHmR58y1S58Ubqv5fTt
 Oo9LlXjUPQq7kvb+VVfyYlWNKD73P7mI1vb4FPrEju10yYgy3l7M58L2FvTl+jjW+p90
 q2luvDU7oFvG1JnwJ4k5mj+zDKiNqbtVUODJMsa721oKkzLtNndHQKfBPfKXxXRxazdb
 HqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e33XSujeVPSmM69bxmP6PPG5hbSgevpcKoYxIW+BlSA=;
 b=riQxmCjlObex7w0AeoVufhRVY3nVNmlkDm6SfCmjJuxf35zU7fir6f1d35zck9SeBG
 OTKiekuBYA3GdcIrI1LtXgivD+dpFTSriEqUd1zjsPLToyeJHZNCmUfgllyB6LzOkS7u
 OJ6VU2HGYqJxDZ3Vda9jTNBdN60/KHKNdG7kavSxuV/y5GJsDWxkkebKAk0ekWBEEBVV
 xN8d+hf7pQo1CEdMY1IsgLR2ZcJ2qqtDaj61eSFjafukGEOxCD9aYA3k0s+HQLjeO9Xi
 LS39Qk8j9Lh/HhEaazVGb4ulvW49AtVncsXKXkV8V/zzYFytFxarO5Gx3YXWL11GrjFh
 pxvQ==
X-Gm-Message-State: APjAAAVv1QmLWXQUaEFxJIENwV/1LTAJbEkZo+ZSR0BgS0kd3RROd6d0
 bpyj80pamGXWWBa/pUzVjOvlMabIXb/MhX+5U1GVOA==
X-Google-Smtp-Source: APXvYqySln2sw77s+nOwW5Mn2mm4KJv9a68J7L+JY+6B5m8LajUt/A38P9k+plTA3F+gyNA6iILNbyg9kCvxZv+sF8g=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1148810oic.48.1582032033516; 
 Tue, 18 Feb 2020 05:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20200218112457.22712-1-peter.maydell@linaro.org>
 <fc70075c-0098-632e-7d60-4534202bf2f5@redhat.com>
In-Reply-To: <fc70075c-0098-632e-7d60-4534202bf2f5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 13:20:22 +0000
Message-ID: <CAFEAcA8wNVFu1ZcchFbRxkmvpKfFg3WF7p=5vxs0qevWPSMV_g@mail.gmail.com>
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 13:14, Laurent Vivier <lvivier@redhat.com> wrote:
> There is one in target/i386/hvf/vmx.h: macvm_set_cr0() you didn't change.

It turns out that "spatch --dir ." only looks at .c files,
and you need to add --include-headers to get it to look at
.h files too. The only extra change is this one:

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index eb8894cd589..c245dc6d5bb 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -125,10 +125,9 @@ static inline void macvm_set_cr0(hv_vcpuid_t
vcpu, uint64_t cr0)

     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
-        address_space_rw(&address_space_memory,
-                         rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
-                         MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)pdpte, 32, 0);
+        address_space_read(&address_space_memory,
+                           rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
+                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)pdpte, 32);
         /* Only set PDPTE when appropriate. */
         for (i = 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);

which I propose to squash in, together with the fixes to use
the right filename in the commit message and comment.

thanks
-- PMM

