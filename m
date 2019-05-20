Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8EA206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8EA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmMO-0002lA-6x
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:46:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm2P-0002ai-4q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm2M-000645-9m
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:25:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSm2M-00063E-4R
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:25:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so15530913wrl.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YAGafpKWlTBR5z7xtPZCtG1bD5UHiFNT7IoDod/KXlQ=;
	b=HbnYQkyFWwcxnSlygLCaDeFnot1zwnrzNqWOjkw5Q+7lizQBLXJVNWcEs+U4iYCNHU
	1/uYuyrYC9lByE8Z9LdJTVfyaFUhUwqZKcKu7iF44vSanyieZ58d5BLtlq6EuZGnTAzX
	i3ZiZt7upFq7HDiVav60vFTclenaQbSX5uR7/eyX64Zlu+twY8iCBCdTMqpTHWa/WC7D
	CY2mXZwwKgq0mUtxg/4XhuI0fZ0bcJDngPyQ6W1ytMJ/n/8S5KXSCYXMAIycUcIKA/yL
	1HxSikluP7SI/ylHUG5FRz2KK7s7Vgu256Lro2i4mj5zWjqEcAnzaiByXXgcrSjViCKY
	YgHQ==
X-Gm-Message-State: APjAAAUzIQN5p35+5sme50sASIi/CgPVMXtBSdgH8VpZf8tqisDZag6o
	PAPs2ug7lMOvuBICrS+KEnH8q1GwFDU=
X-Google-Smtp-Source: APXvYqzUZqNB5TWQnZVAqub5zdluxBkd0/RqSoZnRMSQn2O/OoLy253CTAvUWRv56MWb8hsVwiUiog==
X-Received: by 2002:a5d:6b50:: with SMTP id x16mr1833026wrw.220.1558373120421; 
	Mon, 20 May 2019 10:25:20 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id 67sm160459wmd.38.2019.05.20.10.25.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 10:25:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190520162809.2677-1-peter.maydell@linaro.org>
	<20190520162809.2677-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d95fef3-b59d-69b2-5776-7494f74dbd0f@redhat.com>
Date: Mon, 20 May 2019 19:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520162809.2677-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/intc/arm_gicv3: Fix write of
 ICH_VMCR_EL2.{VBPR0, VBPR1}
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 6:28 PM, Peter Maydell wrote:
> In ich_vmcr_write() we enforce "writes of BPR fields to less than
> their minimum sets them to the minimum" by doing a "read vbpr and
> write it back" operation.  A typo here meant that we weren't handling
> writes to these fields correctly, because we were reading from VBPR0
> but writing to VBPR1.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/intc/arm_gicv3_cpuif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index cbad6037f19..000bdbd6247 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -2366,7 +2366,7 @@ static void ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      /* Enforce "writing BPRs to less than minimum sets them to the minimum"
>       * by reading and writing back the fields.
>       */
> -    write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G0));
> +    write_vbpr(cs, GICV3_G0, read_vbpr(cs, GICV3_G0));
>      write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G1));
>  
>      gicv3_cpuif_virt_update(cs);
> 

