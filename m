Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DCC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0C420795
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOHpXfjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0C420795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJbuq-0004KY-2O
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 08:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJbu7-0003nE-57; Sat, 19 Sep 2020 08:23:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJbu4-0005jk-QD; Sat, 19 Sep 2020 08:23:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so8056682wmb.4;
 Sat, 19 Sep 2020 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x792t5UgtPuY5LZTB49doOI/JJSALOXiZvyzW0t5x+c=;
 b=BOHpXfjdTvyGuTna9BiGKh6JLCpXZTodw3hN3etKMWj3HztuXgxT9nPGXweegoAbWK
 /c1o3t+8/nnlAeImqOyZRVXRLwWAtpUwhX3mi5Oqwwdfa+ivcPOHGZxV/JpyrDZyzBEW
 Iz4YLWzAnn+J6NPulAMEWvzevD9jfqANWyWtqGfApAhAmp8hYW7473cS/Z+goo3MkuEk
 DBTPUHSX4dHJIS7smU5LPicDK229Y++kq9Jq6ncuU3SSY92ImthYifBAQvd13Y2otPb+
 1YvMNtCPj/PMFyh4XUGy3qGraAF5qVpKC0yiTvHkx7lvtF7Jl6XmlF3ZloLO8jAA+dzc
 12FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x792t5UgtPuY5LZTB49doOI/JJSALOXiZvyzW0t5x+c=;
 b=FkyR7LU6L7v0r+rxCgXOnDyzO164UrDqnTkMnk1aI8tvH8yQl3fbQiUEY04YBcsvoc
 tym8cDjI+jgLja1BvhUrwwFTwXTnigNUb+I9v0q+522uNV+o1y/CIis2MWT/VfJCgPll
 dILGH/anBDRWrkrniHWdl9hGoAXUE+Mnon1qV0O/7CgN40gSov4/DNFpUeam+v1NP3yv
 tPQ5dfuQlcj5CWXwVi7umHWZ1/AYAsSX1bYrazrewic9DLvUK4FA9ZpKnfuhltI0YoT3
 nZaYuyj8FH+NmYXS2yS2W1HwwhSAM1AygJTyRrHa5Symlu3gkKagAzG2GItCRt8S/591
 R7Mw==
X-Gm-Message-State: AOAM531bVDHfcl/zChbd5U98JtJmpK3v5ZtFdDyoNlu29KxQe69Ie8ME
 hGbKXcmGlkgARRDyE5ekUQNny5lhMLU=
X-Google-Smtp-Source: ABdhPJx8NQNWx5+UK5hbmiFeHbiPQ6hDt28AUcOjbZwaOpNvxgG3FwW8lMB3FlTPshT4MXYi0VsT9A==
X-Received: by 2002:a05:600c:210c:: with SMTP id
 u12mr22001682wml.185.1600518222482; 
 Sat, 19 Sep 2020 05:23:42 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f12sm9972368wmf.26.2020.09.19.05.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 05:23:41 -0700 (PDT)
Subject: Re: [PATCH] xen: xenguest is not used so is not needed
To: Anthony PERARD <anthony.perard@citrix.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20200727140048.19779-1-mjt@msgid.tls.msk.ru>
 <20200727150949.GC2866@perard.uk.xensource.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <07fb2cbf-e006-0ee8-a749-af0d5b4fcc9e@amsat.org>
Date: Sat, 19 Sep 2020 14:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200727150949.GC2866@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 7/27/20 5:09 PM, Anthony PERARD wrote:
> On Mon, Jul 27, 2020 at 05:00:48PM +0300, Michael Tokarev wrote:
>> There's no references in only file which includes xenguest.h
>> to any xen definitions. And there's no references to -lxenguest
>> in qemu, either. Drop it.
> 
> I'm not sure what you mean by "no references to -lxenguest", do you mean
> in the binary?
> 
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Otherwise, thanks for the cleanup!
> 
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> 

