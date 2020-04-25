Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F0C55186
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264EA20714
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NobU/7s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264EA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSIU8-00007U-5O
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSITH-0007Ji-Fx
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSITG-0006Fp-8g
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:55:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSITF-0006CU-L1
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587812140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfYKOQB4N8lkU1r8Bt/203i2dcSBDjyhT2qENujEKOQ=;
 b=NobU/7s0YrhHlDDJ9fwtAt2N0E9cVhbChz5MNzsysVENvmSpAaLxLU/N+ToGKP+0EuWIly
 N6L0dobQydfp/S7aEMkwWruFCUbYBtls7gLTDT04+elu4tQTVv5ekXkLaNifKqEFlyFptA
 o/h/weha49uj7NlH/P2imk+QkrW13Sc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-AP2OW4T_M-Gl_7EAT5og3g-1; Sat, 25 Apr 2020 06:55:36 -0400
X-MC-Unique: AP2OW4T_M-Gl_7EAT5og3g-1
Received: by mail-wr1-f69.google.com with SMTP id x15so6567156wrn.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 03:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UkNkwH1h9FNQTUqw8hiaZiNU6J0NADal0uC+ptQ926M=;
 b=YEgXgEVT5XXeIQKe05atRB8oWRSOtNv7uXxIcnR15mp8pZ6VzZ/T+4PfkMcuCZzv6W
 bl0FPtw/nJX89dNBmfplQFHJ1VUAUcaEnNamk6vV6wHSEzO+DsUJ4vcrmEe2pbvFXWGT
 XsaEtmlzoPhKenosFP8WhcqRjdsK6ab9GanJtna4o7cizsgpduhUZs1rqd2/CQ1ANa0n
 7TXd831FIG0aWvMRxY53cPITsd08TTfq1S7eOyazhXrngsW1xQIl31J7AZZKaiOcIY9a
 CgcymlZqjsXxs3cPCY5+D4IASLmJYtXpo48aLJKCgDMOwYpAsgp+mJMSrz3Zsz8ej86N
 GEaQ==
X-Gm-Message-State: AGi0PuYoNtHkxEXrxXDR+6JpqcwxjRvC5qrXbUknk96XfHMX8hfmFJGt
 /ZMbOz2BoB5yykk0FdiGxLua1j2Db4Ji/+uK+MLWi/Ja5g6ZYWesNSYI5G59f4qAUW7ZUUyb/jP
 rqUfHkToZYKzUqSw=
X-Received: by 2002:a5d:408d:: with SMTP id o13mr17747261wrp.249.1587812135775; 
 Sat, 25 Apr 2020 03:55:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKN385hJz+PY8CdCgS7+RkbP1imzLRunxAViQ0px9eGdZHOkQ6cB7eddz0X05OG0jc5X2Lm9w==
X-Received: by 2002:a5d:408d:: with SMTP id o13mr17747245wrp.249.1587812135578; 
 Sat, 25 Apr 2020 03:55:35 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m15sm6617897wmc.35.2020.04.25.03.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 03:55:35 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, alex.williamson@redhat.com
References: <20200417074437.28526-1-yan.y.zhao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f96581ca-055e-ecc6-4a44-6bd26396bfc0@redhat.com>
Date: Sat, 25 Apr 2020 12:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417074437.28526-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 06:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: xin.zeng@intel.com, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/04/20 09:44, Yan Zhao wrote:
> for ram device regions, drop guest writes if the regions is read-only.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>  memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/memory.c b/memory.c
> index 601b749906..9576dd6807 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,7 @@
>  #include "sysemu/accel.h"
>  #include "hw/boards.h"
>  #include "migration/vmstate.h"
> +#include "qemu/log.h"
> =20
>  //#define DEBUG_UNASSIGNED
> =20
> @@ -1313,6 +1314,12 @@ static void memory_region_ram_device_write(void *o=
paque, hwaddr addr,
>      MemoryRegion *mr =3D opaque;
> =20
>      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data=
, size);
> +    if (mr->readonly) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read only ram device region 0x%"
> +                       HWADDR_PRIx" size %u\n", addr, size);
> +        return;
> +    }

As mentioned in the review of v1, memory_region_ram_device_write should
be changed to a .write_with_attrs operation, so that it can return
MEMTX_ERROR.

Otherwise this looks good.

Paolo


