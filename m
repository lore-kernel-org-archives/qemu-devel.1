Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6527C207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc6DyX5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6527C207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joreW-0004zv-Jl
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorST-0006rd-TN; Fri, 26 Jun 2020 12:44:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorSS-00079N-6g; Fri, 26 Jun 2020 12:44:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id t194so9970841wmt.4;
 Fri, 26 Jun 2020 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xeya6t7YEUT6iXR0Ro2MM8pOQvxxAocwgvBGif3Bleg=;
 b=pc6DyX5mDlWcIPcSk+d3irTVLgRyxGwjvbtkjOQ3Zq47/e0ZBbN9LpDOG85zbLyqXS
 n2af3Y+zjuPBd+EUBXDIyWgy/pw/zPFyjkQSDUqdQhnPZVPYSbTVibiEHC0CJLpb29QZ
 Emy/9MWst6uhUue5kh55vDBT7gXs6Ky3HiV+kUHX0e9ux+tVbye9uHgJZoZQ8piJv0mU
 cDgfevM7RxKpfEks0rYJvms/5zeK5INRUsSufGKjSCmU6u4pHiiO6VFMMYU84WdC0Qxh
 +AJuSL0Al6LQhKgvTQ85TPlpy+OsgrUg/RHzi29LbdeNhL1G8XU54OQyl+zKdztK6a3I
 95Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xeya6t7YEUT6iXR0Ro2MM8pOQvxxAocwgvBGif3Bleg=;
 b=MjSPNuEukCGA4QFOA8mhD7QIOLcmWS7MvI7z+HLGjn6/CMZFNWieU5LCWcNVOw5VKP
 qc7Wk+HSBogSDRVByMXTeB+pOpjCUnObB/5BNGYObUPZbTUTGD1s3X0gPolnKQH+LcGv
 DbanjOu7RgcHlW+Syk+ju8XUuyAA6T8AXQHRdzE1VWcO+oYP8ZMmU/eY8f8mCnqeYyTj
 HlKoJy5IyeFSXDniL1u/y6SJTc4S6lZFLw/qReR7ZWJpq979ZQJkQPmnZ4eRQyNgGm25
 /8VSMc25pgmiOvuWRcdCbXwerVPZFiXVjvqjO89atieE4h8+oZBPK+DzhJN8G4c439QH
 YW2w==
X-Gm-Message-State: AOAM532DDsX94hLMVBnacdiQ9OiVOmjCyW1MSksXSz3VnKxGJsYCYaNK
 x0+p5FFneZY/w0cmSxxxjpj70ZXf
X-Google-Smtp-Source: ABdhPJzn6w7hp9bB0UDKYrQPy0ZzIOQOelkAASsUJApyneIKBPOh6XsvFV+BQ3aG6AgZ0ZOKZqFZ1w==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr4381286wmk.77.1593189846170;
 Fri, 26 Jun 2020 09:44:06 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v66sm18808630wme.13.2020.06.26.09.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 09:44:05 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Use object_get_canonical_path_component to get
 child description
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <CAHiYmc6DNCaDzLautfL26Rv_hAjZ-M582nr-hj6t=JwB7zWcyg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cfc8c2b4-4743-c067-cf27-76bbc2f67308@amsat.org>
Date: Fri, 26 Jun 2020 18:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6DNCaDzLautfL26Rv_hAjZ-M582nr-hj6t=JwB7zWcyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 5:59 PM, Aleksandar Markovic wrote:
> пет, 26. јун 2020. у 12:27 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> This RFC is simply a proof-of-concept to see if I correctly
>> understood Markus' suggestion, see the thread around:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08652.html
>>
>> Philippe Mathieu-Daudé (3):
>>   hw/i2c/smbus_eeprom: Set QOM parent
>>   hw/i2c/smbus_eeprom: Add description based on child name
>>   hw/i2c/smbus_eeprom: Trace reset() event
>>
>>  include/hw/i2c/smbus_eeprom.h |  9 ++++++---
>>  hw/i2c/smbus_eeprom.c         | 18 +++++++++++++++---
>>  hw/mips/fuloong2e.c           |  2 +-
>>  hw/ppc/sam460ex.c             |  2 +-
>>  hw/i2c/trace-events           |  3 +++
>>  5 files changed, 26 insertions(+), 8 deletions(-)
>>
>> --
> 
> Is there any documentation related to this interface? If yes, provide
> the link, and describe what is not clear to you. If not, then this
> series should provide appropriate documentation.

It is described in "qom/object.h":

/**
 * object_get_canonical_path_component:
 *
 * Returns: The final component in the object's canonical path.  The
canonical
 * path is the path within the composition tree starting from the root.
 * %NULL if the object doesn't have a parent (and thus a canonical path).
 */
char *object_get_canonical_path_component(const Object *obj);

> 
> In times we desperately need working "Continuous Integration", it
> looks we instead spend our time on "Continuous Interface Guessing" -
> for years.
> 
> Thanks,
> Aleksandar
> 
> 
> 
>> 2.21.3
>>
> 

