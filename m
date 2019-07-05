Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA1BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CC220989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CC220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPRe-0006pE-F4
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hjOxr-0006de-N1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hjOxo-0003GC-O2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:13:26 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1hjOxg-0002Cn-CH; Fri, 05 Jul 2019 10:13:17 -0400
Received: by mail-lj1-f177.google.com with SMTP id i21so9438538ljj.3;
 Fri, 05 Jul 2019 07:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UPStAOy1c+Ks51mTssOUmRiZpxgm477YKKndO49m8Jw=;
 b=LurpRwKd5ZB+WbArhzLGpuk89+BE2DMgFVPgdNsHXpbfqZ/p46YlZvUCr4fGWR+L02
 Qq1nVodyA3fRzDe04HyLWG5v+rB1SQ57uBJ2RLkHYVJlRUk/bKAyqZ9MXoSvyWAc6hGw
 9D/S7F9nU+vTyB2Zc04Lxrsgb4b4MVYZxyqnErnQ4Ydz3NEB7FBu+ToajZl+IHIyMaG1
 2XUJTgCwNmduvrmQDcgUIwYOSC865uXa+pl5CpBqyLgZRwqzqxmZVgZt+v2mIQwBWc30
 X1amNUQvKVdwL6wGP1l77QBfWa4y3NBBtBygPxRbVBVRMDzWZ9HD0ERFMfAt2ZKzjjoK
 sH3w==
X-Gm-Message-State: APjAAAU77IT1ySmoV22PwDohq6ulfVGcjUP+rkdut1fPzo7ofM+8nFmg
 t6Liz93ubAFAi/NgSYM24yU=
X-Google-Smtp-Source: APXvYqxU1K9B6OCjsLi8kvhUHY9DGcmuMG2PjhTTk7tMNXI3m+p4SmF8HPPAlgBKm4y09gJBlVN6CA==
X-Received: by 2002:a2e:981:: with SMTP id 123mr2405380ljj.66.1562335990140;
 Fri, 05 Jul 2019 07:13:10 -0700 (PDT)
Received: from [192.168.1.183] (95-28-29-40.broadband.corbina.ru.
 [95.28.29.40])
 by smtp.gmail.com with ESMTPSA id q6sm1808371lji.70.2019.07.05.07.13.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 07:13:09 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <fb3870a9-3802-41ce-7d26-d2be20f74c45@linux.com>
Date: Fri, 5 Jul 2019 17:13:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.177
X-Mailman-Approved-At: Fri, 05 Jul 2019 10:42:17 -0400
Subject: Re: [Qemu-devel] [QEMU-SECURITY] ide: fix assertion in ide_dma_cb()
 to prevent qemu DoS from quest
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
Reply-To: alex.popov@linux.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.07.2019 17:07, Alexander Popov wrote:
> This assertion was introduced in the commit a718978ed58a in July 2015.
> It implies that the size of successful DMA transfers handled in
> ide_dma_cb() should be multiple of 512 (the size of a sector).
> 
> But guest systems can initiate DMA transfers that don't fit this
> requirement. Let's improve the assertion to prevent qemu DoS from quests.

Hello everyone!

This bug was not considered as a security issue by QEMU security team, so I send
this patch to the public mailing list.

Best regards,
Alexander

