Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDEEC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 19:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945002086D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 19:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945002086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhfCq-0006o6-Ss
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 15:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hhfBl-0006LI-RL
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 15:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hhfBk-0002EG-NY
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 15:08:37 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hhfBk-0002DL-Gx
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 15:08:36 -0400
Received: by mail-wr1-f43.google.com with SMTP id n4so11352169wrw.13
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 12:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m5psWddGk0nOatb5HYZnlnx9TEatUTcZQVXL2tThe+Y=;
 b=p+3Dji/3dZpiGudXKh/ATCGlItmHvCPaZkLBqZL4IBP0fpiHRvoO3xFQG72GM/61x/
 Iq+dsqyLAyBfaELTFZGUOT1iSZAjLPwI4wvArJVeoXqf1vb/uL2+k8cyuJNf8Eq0N7sz
 XXIsZGfqEQIvERdPLHFD80t1AkfD2QxayPBg0vVU3wYgTAWcKKxi/ss8S5su/fgcUdks
 kl3Ac1axqE0mAxw1LTToHRLjU2QgV0PGhQqyoaDBvbhgo+1uKgtePfJ/xAXfVx64wEyI
 Fwi6SIKVI+IcNI3aBh06s9Ovd3Kso9e0CrLal0WNhwp/fICW646xhcbr2nUtZlHQCo11
 7lBA==
X-Gm-Message-State: APjAAAW6fzurHI2bui51OBXvgPY/IqO4MhNCqU/+zW0HasBOxZWqUuux
 lSH4tvYKHu+MbA7yi3YLPkY=
X-Google-Smtp-Source: APXvYqzKRQ8HN2oX2NjinHBpJJlcyQs34sBWFVsHWxXXXvhowgUCSN5rGJzV2W22gxD3ZqHMK2Vr4A==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr15855916wre.205.1561921714990; 
 Sun, 30 Jun 2019 12:08:34 -0700 (PDT)
Received: from thuth.remote.csb (p5791D674.dip0.t-ipconnect.de.
 [87.145.214.116])
 by smtp.gmail.com with ESMTPSA id n125sm12267899wmf.6.2019.06.30.12.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 12:08:33 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190629150056.9071-1-f4bug@amsat.org>
 <20190629150056.9071-2-f4bug@amsat.org>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <96d86410-45de-d0ae-d4b9-747ed6e05358@tuxfamily.org>
Date: Sun, 30 Jun 2019 21:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190629150056.9071-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.43
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/2019 17.00, Philippe Mathieu-Daudé wrote:
> Add a test of the NeXTcube framebuffer using the Tesseract OCR
> engine on a screenshot of the framebuffer device.

Wow, that's a funny idea, I like it!

> The test is very quick:
> 
>   $ avocado --show=app,ocr run tests/acceptance/machine_m68k_nextcube.py
>   JOB ID     : f7d3c27976047036dc568183baf64c04863d9985
>   JOB LOG    : ~/avocado/job-results/job-2019-06-29T16.18-f7d3c27/job.log
>   (1/1) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer: |ocr:
>   ue r pun Honl'ﬂx ; 5‘ 55‘
>   avg ncaaaaa 25 MHZ, memary jag m
>   Backplane slat «a
>   Ethernet address a a r a r3 2
>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
>   Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled>   [...]
>   Yestlnq the rpu, 5::
>   system test raneg Errar egge 51
>   Egg: cammand
>   Default pggc devlce nut fauna
>   NEXY>I

Hmm, the quality of the text is rather bad...

> Documentation on how to install tesseract:
>   https://github.com/tesseract-ocr/tesseract/wiki#installation

... according to that documentation, you're also supposed to install a
language pack ... have you tried whether it gets better with
tesseract-ocr-eng ?

 Thomas


