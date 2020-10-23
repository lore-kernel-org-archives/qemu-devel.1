Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10478C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A9E20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhTetiBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A9E20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0kg-0006KX-9H
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kW0jI-0004uY-9E
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kW0jF-0007oz-TD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603473588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oxql+6JwcZu4ZUdxGTeI5NLksjNTRzhz/K7SZzv6UTA=;
 b=PhTetiBepuI/N5dgeNGf1h1sehGxbZB9CxrDSwWUGkzIJVrHCzHfluT9soVk1XCsrLFDEg
 uevWfUjBDm+T7wurQNvv3M5Y66hyzjZNgXBukLcF2k4AXnxwnsQ1WgwGWFc8h7/kpfrxPT
 gCgoWXTuvAayXzCUD5bHE+uSh0eEOnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-w8UtTJRsOgC5-p8DpGpEOw-1; Fri, 23 Oct 2020 13:19:46 -0400
X-MC-Unique: w8UtTJRsOgC5-p8DpGpEOw-1
Received: by mail-wm1-f71.google.com with SMTP id r19so698744wmh.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 10:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Oxql+6JwcZu4ZUdxGTeI5NLksjNTRzhz/K7SZzv6UTA=;
 b=IsQ4GoP/HPT0Jvh3/VHeqwpiXRcqaBmmUd8SU3USEUhBhQem4hGhmAFvAJ93MelD8P
 tg0FdoX7YJ3YYJDd4aB5AsDuMP1FOkx2NGfjntAyHxsILLQ8nvu9cwaNxPdrbzL64QPF
 w/74rOSBAIUTqrXtvwxp4wHAF1fzD+bw6WlnWom6wVi/n4C13a4O5wt7qs3EVAyiYzhq
 ZYsFuwHQYqUtD0FHiF/el1WF5mqCM37pzT8OuFP7oCOGVjgYaTTC5foL9SyN1RjcpHHy
 nueb4bMbG/bLRQTVEPGPL68A1XVk1weJV/m5aNdLLJML5nB/kMt9XkFTndQ0QnmJ+Fgu
 9UmQ==
X-Gm-Message-State: AOAM532/FKrLT8C5+HWWjJKz3/60ZcROQI2741S7kD5tRPKPoK6tEPXU
 QyPLMkzjr2l8ZrH6Ew6f3WgefWFj6qBOZbpg0xyw5q2LUQLFr88RPPOw8H6jNKLpeKADoiTEnIF
 ruo49yOsILkqkdG8=
X-Received: by 2002:adf:8462:: with SMTP id 89mr3688405wrf.389.1603473585047; 
 Fri, 23 Oct 2020 10:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwarPEeiYzvQl6Js9jmyEcHLPk5hNfLjGrFAD/Wben9AC4OUmA65DA9QpLaL9WK2ZVThwEOow==
X-Received: by 2002:adf:8462:: with SMTP id 89mr3688391wrf.389.1603473584844; 
 Fri, 23 Oct 2020 10:19:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id 30sm4699568wrr.35.2020.10.23.10.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 10:19:43 -0700 (PDT)
Subject: Re: [qemu-web PATCH 5/7] Simplify and restructure the page footer
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-6-berrange@redhat.com>
 <54f37d84-a66e-bbfa-b410-2dba44d88ac9@redhat.com>
 <20201023164600.GC463062@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2879ebb5-8444-572f-4755-be4baf1a60b7@redhat.com>
Date: Fri, 23 Oct 2020 19:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023164600.GC463062@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 18:46, Daniel P. Berrangé wrote:
>> I would rather keep this column, the idea is that this information can
>> be found with a quick Ctrl-F "bug" or "Ctrl-F "faq".
>
> If there are useful links that are hidden such that people have to use
> "Ctrl-f <term>" to search for them, then I think we've failed at design
> already.

As you said the links are already mostly available from the "contribute"
page.  "Report a bug" is a bit of an in-the-middle case that is niche
enough that it should not be too prominent, but still worth being
available in the home page in some way.

> IMHO the front page has way too much real estate taken up with the
> screenshots and big headings, and very little useful content right
> now.

Yeah, that's true (that is something that was inherited from template I
used, which you can see for reference at https://templated.co/linear).

Paolo


