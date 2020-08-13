Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA29C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99A920771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inG7FV9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99A920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k691E-0007JK-4Q
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 04:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k690W-0006qy-Ib
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:54:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k690T-0002uX-Ud
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597308879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V/Xu70u6lcifv0hDgXt3a3w3b4Iwdu/GF9J9dpk8x+4=;
 b=inG7FV9aP+dz4RME3XcTLAYZi5sx9UzYrFRq+osRiiiIIm59p4jYp5N/yL+h/o+2/QnLLK
 GXVtAFEzCreUyWW1XyOZoxiB8eq4+rP9d54ZQYnA9FXQvo1Svk0Rvbgrs/Hs2lIV/NJw+a
 WvrmdtaPxVKBAb9WvljHsDaGKkSfgzc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Q_x3TSGjMpe9aaoV2QhwSg-1; Thu, 13 Aug 2020 04:54:38 -0400
X-MC-Unique: Q_x3TSGjMpe9aaoV2QhwSg-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1805638wrr.5
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 01:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=V/Xu70u6lcifv0hDgXt3a3w3b4Iwdu/GF9J9dpk8x+4=;
 b=E+U6wsNMZNdakqwyCG2lINw/vqZWtOXAX5Q4JkYay8Ex4CSKbUpuLp9tMYngV/uhWK
 Mo6PqGyF5hbWIpHdCfk8ptpAiCpcKpPxrhIxr+1+oSyVY8cYB7tmkxP6tNYJJi6deXNy
 VpBYOB9A8Ri2dPbJoZGdt4Uv0VfnGCw6N8q1YBtkpV1ETP/XrE44KiywLdWUYNoUY8MD
 Y3dPIGx9lzX639ZO+xR87yS9pVdZQ1dL6ZUn75gNSfFfiUudLV8dOBbuTY8DQZBquxRf
 9Iap9F7taQp8kpyXDfFknpfnK6KwkcfwJt9kee0rYkgWR8vfKgfYEIAxn9nEJZVbkQZ0
 W3fg==
X-Gm-Message-State: AOAM532yiMQbQ7TTC6/Jd+lRXEju9QBCrW0OyokD9lFoeuO7P2USHeHJ
 pF7GPmKQx6HhuOKZ5umTKX5aZdiYvFQySemlZmIG6xS/ofgrBIN/r130Iju/yEaqS09m8ohcBUz
 SmEcETKTrcdjwbIo=
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr3624012wmb.54.1597308877334; 
 Thu, 13 Aug 2020 01:54:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza25jojC60bMdgWqtvyTM2n2AyboWn8qd0QNEhcGY8IngNycRdVzjSZOJTpmmyBpYdCwQyNQ==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr3623994wmb.54.1597308877022; 
 Thu, 13 Aug 2020 01:54:37 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w132sm9164092wma.32.2020.08.13.01.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 01:54:36 -0700 (PDT)
Subject: Re: [PATCH 00/17] crypto/cipher: Class hierarchy cleanups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <d3a42fcd-14a2-3883-0033-413062156db9@redhat.com>
Date: Thu, 13 Aug 2020 10:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 5:25 AM, Richard Henderson wrote:
> Mostly this is intended to cleanup the class hierarchy
> used for the ciphers.  We currently have multiple levels
> of dispatch, and multiple separate allocations.  The final
> patches rearrange this to one level of indirect call, and
> all memory allocated contiguously.
> 
> But on the way there are a number of other misc cleanups.
> 
> I know those final patches are somewhat big, but I don't
> immediately see how to split them apart.
> 
> I noticed this while profiling patches to make ARM PAUTH
> use the crypto subsystem.  The qcrypto_cipher_* dispatch
> routines were consuming a noticeable portion of the runtime,
> and with these changes they were down below 1% where they
> ought to be.
> 
> While I did not continue with PAUTH using AES, I still think
> these are good cleanups.
> 
> 
> r~
> 
> 
> Richard Henderson (17):
>   crypto: Move QCryptoCipher typedef to qemu/typedefs.h
>   crypto: Move QCryptoCipherDriver typedef to qemu/typedefs.h
>   crypto: Assume blocksize is a power of 2
>   crypto: Rename cipher include files to .inc.c
>   crypto: Remove redundant includes
>   crypto/nettle: Fix xts_encrypt arguments
>   crypto: Use the correct const type for driver
>   crypto: Allocate QCryptoCipher with the subclass
>   crypto: Move cipher->driver init to qcrypto_*_cipher_ctx_new
>   crypto: Constify cipher data tables
>   crypto/builtin: Remove odd-sized AES block handling
>   crypto/builtin: Merge qcrypto_cipher_aes_{ecb,xts}_{en,de}crypt
>   crypto/builtin: Move AES_cbc_encrypt into cipher-builtin.inc.c
>   crypto/builtin: Split and simplify AES_encrypt_cbc
>   crypto/builtin: Split QCryptoCipherBuiltin into subclasses
>   crypto/nettle: Split QCryptoCipherNettle into subclasses
>   crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses
> 
>  crypto/afalgpriv.h                            |   3 +
>  crypto/cipherpriv.h                           |   6 +-
>  include/crypto/aes.h                          |   4 -
>  include/crypto/cipher.h                       |   5 +-
>  include/qemu/typedefs.h                       |   2 +
>  crypto/aes.c                                  |  51 --
>  crypto/cipher-afalg.c                         |  25 +-
>  crypto/cipher-builtin.c                       | 532 ------------
>  crypto/cipher-builtin.inc.c                   | 425 ++++++++++
>  .../{cipher-gcrypt.c => cipher-gcrypt.inc.c}  | 522 ++++++------
>  crypto/cipher-nettle.c                        | 733 -----------------
>  crypto/cipher-nettle.inc.c                    | 756 ++++++++++++++++++
>  crypto/cipher.c                               |  44 +-
>  13 files changed, 1477 insertions(+), 1631 deletions(-)
>  delete mode 100644 crypto/cipher-builtin.c
>  create mode 100644 crypto/cipher-builtin.inc.c
>  rename crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c} (51%)
>  delete mode 100644 crypto/cipher-nettle.c
>  create mode 100644 crypto/cipher-nettle.inc.c
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


