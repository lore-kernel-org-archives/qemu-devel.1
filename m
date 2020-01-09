Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96408C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECF620673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAzgNxqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECF620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipeFD-0001OV-Iq
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 15:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ipeEV-0000rm-96
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ipeET-0004TN-C4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:16:43 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ipeEQ-0004F2-He; Thu, 09 Jan 2020 15:16:38 -0500
Received: by mail-qk1-x743.google.com with SMTP id z14so7260314qkg.9;
 Thu, 09 Jan 2020 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DfqWjYtAmRErxA0AlXVYbWn7AgpBLe2HzbkgH8cJUq0=;
 b=dAzgNxqDMyM+ojkwfESj/H7rfcONYe69xzuRWWNReJXvAGHMqSd95iBlcFFh2DMY1L
 yXhtZiLeHOdi/ld+tvJoOe4NjmIwNwwPcdC4+SN0E0W8gwvgaqaBGKGZ0NK7nKWHvvP7
 XibzrvBigLHogjYgttetX5yyL7QGff4XT+69iZXQTgNq4RV2cT88nktKpawoQq8RAYXp
 TT43dY/P+ozM5ghG3f4SqyZJjSpUmGNFqAxpdtLyra7ynuIAQKroXzzYvhcLXq3z6Pf0
 GsyStwbxXVSgQosuZLoCH7Hv9PqxQQi43utt/xT9twkwuMuCiTUpARJbc3aJyPGwZGzW
 6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DfqWjYtAmRErxA0AlXVYbWn7AgpBLe2HzbkgH8cJUq0=;
 b=HUk/CkD0I9PJICSyIqEIMr/afe81rz+Mdc/iWz51OsbzsxErTmUcb2CK9+AjGKfSyR
 /9E2QWKbLsA3Bl403YiHoc5sn9UTdW/OLPVpPSkUDDiQrDSWQvi5cT4RJ7QiXVvwlt58
 LCDWmE7dJAiZWupT5fMmY2mkQykidWwRLIsjzvgzx7iyvN0JwGf7KYf+DSZXA5Jmpnb8
 twcmwOv+fj7xw97DAo2bCo5+J0A6fsupLUpGwnK3RX24FvK9NJgVHZbQ3RkxQ1lBy0ek
 iutJJZeWRFSDeUgOWNYb/zakTJwfl+8D1YMiWlQ5BpQaCfItj20CxJInx4/peLU9Wwmw
 K1EA==
X-Gm-Message-State: APjAAAV/DMRSXAo0tvS46ZWaidKFf0tgnWpwl9tNGiOPc06sUQdvbw7r
 rxhWyinZOR5bVxm5y5bgvRhdzFKG
X-Google-Smtp-Source: APXvYqzmJXlgDe9VWbI8l0nBrk+ydirrlKyS2KjiUsP3mTdp4pQEbRJzk5pRYmur6J+EDFmaC2l6zw==
X-Received: by 2002:a05:620a:6b8:: with SMTP id
 i24mr11583781qkh.9.1578600997710; 
 Thu, 09 Jan 2020 12:16:37 -0800 (PST)
Received: from ?IPv6:2804:431:c7c7:541e:7a5e:37ad:989b:4530?
 ([2804:431:c7c7:541e:7a5e:37ad:989b:4530])
 by smtp.gmail.com with ESMTPSA id z141sm3624466qkb.63.2020.01.09.12.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 12:16:37 -0800 (PST)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <d9e8e203-b529-1d1a-d8b9-5fd0fbe49e6b@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <9a4e7af7-3b59-1ec9-5342-a5d50559013b@gmail.com>
Date: Thu, 9 Jan 2020 17:16:32 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d9e8e203-b529-1d1a-d8b9-5fd0fbe49e6b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/7/20 6:43 AM, Max Reitz wrote:
> On 06.01.20 19:23, Daniel Henrique Barboza wrote:

[...]

  
> For me, it doesn’t require any brain cycles, because I generally just
> assume the cleanup label will do the right thing.  OTOH, a return
> statement may make me invest some some brain cycles, because maybe there
> is something to be cleaned up and it isn’t done here.
> 
>> Another common case uses a variable to set a return value,
>> generally an error, then return:
>>
>> if () {
>>      ret = -ENOENT;
>>      goto out;
>> }
>> [..]
>>   out:
>>      return ret;
>>
>> Likewise, it is clearer to just 'return -ENOENT' instead of
>> jumping to a label. There are other cases being handled in
>> these patches, but these are the most common.
> 
> I find it clearer from the perspective of “less LoC”, but I find it less
> clear from the perspective of “Is this the right way to clean up?”.
> 
> Even on patch 15 (which you say isn’t too much of a debate), I don’t
> find the change to make things any clearer.  Just less verbose.

Fair enough. As I said in the cover, all this patches makes no functional
changes, just a clean up aiming for less LoC (and more clarity, at least
in my opinion).

I am aware all the good sides of keeping the code as is, such as being
easier to debug (although I would argue that an explicit trace_event
call is better than keeping verbose code 'just in case'), or goto usage
to keep just one return statement per function.

I am also aware that the existing QEMU code base has a mesh of styles.
What I'm proposing here isn't a 'my way is better' case by any means,
but it's not something unprecedented in the existing code base either.
Since there's no QEMU code guideline imposing that a function should
have only one 'return' statement regardless of how many 'goto' calls
are needed, or a guideline that discourages 'goto' calls regardless of
how many 'return' calls are needed, in the end it's a matter of seeing
what fits the function/code better. In the maintainers opinion, of
course.


Thanks,


DHB


> 
> I suppose none of this would matter if we used __attribute__((cleanup))
> everywhere and simply never had to clean up anything manually.  But as
> long as we don’t and require cleanup paths in many places, I disagree
> that they require more brain cycles than plain return statements.
> 
> Max
> 

