Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85BEC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4735F20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCJg1/Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeWg-0002g6-Ae
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKeVF-0001Nq-Gl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKeVD-0005Xz-Ku
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600766542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48Eoa1127Pec82xNNDopIsw1l4M1nsO0PB5x0FDZMqs=;
 b=WCJg1/Dt83qYU9OFS37Pp7Lb/YDI7/hw+WxJWjKqbCAMiD64VFMCSOz3kPrZ5hI1xBq/aY
 bHPvHRqv75Q1+phCyeJ6Swcd58s6U3DwZ3gSZMD6IXojCI/l7UJmN8j+g2eVnduUirDIbE
 eBjwwoJ6fSODkqduo/76Fm1h4ER+7jQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-PU-7NFdLPeC52cP2_iJ8sA-1; Tue, 22 Sep 2020 05:22:19 -0400
X-MC-Unique: PU-7NFdLPeC52cP2_iJ8sA-1
Received: by mail-wr1-f70.google.com with SMTP id a2so7128972wrp.8
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=48Eoa1127Pec82xNNDopIsw1l4M1nsO0PB5x0FDZMqs=;
 b=WbFBkBYiA3KDGbXNsNUW2FGzrWzQgn9t7lyXamCulKf0iRWyZV0uxz9i1IonJ8xTyi
 HPsgOXvuaVZzLEu+DUoOWLtF9fa4ZdccMHlpf0riix0blqpJ5tfQ/Yep70CV+gKUvyTz
 iTuAHhHTWCtW2egIFPsy9V+UzfomFOacwt6jPIbULV6uesVn8vWFilUMaVM53Zpche69
 o9kgXz/VufHrSqtPPxtAkFpPQ7iF+PbxrubQcedVUswDSAD1P2bIEp2KWNe7kF0yoHiQ
 uy/u2/jZDsVzkiRpbMLWs6WC0xaJYb4ujlYpkg0XyHCtQPnvdywveRa5C4HJmIKc1pcG
 DyOg==
X-Gm-Message-State: AOAM53327RmgO3A9WrCq98lJTRACGO6wa9vX7/O8Dgc+7oAkPJK2yfaR
 +yKtEQnOwYbDleQK1O3g/SJJtHg3kb3zp/DVPMbj7LlQTTSbnlczwGDdi4Roiy2nhdzDsW+/ny8
 ErO+Hzj0efWkhFtU=
X-Received: by 2002:a1c:e904:: with SMTP id q4mr3676451wmc.151.1600766537848; 
 Tue, 22 Sep 2020 02:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4THASh82r7EoBoA0W1fRsHeZbkOq9dk732BvBTLtBXcUW7J62CaNBNmElsH5o5L0CKd3wTA==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr3676434wmc.151.1600766537612; 
 Tue, 22 Sep 2020 02:22:17 -0700 (PDT)
Received: from [192.168.10.165] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id q186sm3663982wma.45.2020.09.22.02.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:22:17 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200914060109.69583-1-dovmurik@linux.vnet.ibm.com>
 <cc5a95d7-4efd-a3de-c1a2-0c77cb60c63a@redhat.com>
 <649cd6c5-7825-9373-4da0-7a28c3c97c8b@linux.vnet.ibm.com>
 <83728898-f305-d6df-f4ed-63580ff87eab@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d3d01a5-6c3b-7c0f-adce-cc0c452744a0@redhat.com>
Date: Tue, 22 Sep 2020 11:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <83728898-f305-d6df-f4ed-63580ff87eab@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 15:00, Philippe Mathieu-Daudé wrote:
>> That makes sense, except that 'last' statement which will escape the
>> loop if one of the bad patterns is found.
>>
>> Maybe we can just drop 'last' from both if-then blocks?  We'll get
>> multiple alerts if bad patterns are used more than once in the same
>> line, which sounds OK to me.
> No objection.
> 

Sounds good.

Paolo


