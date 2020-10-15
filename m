Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B082D212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjA8Ay50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B082D212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT0zC-0005gz-Nl
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT0xv-0005BP-V7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT0xu-00043Z-AJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 06:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602759513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4No85Jj2SZ683jwJCWX5QU30VjaXKkqLV0rjbpysuQ=;
 b=AjA8Ay50PiO5X/YAYA4rtBh/gO0rHH1+XDo9rXgcegr9dVZudcOvjgekZq4oLuQZActJzn
 o779CmlYckrT28MqxQgXn6Qm/Pq+VMHYsigD0ecMzuLVEfYmEuWf/6RakCZWwMOnwxQRHh
 k9yaMuEq/rS4Plank+6kjjTsrKyESc0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-To0eXT4wPzO5UUuIxKggwA-1; Thu, 15 Oct 2020 06:58:31 -0400
X-MC-Unique: To0eXT4wPzO5UUuIxKggwA-1
Received: by mail-wm1-f72.google.com with SMTP id r19so1602970wmh.9
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q4No85Jj2SZ683jwJCWX5QU30VjaXKkqLV0rjbpysuQ=;
 b=fuDWdeGs1nL6SolxbOfxdAsPFn7vFQTmZ6FmTuKKrTEt52qiELbOMVTpZpeiqPsIkt
 uWFNP8TLDN0SP6yG6flFbGfjl3b12xT7Wx19v5Zd8z9/gxeUoRFA0IZ4bsQMhjpVIKWG
 6X1WNVSbptYZXFxT5w1IlFTGdzdZPAluC/bZTQiVs/+oeeYRMsmDw3mV6B3EsjUZM4wT
 E1HsLrh97J18iC3kbRdxSCjRsjCRUHMiyXZTFZNPIOzUmj9R4A6IYwhWNjZ/jT7sq4yu
 wYZN17b0mv/NQyPzFN66xKQLuqP1nFCoXoZZiqB/BITXnY7aEUdpX6SmWQmUFptKTA+d
 m5Ww==
X-Gm-Message-State: AOAM533pMjSV29+x/Yd2UzUtdKwgS9j8MDRjKjvQ7CRJCQTXphfMJyEr
 dquf4KOXCG0dSaovattmSUWvguNZOPdwYwa7vclzoiSo1y/1k5ilOBq+f4peAFfP/YGM9ksPDUW
 a3xSLio00TT9230U=
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr3644784wra.348.1602759510129; 
 Thu, 15 Oct 2020 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsffZ7y4dl2eLaYk30rBgMJJkrpW2zGsSMvyP+NY5XIM/RlDYyRP7lW7/8azYPlQOfdpAh6w==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr3644762wra.348.1602759509952; 
 Thu, 15 Oct 2020 03:58:29 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d2sm4105511wrq.34.2020.10.15.03.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 03:58:29 -0700 (PDT)
Subject: Re: [PATCH] qemu-palcode: Changes to support booting NetBSD/alpha
To: Richard Henderson <richard.henderson@linaro.org>,
 Jason Thorpe <thorpej@me.com>
References: <20201007025229.7487-1-thorpej@me.com>
 <c35e151d-7b9c-849f-e4a0-a9c62d9a31a1@linaro.org>
 <6896C79F-8A9B-4EFC-BC68-EE8856EFD2B6@me.com>
 <709cbaaf-afe8-820c-9dd5-217bce626101@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6043a2a-c960-13d0-66cc-773a8f483496@redhat.com>
Date: Thu, 15 Oct 2020 12:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <709cbaaf-afe8-820c-9dd5-217bce626101@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 5:32 AM, Richard Henderson wrote:
> On 10/14/20 4:16 PM, Jason Thorpe wrote:
>>
>>> On Oct 14, 2020, at 2:52 PM, Richard Henderson <richard.henderson@linaro.org> wrote:
>>>
>>> I'm certainly open to these changes.  But it'll need to be split up -- one
>>> patch per bullet, basically.
>>
>> That's fine.  What's the convention for patches that stack on top of one another?
> 
> git format-patch --cover-letter
> git send-email --thread --no-chain-reply-to

Alternatively git-publish:

https://github.com/stefanha/git-publish


