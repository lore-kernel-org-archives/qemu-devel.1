Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C6C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AC12192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZk/xoY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC12192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtJH-00083G-EN
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVtIE-0007Pf-KC; Fri, 23 Oct 2020 05:23:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVtIC-0008Gd-Rz; Fri, 23 Oct 2020 05:23:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id y12so1005143wrp.6;
 Fri, 23 Oct 2020 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6WcAI9LqJXniaPU6wS68WgkQq4afR52p4cXzIvB+4bY=;
 b=JZk/xoY2lAtCzpCM/W6AqoeoBOknlnn1ePqygyIhbmTUs8AUhOWGxiQGDAbcvp/0PH
 x9We/ITPaCMiziJX0RtsqyirB1fjJnHqN2PnBmKesRjv9jyaLIXwBV3rv7N35xABHmCc
 vu+r9Ab1gVKDwynBYkMN3dkqaMlD1BDZKq21XQmof8FEgfD+ijpM4XwfzD9bcOLOg7Nn
 7wHN8KNd7WnbtLIsfa8dXhOLJ6yIYVmpVITRGu+71RJOsir5iXmEdQ7h8tOvX0HBWeu5
 mbNQYtwKB6EPiuy2h5mLyeskd/7NLnYs2GKMyGxmS3bYeT7ce0D7wqR+XdFwCq8ffZQ5
 QW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6WcAI9LqJXniaPU6wS68WgkQq4afR52p4cXzIvB+4bY=;
 b=lcsrGzRXJHTSZJfbsKaSbz7aab08EECyz3NCXW+yCBxDXs/+ag50DDddGLlCQ1hpx5
 bYNtR6ePjIvoRG2J5jG0mi4zFolQR+HjAVQLTQEEwjAyH22acAEY1KnMVrhXLOhyX/N1
 zHELnYyVQux1VVCdh+GMJ6gAEE7Hx5uIX7GwT2eD6GF8KfQXggV8NmMiAXe7fRGGm6es
 aUlIbRSk8g4yka0Bo4/XSaeYzoBY8fvn4l2jlZqeUs13X4nevh5X405IkiC5vBRqUC++
 Kj0vbjSFi1Kb3+KEDuRis3kQRmItxk7N5vQyDzIn/85GnUOUS3/kOSfYN5oiGUxFP5FQ
 V0ZA==
X-Gm-Message-State: AOAM531xTnpuzLslTzz4LrGk1kScsmO0xgwCzAdBFqj8WRFsqW7CGeld
 6GJkqtqsiWHzJUY0pj3otcK3QAx6WC0=
X-Google-Smtp-Source: ABdhPJyEmadX2JC0m/tI0eaujivh+MZUaQqmPxBA7CPHeH5qAuXn2EFJFM80UKBUJMMal4yJjgSreg==
X-Received: by 2002:adf:91a4:: with SMTP id 33mr1689539wri.170.1603445002235; 
 Fri, 23 Oct 2020 02:23:22 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l8sm2060367wrn.28.2020.10.23.02.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 02:23:21 -0700 (PDT)
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: Bin Meng <bmeng.cn@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
 <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
 <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db561779-005b-c358-3e72-e1169ef49faf@amsat.org>
Date: Fri, 23 Oct 2020 11:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 4:02 AM, Bin Meng wrote:
> Hi Niek,
> 
> On Thu, Oct 22, 2020 at 11:20 PM Niek Linnenbank
> <nieklinnenbank@gmail.com> wrote:
>>
>> Hi Bin, Philippe,
>>
>> If im correct the acceptance tests for orange pi need to be run with a flag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be run using the armbian mirror. So if you pass that flag on the same command that Philippe gave, the rests should run.
> 
> Thank you for the hints. Actually I noticed the environment variable
> ARMBIAN_ARTIFACTS_CACHED when looking at the test codes, but after I
> turned on the flag it still could not download the test asset from the
> apt.armbian.com website.

This patch could help you, but it use a different image [*]:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg737760.html
(I haven't tested the image yet but I assume the same bug is present).

> 
>> I have a follow up question and Im interested to hear your opinion on that Philippe. Should we perhaps update the orange pi tests (and maybe others) so they use a reliable mirror that we can control, for example a github repo? I would be happy to create a repo for that, at least for the orange pi tests. But maybe there is already something planned as a more general solution for artifacts of other machines as well?

This is a technical debt between the Avocado and QEMU communities
(or a misunderstanding?).

QEMU community understood the Avocado caching would be an helpful
feature, but it ended being more of a problem.


I.e. here Niek, Michael Roth and myself still have the image cached,
so we can keep running the tests committed to the repository. You
Bin can not, as the armbian mirror is not stable and remove the old
image.

The old image (Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img)
has been manually tested by Niek and myself, I enabled tracing and
look at the SD packets for some time, was happy how the model worked
and decided we should keep running a test with this particular image.

Armbian released new images, in particular the one Cleber sent in [*]:
Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz. While it might
work similarly, I haven't tested it, and don't have time to do again
the same audit.
 From my experience with the Raspberry Pi, these images never work the
same way, as the Linux kernel evolves quickly with these kinda recent
embedded boards. The QEMU raspi models have to emulate new devices
(or complete current ones) every years, because Linux started to use
a device differently, or started to use a part of the SoC that was not
used before. Either the kernel doesn't boot, or there are side-effect
later when userspace program is executed. PITA to debug TBH. For this
reason I disagree with updating test images to the latest releases.

It would be nice to know QEMU works with the latest Armbian, but
nobody popped up on the mailing list asking for it. I am personally
happy enough using the 19.11 release for now.

