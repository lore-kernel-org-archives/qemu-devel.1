Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E9C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A782146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCX1WO/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A782146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqun-0004iR-9j
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDq9y-0001tv-4m
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDq9w-0008Ly-LG
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDq9w-0008LZ-AN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id m16so5169830oic.5
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kau7tqDv4N5BfV3Vw5Rek2SevsQVcXfTdIXf3HFT2yo=;
 b=cCX1WO/bNqbsVLei5AA6tys+J9PQMz1GCTn1ofd38X9yeB/fkI6TGDTPGAovh1gxGJ
 zIGgaNSH3KW4LZLhHdSL7SW3IkKPLQQsZ9cI6spH+4/CRcYEGOykEIJT8bShZ+GDlW4o
 b0kEQDvOms3LGJDEgJHj+O8DyaMzVBc1S9zGk9ZPfwSYtL9s50mUBfR4VRQKmM4DFHST
 vFgJYE7O3m4pTQWNgqexAgCt6S4epYt3IsrczSUcQ8ZKZKa+sb4j+dTClfYstJyKBJSx
 CtJw7FsCAuzm+ipAFreRZqtIRDMxlbBHuiZe58JntnoPNM+gS3QfEkbKM19+iDlMj/P1
 M3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kau7tqDv4N5BfV3Vw5Rek2SevsQVcXfTdIXf3HFT2yo=;
 b=eY2nZZLqDAQSFd+9sWl62Fbilx5VFWRSzWiszoBIHpM5T2zPrr9c5C75L4seXzuloW
 d54rodR3HspsAvoKNWwM3tAJZNIjheflGuYF7hbwfdjuv1h9K5dcQ5o1+4tRL/jZDL26
 NehaNGsK52dNBZYLWdLskjVPYCajXh+8Oa+p1qZ6XK/JjxIl60RDLLDhSTYedGqeUTNO
 PvLNBTG+Fsz9Bw/kbSuUKQxLGCvHSQ9zqsGf9+QuvaXC4L73qZHde6SJePGlS1kbN8HZ
 ZNcGP9z35eN2Me0m0V9134O45qq1mLncypB0tKzII7cmIyTe/RjF+se5N8JQ1TdM9V+z
 x2KQ==
X-Gm-Message-State: APjAAAUkpxey08yDly8/bkzZWBQ85gVcXyFM1kByTDpYv9D/EFSv/U95
 mUnXD6LDGr5zgcR91vn7DJgOsiK93PwYMJWsFXUIaw==
X-Google-Smtp-Source: APXvYqzXs1mVapIpMEL6Y2Ngi/4ZduF5Yd6EaPkjfeAoYTmuJS+fshgQqDDsgxIcpLAb2p6CPEx1T1EC892RovR100c=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr7264630oih.170.1569590383304; 
 Fri, 27 Sep 2019 06:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-5-zhengxiang9@huawei.com>
In-Reply-To: <20190906083152.25716-5-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 14:19:32 +0100
Message-ID: <CAFEAcA_o6NkOGptWFOoVt4pUgHU+dNyWQ9h_VfNweR17CtHSnw@mail.gmail.com>
Subject: Re: [Qemu-arm] [PATCH v18 4/6] KVM: Move hwpoison page related
 functions into include/sysemu/kvm_int.h
To: Xiang Zheng <zhengxiang9@huawei.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> kvm_hwpoison_page_add() and kvm_unpoison_all() will both be used by X86
> and ARM platforms, so moving them into "include/sysemu/kvm_int.h" to
> avoid duplicate code.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  accel/kvm/kvm-all.c      | 33 +++++++++++++++++++++++++++++++++
>  include/sysemu/kvm_int.h | 23 +++++++++++++++++++++++
>  target/arm/kvm.c         |  3 +++
>  target/i386/kvm.c        | 34 ----------------------------------
>  4 files changed, 59 insertions(+), 34 deletions(-)

>  static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
>  {
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 72b2d1b3ae..3ad49f9a28 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -41,4 +41,27 @@ typedef struct KVMMemoryListener {
>  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>                                    AddressSpace *as, int as_id);
>
> +/**
> + * kvm_hwpoison_page_add:
> + *
> + * Parameters:
> + *  @ram_addr: the address in the RAM for the poisoned page
> + *
> + * Add a poisoned page to the list
> + *
> + * Return: None.
> + */
> +void kvm_hwpoison_page_add(ram_addr_t ram_addr);
> +
> +/**
> + * kvm_unpoison_all:
> + *
> + * Parameters:
> + *  @param: some data may be passed to this function
> + *
> + * Free and remove all the poisoned pages in the list
> + *
> + * Return: None.
> + */
> +void kvm_unpoison_all(void *param);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b2eaa50b8d..3a110be7b8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -20,6 +20,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/kvm_int.h"
> +#include "sysemu/reset.h"
>  #include "kvm_arm.h"
>  #include "cpu.h"
>  #include "trace.h"
> @@ -195,6 +196,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>
>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>
> +    qemu_register_reset(kvm_unpoison_all, NULL);
> +

Rather than registering the same reset handler in
all the architectures, we could register it in the
generic kvm_init() function. (For architectures that
don't use the poison-list functionality the reset handler
will harmlessly do nothing, because there will be nothing
in the list.)

This would allow you to not have to make the
kvm_unpoison_all() function global -- it can be static
in accel/tcg/kvm-all.c.

>      return 0;
>  }

thanks
-- PMM

