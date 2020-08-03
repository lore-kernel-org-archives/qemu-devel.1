Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6999C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5108622B40
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6oM0Huw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5108622B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fID-0005pf-2C
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2fH5-0004tK-Ub
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:33:28 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2fH1-0004WE-MQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:33:27 -0400
Received: by mail-oi1-x232.google.com with SMTP id e6so13894894oii.4
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tOj98KWxZfo7k/msteoXOzG655QSkI9RWTBbZ2s3YRY=;
 b=y6oM0HuwhNOMHv3CswCjVXigw95CYKCpxWHCggL8OoQcJxkeRNg5xNgVFZVuTHJtBY
 VKkSC2Ccj0FUCS6t6LXUsSCAx1vUsWEglUkfIyKR4Ga7GWYIJLf99ebsMsEH51vWT4Ho
 93jG8A0FX96zCtfWEG5lE90T5hkdeVnuuMn3Gfy0RewfCgOF64kg5QMkVjZjCde5S+0g
 /08gtE0Pc5ovCteqftn3ITAT5KAc9aY3NYcgtW5dw6AKFcj2hd/GSDJjrvskWQWPijY8
 SmPTw4J0HNsDeydm1xgIt9NSu+OuG8LILxr06BEKqRzHSjpKA9Xg7rMiL9uxzM3K+Dll
 KICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tOj98KWxZfo7k/msteoXOzG655QSkI9RWTBbZ2s3YRY=;
 b=o8wejB9+WN7MQ5UFo5rQvtt5UX2B1zaxGLjLhYTe6HGRujIrxOSyKAj6/uavtCOuHr
 DYXEAA5uFM//NqyK3o2NI01M5hVu38VNoHvKB1eNYYuH3GxnVkDpe4VT3JhSfepj4FLH
 pFtHqhuwCow5ClSfkrUhUjzb7Sp1Rd2WIPRwSBZ5g4FVvCrOxGECy/hczP3uAtwSyhIn
 /NF/NqEp7fKqCYFW4zNIuFG2cI3LUZhObhrhKWwBQeGFmzJBWnwJnEx6+bpDKyxdZ+h8
 9hVe4rdGB3vK5LIQ+ESPof9HYLe4zLZdlQaGkC7TBTh7A5y0BtChi472pbMh8jzZlTCq
 DXPw==
X-Gm-Message-State: AOAM532tdU7zIgsq/0XIrKmyb1I/hBjVqeLGTiFLTdkq61x07Vot2mih
 gZg7jL9+TX/il1kPalzjFOu4MGTdJ2roU06f6SxtZw==
X-Google-Smtp-Source: ABdhPJykw6QlTCz5UZlKQ6UvLdnZmhQqKuAQH/eDVsm1AFm/IR10na8Eavap0iKbcegmHSN7XTnjydq+nvN4QSaJRgQ=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr553874oib.146.1596479601455; 
 Mon, 03 Aug 2020 11:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200803165251.907213-1-anthony.perard@citrix.com>
In-Reply-To: <20200803165251.907213-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 19:33:10 +0100
Message-ID: <CAFEAcA-L5Qgoq5xN426DrFQG2W2CDQ+e=0Lc6hzmUxjJDrAueg@mail.gmail.com>
Subject: Re: [PULL 0/1] xen queue 2020-08-03
To: Anthony PERARD <anthony.perard@citrix.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Aug 2020 at 17:53, Anthony PERARD <anthony.perard@citrix.com> wro=
te:
> ----------------------------------------------------------------
> xen patches
>
> bug fix
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       accel/xen: Fix xen_enabled() behavior on target-agnostic objects

This fails to compile, all hosts :-(

  LINK    avr-softmmu/qemu-system-avr
../migration/savevm.o: In function `qemu_loadvm_section_start_full':
/home/petmay01/linaro/qemu-for-merges/migration/savevm.c:2320:
undefined reference to `xen_enabled'
collect2: error: ld returned 1 exit status
[ditto other softmmu link attempts]

Similar but different on OSX:

  LINK    aarch64-softmmu/qemu-system-aarch64
Undefined symbols for architecture x86_64:
  "_xen_enabled", referenced from:
      _msix_is_masked in msix.o
      _msix_write_config in msix.o
      _msix_handle_mask_update in msix.o
      _msix_init in msix.o
      _msix_notify in msix.o
      _msix_reset in msix.o
      _msix_set_vector_notifiers in msix.o
      ...
ld: symbol(s) not found for architecture x86_64

Fails in all the BSD VM builds as well, so I don't think this
is related to incremental vs from-clean builds.

I think the failure here is only on builds where
CONFIG_XEN is not set by configure (which for my merge
build setup appears to be all of them, I think).
In that case when we build a target-agnostic object
it gets an external reference to the xen_enabled()
function, but because Xen is disabled we don't compile
accel/xen/ and so there is no actual implementation of
the function in the link.

This doesn't happen for KVM because there the
CONFIG_KVM_IS_POSSIBLE version of kvm_enabled()
is a #define:
#define kvm_enabled()           (kvm_allowed)
and we provide both the "real" version of the
'bool kvm_allowed' in accel/kvm/kvm-all.c and also
the stub version in accel/stubs/kvm-stub.c which will
be used in configurations thta don't build accel/kvm.

I think then that the fix for this build failure is to
either:
 (1) add a stub version of xen_allowed() to accel/stubs/xen-stub.c
     (which would always return false)

 (2) follow KVM more closely, and have xen_allowed() be
     a #define to (xen_allowed), with a (non-static)
     bool xen_allowed in accel/xen/xen-all.c and another
     one in accel/stubs/xen-stub.c

thanks
-- PMM

