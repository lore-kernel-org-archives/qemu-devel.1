Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF16C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C83021479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C83021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hbW-0003fL-Db
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7hSl-0001lK-2A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7hSj-00078X-KC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:49:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7hSj-00078A-CO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:49:45 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 926D68E580
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 14:49:44 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id t185so1456897wmg.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LXUokiAwo9tEofq5x7Uz+ACj4aJvsN1cqjWQzDZqSAE=;
 b=VmmtiHo1qvMSi5topC2+0CycM32bxbhKLpZ2TnhbWyRztQu4S8RRGLorrhYiQ/t5Y4
 4eSzbpHzhX44f6knEVck41JBra2jYHv+7EDlBxeCvK5sFpz0gAtX+rUknELNOUNePRuC
 KIZaPOU491t9vNiOZ6ZN/tr6EBsocgA+0qstevH2pNF/mc9Kcw3UxNEAAuRJujfJi/4y
 ApbZ9IPF7vLB+BGgo50aN+AnJxKJfAbmfHWWL96K56CWM+7VW+TJvNQYZRKPYHKHfVGC
 yVMUOCs0N7j9C75b9+h4r32LSYmKIRFToHpZibZR5Mc0N6cJ9CuIdw2R3qfICwNJ9O6O
 oJtg==
X-Gm-Message-State: APjAAAVb8mvdawvWavTfLFCsPiyE4g9SZfaCbttncpBRzSgMt836W8av
 GOKAW/gGxejIK3fV4H+QC8oO/xB8FXx7PtIpxtlMseQx/H+bea4dPKY+iahZo/O7kDupc9PTEvb
 OHvj1umN31X5UZ9o=
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr17683719wrp.58.1568126983243; 
 Tue, 10 Sep 2019 07:49:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwfFyvev7QJB4PenbcujZscB8izGxmfrSaBzqj3FDbvFB+3bjiMu20ls1aWqZBn1gMBt8AjQ==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr17683613wrp.58.1568126982116; 
 Tue, 10 Sep 2019 07:49:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q25sm3603612wmq.27.2019.09.10.07.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2019 07:49:41 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190825071541.10389-1-mlevitsk@redhat.com>
 <20190825071541.10389-3-mlevitsk@redhat.com>
 <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
 <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
 <58a0f856b958bcb90df6d5f778c8ca0eaefaf8f9.camel@redhat.com>
 <58a83617-9ffd-b775-976b-ccfbc87d65c1@redhat.com>
 <3967d83b-2637-8020-a3b6-f1fa995ad34f@redhat.com>
 <ad6938d5-0584-55bd-1eb3-1f04bafde126@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <363ba60f-3efd-b7fc-27ab-b3a864073686@redhat.com>
Date: Tue, 10 Sep 2019 16:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ad6938d5-0584-55bd-1eb3-1f04bafde126@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nvme: add support for discard
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 19:03, John Snow wrote:
> 
> 
> On 9/9/19 5:25 AM, Max Reitz wrote:
>> On 05.09.19 19:27, John Snow wrote:
>>
>> [...]
>>
>>> You also probably require review (or at least an ACK) from Keith Busch
>>> who maintains this file.
>>
>> Keith actually maintains the NVMe guest device; technically, Fam is the
>> NVMe block driver maintainer.
> 
> W h o o p s. Thanks for correcting me.
> 
> Well, if it's Fam -- he seems a little busier lately -- it's probably
> not so crucial to gate on his approval. I thought it'd be nice to at
> least get an ACK from someone who has used this module before, because I
> haven't -- I was just giving some style review to help push it along.
> 
> (On that note, if you felt like my style review was wrong or isn't worth
> doing -- it is always perfectly fair to just say so, along with some
> reason as to why you won't -- that way patches won't rot on the list
> when people may have gotten the impression that a V2 is warranted.)

Looks good to me with the changes you pointed out (especially res30;
leaving out the unused macros is not so important).

Paolo


