Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16D920C09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKz9h3qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16D920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFj0Q-0003CC-Mw
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFizo-0002gY-Ai; Tue, 08 Sep 2020 15:09:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFizm-0005Tz-Fv; Tue, 08 Sep 2020 15:09:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so332067wrm.9;
 Tue, 08 Sep 2020 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DrisOpGFtDxqQ6ZOwIy7P7Te3rArBaCMqpd+J78H0PI=;
 b=WKz9h3qtt/LvrfQpuVn/nKOHS1F8Iv+mNrga7NkddPLWeNFmPdxiTSnWbwhayLcAkq
 mn0OKuaXHcHJzWqXsDdrcmxKhju/DHkVyvMzWHO2CMJEkJpl/S4EKMVfAkUxKLQSOuiD
 5kIxLSGAPbHbTiICSQfNRr55rU2A23+UWODeeyGIiwf7n7l3PE7aIkX8r2lUKJvN1NRO
 EbydiaWXt/Df1QB+MxCwkd9/iiAi3/pChbPCf33IVUbNeC6eCB9xG1Yzza5biyJAqj4S
 UFR7gFtU0BIVu2c3deYb7eO5cHcA+tGeQdzKQWx9Vpuwsh/Plai3Wxf1nLTBl+gppKtk
 VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DrisOpGFtDxqQ6ZOwIy7P7Te3rArBaCMqpd+J78H0PI=;
 b=D9W/hBIUbg05yPb998AzOwNVYNgyKMlripPBR93QNxFQoWkaNpFjlZ0l9g2Ekfu8aF
 x3gxr7I32VxCoga0ht3xQjzknqd0TkEwlimRVdzPx9Ngl9PX4Zu834sM++0WsTR4B0U7
 JBM1IS70DKt2pTVOOkHH/TwkiSmbqXn45W9NAdUOJlPbn8PAEf+IGXmHhTuOex/EfdOR
 9106bIsnnA4UcjgISw1hIaZ5zzWFW4/NYeM8u84S5P/dE6XOs+2s/heiw4btCvNf4lA+
 yTFOQV1IJRPASQR9o9jfxS6lhuJGNhTQ5jxpCJXYmaJCYCfqAfUlBx6gimM/sb2j5vSg
 gOAw==
X-Gm-Message-State: AOAM530yywa5iT7PrhRZYkRgn9NK20KblZ8reQ5W6Y+BmRMwnJx39G3H
 hZR1wHthY3xlsO3CFQ0Bss4=
X-Google-Smtp-Source: ABdhPJzeXCwD/EUbXscggvnQpVYOwCg5i5KImm0GbGfdt2wOX0r9TkgNCDPTZ4qydmDbfR8lHHjixg==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr1045804wrg.131.1599592172605; 
 Tue, 08 Sep 2020 12:09:32 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p16sm530902wro.71.2020.09.08.12.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 12:09:31 -0700 (PDT)
Subject: Re: [PULL 00/16] Msys2 patches patches
To: Eric Blake <eblake@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org
References: <20200908184918.1085-1-luoyonggang@gmail.com>
 <2327c062-c19e-c405-0f2f-76ad0abfd471@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9f844a55-efed-1359-dfb4-c6995c376325@amsat.org>
Date: Tue, 8 Sep 2020 21:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2327c062-c19e-c405-0f2f-76ad0abfd471@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 8:56 PM, Eric Blake wrote:
> On 9/8/20 1:49 PM, Yonggang Luo wrote:
>> The following changes since commit
>> 6779038537360e957dbded830f76b08ef5070161:
>>
>>    Merge remote-tracking branch
>> 'remotes/armbru/tags/pull-qapi-2020-09-08' int=
>> o staging (2020-09-08 17:23:31 +0100)
>>
>> are available in the Git repository at:
>>
>>    http://github.com/lygstate/qemu tags/msys2-patches-pull-request
>>
>> for you to fetch changes up to 1892e4360f55ac8cbeeeae0043e0a9dc05c50269:
>>
>>    rcu: add uninit destructor for rcu (2020-09-09 02:34:59 +0800)
>>
>> ----------------------------------------------------------------
>> msys2 patch queue 2020-09-09
> 
> MAINTAINERS doesn't mention a category for msys2, and this patch series
> doesn't add one.  It is unusual to send a pull request without being a
> listed maintainer for the code in question.  I'm not objecting to you
> taking on a maintainership role, if we are ready for that, but I also
> worry that you have so few contributions currently in the main
> repository that you have not necessarily proven the quality of your
> work.  Maybe it's better to just send this as an ordinary patch series,
> and let an existing maintainer incorporate it?

Beside what Eric said, you sent all your patches altogether, this is
already an improvement for reviewers, thanks!

