Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B5C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E20F20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/iiTfmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E20F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyiVk-0003sx-Bh
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 15:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyiUa-0003Fn-55
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyiUZ-0001dj-2t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:38:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iyiUY-0001YT-SP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:38:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so20100281wrr.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XW7evqlMOIoNW7aAjIn0qTlBMOTrdzEpysgjzikLgH8=;
 b=I/iiTfmYqMHUGTgvyi/jEMu5Qk0KZ82mP/JxoAYtAf0qAoYHS+5uyWRINSR9v1uhz8
 d3sAuyl/WmkZvDQA7r5GC7YZq2mY9GKQ4CKT1QHNYiYgt6DEOvoumjDTRlbOQFRCTLbU
 Q1TgmAENy7AOLZZ1T7fuDRmyhOew+dZfRmzviUeEeCxuuIoe7/cAOLB0fxIIndPnVZgf
 0qB1k5pWvrChxivDNOhaxW9KfvxgJE4YIihsrmo4+jFfrCMmaiathHMJeHNZbYQYV4E4
 ZZLu7/sEih/bXdlY43CPVTTLkYSQ6swGeq1p58fHzyj3SNkGJp5urkmQD0kMj+X2Kqu+
 /1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XW7evqlMOIoNW7aAjIn0qTlBMOTrdzEpysgjzikLgH8=;
 b=YZ79phbT2UARP7UUxD8DqUspC5CqW4T9auxBQgVdpzdZmI1QYH7KEmMP2s+H4egfEZ
 +0awRgt5K9NW6wNxbM/Ihwp/ntULRN4LrYAdtrc4uGqch0zOo/nnuiJsRVWMcUy5usLq
 c5RNa/e7BfPBY84HHXBqTtBYpH64X5Xtz8AvRvmDyvTgfSwUluVfb23Wf/gGU5n+kofq
 mfkqvhH91A3d1QgcdF8dft+n6ZtmqFk5/EZbC5KX3h0QBMScgb6LZy85KRnUWpiuARZR
 +rd5epfFOvKB3SgjBeIgBpA1qvKTHT95B/CCY18uk5oTtuRVTmAJCO1xFH8GCvaVI8Dm
 yujQ==
X-Gm-Message-State: APjAAAXGVQ0a8jMZ470GQ2MUFuQeS3x1CNO7OMXn9BbByQkuOa7EsG0L
 DVZYWF/1l26xFrTujKE3mKY=
X-Google-Smtp-Source: APXvYqzqV1LKIerNm/S9Rric5WsoauWps0yytQPrARkFEAWJPUieb2iNeUJIz8Nc/111NTW+aXRf4Q==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr9363305wrq.37.1580762325689;
 Mon, 03 Feb 2020 12:38:45 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-48e2-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:48e2::5])
 by smtp.gmail.com with ESMTPSA id a13sm27347964wrp.93.2020.02.03.12.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 12:38:45 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
To: Peter Maydell <peter.maydell@linaro.org>
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 <CAFEAcA_8-0wqQX8KEK_zFRufoaEQkaeaXu4DLx08KazxTZ5fxQ@mail.gmail.com>
Message-ID: <1686aa04-0dc8-c08b-bdee-565979f19023@gmail.com>
Date: Mon, 3 Feb 2020 21:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.9) Goanna/4.4
 Interlink/52.9.7282
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8-0wqQX8KEK_zFRufoaEQkaeaXu4DLx08KazxTZ5fxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-02-03 11:00, Peter Maydell wrote:
> On Sun, 2 Feb 2020 at 19:39, Kővágó, Zoltán <dirty.ice.hu@gmail.com> wrote:
>>
>> This adds proper support for float samples in mixeng by adding a new
>> audio format for it.
>>
>> Limitations: only native endianness is supported.
> 
> Could you explain a bit more what this limitation means, please?
> In general QEMU behaviour shouldn't depend on the endianness
> of the host, ie we should byteswap where necessary.

None of the virtual sound cards support float samples (it looks like 
most of them only support 8 and 16 bit, only hda supports 32 bit), it is 
only used for the audio backends (i.e. host side).  In 
audiodev_to_audsettings we set endianness to AUDIO_HOST_ENDIANNESS, so 
audio backends should always use native endian.

So this limitation should only cause problems when an audio backend 
overrides the endian setting.  Wavcapture does it, but it does not 
support float.  Alsa, sdl, puleaudio and oss can also do it if for some 
weird reason it acquires a stream with a different endianness than 
requested.

Regards,
Zoltan

