Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9A121E6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfd/MwF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A121E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaTC-00082z-BZ
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUaS9-0007UQ-A7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUaS6-00065h-Eg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:59:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUaS6-00064z-6w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573581581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=inaUrAqlO9f2fCusKfgrQkNvn6nw0Sit8cZDHu0UyI0=;
 b=Yfd/MwF9HaS3uUUpdiicrG+u6dgdt/nwy/xreBTQmqzK+h6bHF0PAzb2Lmv1IQRn5tn1cH
 fsgbjzwx3diC24EcpshjpD+q6aV6M1oj3KAYg8gv5RTLscTWeB9SBdPwdjRVFsyeZ592bm
 7tL6V2tu2dcui4JAGHd5Xt7V6juUO3g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-B6Q45NvOOmCyoMIRiOihIQ-1; Tue, 12 Nov 2019 12:59:40 -0500
Received: by mail-wm1-f72.google.com with SMTP id 199so1984630wmb.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o68stXTTYyv/hkVCHpr8R/spnIn0dJ4yEUgJ4hreUPw=;
 b=FcAD9zgCz2yxGUlNFSLSKcUKLEfiDSnNQmGyUEZ1wZkvkShBVq1SD/VOovfihcsGna
 BPwAq18OVz9vLUy2SK6JPnFhGESVlfDopJYYec+zqyBdKK4lbZzOmgIMVCRNeVC18zXx
 gtNVPvCkWHyBR3h4YlL5n6p5c51mIpDDCaxndy1vkJzAuT2+MlXSjlRxectlz5jbQnV3
 NL9T9yhdd+gLKpVYXj6/xkzQUwCMab2gS7Hp5g4oYA7m532QN45f8NJQOUJZ4U9EwwpI
 epbPon27EuJ8go0nNxqO+wBP0aztUUBmnOmjjVQuerhozbdq3U/BgwDJ7XN//XGnhVBw
 dwMA==
X-Gm-Message-State: APjAAAVCQotg+tgiAGJXiJttN9018ArnWYm5A8YqDh+9SOmxkcVkUgxm
 hJ3UGs0pdElE6O5yRYRAHgbPPuLgglDovxc8evNG1Fnbb7cPqhXWzcJOF+K83DSVhrEjVkU7UD9
 HXCRoj4r1eIi5gSI=
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr3436595wmi.145.1573581578938; 
 Tue, 12 Nov 2019 09:59:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwC9yUMxlKITsttDnG5GH7q8H8eAawRfDpfPazAm0ha4DSbn1FygxWu1TggCJaYMaer+sYaiQ==
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr3436575wmi.145.1573581578672; 
 Tue, 12 Nov 2019 09:59:38 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v6sm16495406wrt.13.2019.11.12.09.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:59:38 -0800 (PST)
Subject: Re: [PATCH] microvm: fix memory leak in microvm_fix_kernel_cmdline
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191112163423.91884-1-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6c05f286-e685-daf8-c859-ae81ed55d97a@redhat.com>
Date: Tue, 12 Nov 2019 18:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112163423.91884-1-slp@redhat.com>
Content-Language: en-US
X-MC-Unique: B6Q45NvOOmCyoMIRiOihIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 17:34, Sergio Lopez wrote:
> In microvm_fix_kernel_cmdline(), fw_cfg_modify_string() is duplicating
> cmdline instead of taking ownership of it. Free it afterwards to avoid
> leaking it.
>=20
> Reported-by: Coverity (CID 1407218)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/i386/microvm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 8aacd6c8d1..def37e60f7 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -331,6 +331,8 @@ static void microvm_fix_kernel_cmdline(MachineState *=
machine)
> =20
>      fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline=
) + 1);
>      fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
> +
> +    g_free(cmdline);
>  }
> =20
>  static void microvm_machine_state_init(MachineState *machine)
>=20

Queued, thanks.

Paolo


