Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A2C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5082078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skTw/xlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5082078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFhP-0004aU-7s
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFdr-0000SD-W8; Tue, 13 Oct 2020 04:26:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFdq-0003pn-Hy; Tue, 13 Oct 2020 04:26:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so22890985wrp.10;
 Tue, 13 Oct 2020 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JvV/jsI0fp+K5yXTJ78yB5K/nDwyOATa0k0NxH4XbJ4=;
 b=skTw/xlICwwR5N0v0dnG8QvyF/1b6Pv/5qIpJCXnNA+DEz/b8DpsuXQRJ5EE0UQxEu
 MTZJDKGwNQ8G7nY0uIdtcgXv/xQKYK/1kXGMYgVO3kZj9kvkqXI6h1DGmMNsAux/Df9V
 QTf9Mxf24UGVJNovd7f7sSXsGIvL+aLdtTpvgBUxi1g0UIIgMWXnMMNMZqDan2mQCHFl
 92sphId05K4/lAxuq0/SpT7MGJuw16PD+3sJaZL9Rj0DSz+q9mRYropOwOgiTfyUlUnE
 ff0nIgtc2cfXeQ+0YMLQAbmaXZgn2TwXHaWu/07HpZFKLLgZD9ZfEWqOSlFrI/kLg1XQ
 pYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JvV/jsI0fp+K5yXTJ78yB5K/nDwyOATa0k0NxH4XbJ4=;
 b=sh+tfPSzcUzuleos4CDYfaPFm3ykx8ypArcssBuIvO+PqkyQQgTffM90x8oMOXYJAC
 jIjZd6EUCwQLPBiEde8jDs5Jmvc0vEXhvk1g6VzmFhvTG5cUTU2QswJj0SE9A1aMuB1K
 rZV8/NfEWV4Yu9cu3ZZWbYWaRMZp2cbXWFi8bMR+k5+GahPWkUPX34C8FrkWBTYo56QF
 5rLC1fJyMbXsh7uhJe5BT8kURKGLgY479BCgoAtPX1tmPKOeJRjWXAcyFPHzXbQH2uYl
 rvwH8ZFS0O0S1iOW6aahD+0rijdiMWBdFeCYLYPnmWl+HK5VydunzxwAdadmBSimcl00
 YnSA==
X-Gm-Message-State: AOAM531exXFnhPBbn5USofGGIgcm1KdMJqhx/DLHCSKCQIq3ovkhXgU1
 c+E4gT5djJAmMipmF2v2mieclJRXyk8=
X-Google-Smtp-Source: ABdhPJzFRTTKs5E+I6c9XaE9kersmgVLuDwxs29Hfpp6s9Wcp9PfLyQCrxv3ltI5geolaA10KC7L1g==
X-Received: by 2002:adf:dec1:: with SMTP id i1mr31612704wrn.50.1602577600223; 
 Tue, 13 Oct 2020 01:26:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 4sm29132690wrn.48.2020.10.13.01.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:26:39 -0700 (PDT)
Subject: Re: [PATCH 04/10] hw/isa: Add the ISA_IRQ_TPM_DEFAULT definition
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20201011193229.3210774-1-f4bug@amsat.org>
 <20201011193229.3210774-5-f4bug@amsat.org>
 <20201013072028.lw2uuncabmme7vws@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70253a5e-d4cc-fb89-6235-cd53ee1bc18b@amsat.org>
Date: Tue, 13 Oct 2020 10:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013072028.lw2uuncabmme7vws@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 9:20 AM, Gerd Hoffmann wrote:
> On Sun, Oct 11, 2020 at 09:32:23PM +0200, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>> The TPM TIS device uses IRQ #5 by default. Add this
>> default definition to the IsaIrqNumber enum.
> 
> IRQ 5 has no fixed assignment.  All kinds of add-on isa cards (sound,
> net) used to use irq #5 by default because that one wasn't assigned
> otherwise.  Seems these days tpm and ipmi use it ...

Yes, I'll drop this patch.

Thanks,

Phil.

