Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE88206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGYZL5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE88206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxYM-0002Ek-6l
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1ihxWt-0001Gz-03
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1ihxWq-0003Ei-O6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:15:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1ihxWj-0002u8-55; Thu, 19 Dec 2019 10:15:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so5880587wmj.4;
 Thu, 19 Dec 2019 07:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=aDN/8QLogsvpB8RT4DU3ZlP51/O9VN3A/bUrX47Un08=;
 b=BUGYZL5uwcup5EEh3283nGCyIm4cQ+nniFmsqQBaHDRm8kEbvgjKgn8HZoQ86jTXov
 pXSPuvrRZddsDyYdyVnp3Aekevbha8B71tJg0G5M6+8AyYHTFY83UCCuJ2sOiV1SaSY7
 S6c1AuyAr2IiQmv9jTuyryj21Z2wr3iZqEncbY/cQLUCcetyM09ldufrd9M3LAZaWbiQ
 WYHzFFwSUQahT1zYDXa8EdsxoouFNyV7OwejEAtrs8985II5HvcHtBqvQgcBzEqQJ8MY
 HYgGtLfJomFqyA+NtLrSej3m4+jPhdUNhlaogRIHojjacgISDPldDJzgSQ9pXytTC5pO
 mYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aDN/8QLogsvpB8RT4DU3ZlP51/O9VN3A/bUrX47Un08=;
 b=iIH2BbrK8j3n2twFiTMt6P5729j3nCNOhv71s+v9Stsaz4miBxpwAN6Tw0DKJnpSaQ
 WcUNGWFs4cX3yXkJOk/EcM+I2o5bufLnczQoTHuVG7cQUvxAX6CzejKHJdenSb2X2Jqm
 jKogh+CYgDg+AFDCssOycyyj23IwHASTEOlyy4BeRF3oWaUE2Y01TWp8aXRAAjA72lwY
 FjvaYsa/QoXlNUXImou+lXBU3wCI1U+p27dHlxQ1CuEIq+ZjRu9pivqYAuUH/ZZAI0Wm
 o1bY5/j/lpMwN+S5H7Ns/AIznNpwowCFfLJMZuUZf06SlSEq+qSVt2xSFm/L72WuPCvE
 7w5g==
X-Gm-Message-State: APjAAAW9zYmDi/kgGQ32/+4DR3bEfGTkKtFNM7FSa7dAVtLyfOug5H9v
 krQPKa0bS0TwsgVUH7ALeML4XUTC
X-Google-Smtp-Source: APXvYqwAOgMwb8N26v5U4/svUz3SI2TmUlu6eqG8orxN7/wvsbYgyv92Q+biSB1z1NVPWgqO39p5LA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr10606245wmm.70.1576768542832; 
 Thu, 19 Dec 2019 07:15:42 -0800 (PST)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id g21sm6989477wrb.48.2019.12.19.07.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 07:15:42 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Update Yuval Shaia's email address
To: Laurent Vivier <laurent@vivier.eu>, Yuval Shaia <yuval.shaia@oracle.com>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20191126102637.2038-1-yuval.shaia@oracle.com>
 <df5ed556-f636-0d8e-5882-89560e90e884@gmail.com>
 <cefbec21-8b62-f04d-f5ad-b211fa596569@vivier.eu>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9ac3330c-d2ff-beb2-dc5e-64172450eaf9@gmail.com>
Date: Thu, 19 Dec 2019 17:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cefbec21-8b62-f04d-f5ad-b211fa596569@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

On 12/19/19 11:46 AM, Laurent Vivier wrote:
> Le 18/12/2019 à 20:50, Marcel Apfelbaum a écrit :
>>
>> On 11/26/19 12:26 PM, Yuval Shaia wrote:
>>> Use gmail account for maintainer tasks.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>    MAINTAINERS | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5e5e3e52d6..4297b54fcb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2640,7 +2640,7 @@ F: tests/test-replication.c
>>>    F: docs/block-replication.txt
>>>      PVRDMA
>>> -M: Yuval Shaia <yuval.shaia@oracle.com>
>>> +M: Yuval Shaia <yuval.shaia.ml@gmail.com>
>>>    M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>    S: Maintained
>>>    F: hw/rdma/*
>> Hi,
>>
>> Can someone grab this patch ?
> I can take this in a trivial-branch PR, but the next one will not be
> before next week.
>

That is ok.

> Could you add your Acked-by?

Sure,

Acked-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>


Appreciated,
Marcel

> Thanks,
> Laurent


