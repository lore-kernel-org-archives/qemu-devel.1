Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E9C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D372081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D372081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7gxr-0000W2-3o
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7gwN-0008T0-L9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7gwK-0007Ql-Iy
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7gwK-0007QK-Bt
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:16:16 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AF698665A
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 14:16:14 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id h6so6583303wrh.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E6Ur5CKhPkRstYRaUUfSmBSOW2LZA54IcN06DaFxPL4=;
 b=uMopvA7OFCfqNVdKEx7vLoA7+KWHdteoK8FBqRFp6Lw6EsJBzj0f0gXr2c/ZCglNUI
 SpyBo8afJXlFJIbMQ9ou2VhHqRqWW/Bx+9Wo38X0LeCJuPhlpSKzN0oDxB6nWrOKvOfp
 2serNzKkjar3BWViSAbxM0gTqZWUJKC+DZOeMP0myXkMUzAaf4Gud8joYQHxubKQae3X
 BVwIvF7DX1UGNptjdVQblAQBcsJ40TljyNvyqld3kAP4/7R3SCd3s4uwjp1rPw+tuac9
 0GnRH//qq9AVRouyQ8YqVg3RG+82q0G87KxzGNikW416uSRXUs4iB9LJw8dkqDaqNljr
 sHXw==
X-Gm-Message-State: APjAAAWhzfR8iWciByx/YHBFd1pegN8FmErXV2YsIdEw2PwJ6/PJpvuc
 2EsEpZNQGDyf+0Hppq+7GuqtThNoXo5FxbJoyITDQRx/IiQYmxW7p7lrX5rMFx+1qoS6iT4A3DB
 eVtrlpSPh+HdAFso=
X-Received: by 2002:adf:db0f:: with SMTP id s15mr7076815wri.120.1568124973036; 
 Tue, 10 Sep 2019 07:16:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzp7g5C9tf+UnBAlUGxqnvKpck1x2ye+08atzl79/EBAt43WAu2aDE959o3cWLwJTg8qDJM0Q==
X-Received: by 2002:adf:db0f:: with SMTP id s15mr7076783wri.120.1568124972749; 
 Tue, 10 Sep 2019 07:16:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6?
 ([2001:b07:6468:f312:102b:3795:6714:7df6])
 by smtp.gmail.com with ESMTPSA id x5sm25751503wrg.69.2019.09.10.07.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2019 07:16:12 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190910124828.39794-1-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <37258167-33f8-6b42-e290-ba4c9c8e6fa4@redhat.com>
Date: Tue, 10 Sep 2019 16:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910124828.39794-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] elf-ops.h: fix int overflow in
 load_elf()
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/19 14:48, Stefano Garzarella wrote:
> This patch fixes a possible integer overflow when we calculate
> the total size of ELF segments loaded.
>=20
> Reported-by: Coverity (CID 1405299)
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
>  - not use error_report in load_elf() [Peter]
>  - return ELF_LOAD_TOO_BIG
>  - add Alex's R-b
> ---
>  include/hw/elf_ops.h | 5 +++++
>  include/hw/loader.h  | 1 +
>  hw/core/loader.c     | 2 ++
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 1496d7e753..e07d276df7 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -485,6 +485,11 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
>                  }
>              }
> =20
> +            if (mem_size > INT_MAX - total_size) {
> +                ret =3D ELF_LOAD_TOO_BIG;
> +                goto fail;
> +            }
> +
>              /* address_offset is hack for kernel images that are
>                 linked at the wrong physical address.  */
>              if (translate_fn) {
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 07fd9286e7..48a96cd559 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -89,6 +89,7 @@ int load_image_gzipped(const char *filename, hwaddr a=
ddr, uint64_t max_sz);
>  #define ELF_LOAD_NOT_ELF      -2
>  #define ELF_LOAD_WRONG_ARCH   -3
>  #define ELF_LOAD_WRONG_ENDIAN -4
> +#define ELF_LOAD_TOO_BIG      -5
>  const char *load_elf_strerror(int error);
> =20
>  /** load_elf_ram_sym:
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 32f7cc7c33..75eb56ddbb 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -338,6 +338,8 @@ const char *load_elf_strerror(int error)
>          return "The image is from incompatible architecture";
>      case ELF_LOAD_WRONG_ENDIAN:
>          return "The image has incorrect endianness";
> +    case ELF_LOAD_TOO_BIG:
> +        return "The image segments are too big to load";
>      default:
>          return "Unknown error";
>      }
>=20

Queued, thanks.

Paolo

