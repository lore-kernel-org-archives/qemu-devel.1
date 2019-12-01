Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C4CC432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D41F20718
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBJCNYV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D41F20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibSDF-0008FT-MY
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 11:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dsahern@gmail.com>) id 1ibSCW-0007Sg-RC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dsahern@gmail.com>) id 1ibSCV-0003Db-KS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:36:00 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:43555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dsahern@gmail.com>) id 1ibSCV-0003CH-FD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:35:59 -0500
Received: by mail-il1-x144.google.com with SMTP id u16so5046725ilg.10
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EmKXPT8/zzRPMHZdVznWwaEqUYddRfodakHAFbk74gY=;
 b=jBJCNYV7E9qH9/FnvkjHwjWx5oRkv2t9fLyI8atyKOxXUumjx7wHBM38zb9ReMx8U2
 USGKsR3ENN8rxtghmGCxxtIRqixfCTbjiMV1l+u9XQGQf2qtl7u+K4JZbssMjHKR6/pB
 NfGSe7cVzV1UBiPaiCIj63W4Jw1gaICoIKwjRL3BUCSlltKdkkbRrtfELlEJk2mqkNuP
 fxc1ghZ8tyyEkNXnuJWYloKCmZ0KDKEelCKvtbDB/e7cehbFZBxCP3G5H++EUS8PowYP
 MzZeVozXr8EC+YomO5nhX3fcxzCp+Cu/S5ss9+Hx33yNMmcU5NCo2GhTYsn+MnvSAaUw
 LEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EmKXPT8/zzRPMHZdVznWwaEqUYddRfodakHAFbk74gY=;
 b=SzenEuIw595jrVRBOJyzOI0v4DHDTEO+owO6YJvHaFNjteM1Chz8T/cp9F4yPn66IM
 svzTzWt3J7KLnjDNSxPwkaubBDmS+BwJAj18v+PZULgzQCoGmvPb5cbm17HQO/DRQr2g
 yFLbNdiK33bfe3w7KFWjZ1PJUFHQo9WjfOBS1evKYrHHPE1t5eZDcE47tecweDEwRfLt
 cfyO+1anq6APwLRSBoSOwOEAK0YT5BYMavgXtwny0PQuXyrrMISe3hhdez5070xfkVEv
 jJA5IgiVpw4LNcwmCkqeSKSwGH6TKGup90Sj/SdMLa0Cym+rW+7v9YZXOvnfSogRXKSh
 c4xA==
X-Gm-Message-State: APjAAAX7XOsQaaZZM0Y0CPJS3OpD9OmBdDcZh9fiiJfXcx9/fGzyJa83
 W2ckIbrTpxalg3+UeKTPIXU=
X-Google-Smtp-Source: APXvYqwIGHpUDCTLx6NUYZvnwluVz7GM9HsJnDjkWaPYpZXaxx4LTfh/9h7LO4SsISF4tXoychuGZw==
X-Received: by 2002:a92:3b19:: with SMTP id i25mr16713300ila.85.1575218158458; 
 Sun, 01 Dec 2019 08:35:58 -0800 (PST)
Received: from dahern-DO-MB.local ([2601:282:800:fd80:fd6b:fde:b20f:61ed])
 by smtp.googlemail.com with ESMTPSA id e73sm256972iof.63.2019.12.01.08.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 08:35:57 -0800 (PST)
Subject: Re: [RFC net-next 07/18] tun: set offloaded xdp program
To: Prashant Bhole <prashantbhole.linux@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-8-prashantbhole.linux@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <e0631f09-28ce-7d13-e58c-87a700a39353@gmail.com>
Date: Sun, 1 Dec 2019 09:35:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126100744.5083-8-prashantbhole.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 4:07 AM, Prashant Bhole wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> This patch introduces an ioctl way to set an offloaded XDP program
> to tun driver. This ioctl will be used by qemu to offload XDP program
> from virtio_net in the guest.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
> ---
>  drivers/net/tun.c           | 19 ++++++++++++++-----
>  include/uapi/linux/if_tun.h |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d078b4659897..ecb49101b0b5 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -241,6 +241,7 @@ struct tun_struct {
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> +	struct tun_prog __rcu *offloaded_xdp_prog;

I have been looking into running XDP pograms in the TX path of a tap
device [1] where the program is installed and managed by a process in
the host. The code paths are the same as what you are doing with XDP
offload, so how about calling this xdp_prog_tx?

[1]
https://github.com/dsahern/linux/commit/f2303d05187c8a604cdb70b288338e9b1d1b0db6

