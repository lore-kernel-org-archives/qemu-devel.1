Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9838C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D77206F8
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXbMB9Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D77206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdTh-00016D-1z
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdSS-0000DS-F1
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdSQ-0005YI-5p
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601715837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3qwDBSUCKcOdsyY4VUtj17ReaYlpeYSVwuyp9rd6fA=;
 b=UXbMB9LseuyCcCiiArTMRikKR2BmRcbsfbB2xCKvfFaPZ3ErtPKVQ7Yz48flAayYtdL7ad
 lZhXiinqs/Pgdyyc0QXcdj82ihYH3qkm7p7vX+17QHzITY+1lajl+zZhYJcxF2vKpbNAuH
 MfzwQAV5AtyMf5jtWb83bzpvjfFVtkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-31XqN88QMDGyvu6s6MjY-g-1; Sat, 03 Oct 2020 05:03:55 -0400
X-MC-Unique: 31XqN88QMDGyvu6s6MjY-g-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1579863wrw.22
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H3qwDBSUCKcOdsyY4VUtj17ReaYlpeYSVwuyp9rd6fA=;
 b=qfaYW3nHVMMW6ET15aN1Tm3fBmjyn3VGTdwRIYPuA2KSoMxFk6H65YspMtdGAdKIkR
 r7w54uCSYAd3YxVHJ9QF1WXUxTFhkxGonaPfG7nuUU1b6Pv5XycpmUo7jcTJ9dwwbhTE
 s8qMuiw4h/acdCRw9Rdzn8MRYsVSxLx5JM+AySddK3ALQToLVn2RRR7JAE8ID5eOYjK4
 zvsot60qajABu3FDqrDMY8MlbNtNFD5NmNgg8b0Eh9bKN42MVfnp9IN+jPta61AK5E+r
 XLTpQPIgCWESUErPTLQ5pyZ34RMt91J5hAwtryjwOGI+1fTnYFVBRdoJTSzIKRGIjuE5
 XOSw==
X-Gm-Message-State: AOAM532GBD33Zbk7LVqPq45wqeD+8pM8TOTNi1RZRhwyqHAayFpo7kOq
 jPzkAek/1pNTIp0pWmXRlf/ZDBolTWw9eVKxs52txZ+QPN+x6BPATzNRWQueD3N92Ymhq164Qyl
 kUsoknpNRGz7jYPk=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr6794759wmb.22.1601715834205;
 Sat, 03 Oct 2020 02:03:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMKDUhVKOAPGhmP5Rh9aOjaooyGJc9ERUMG4Kfzv/ljpsmHQTFwZVs2vzorBR+cWeGKPT2tQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr6794748wmb.22.1601715834005;
 Sat, 03 Oct 2020 02:03:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f6ef:6259:374d:b794?
 ([2001:b07:6468:f312:f6ef:6259:374d:b794])
 by smtp.gmail.com with ESMTPSA id i16sm4735653wrq.73.2020.10.03.02.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:03:53 -0700 (PDT)
Subject: Re: [PATCH 0/6] qom documentation fixes
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003025424.199291-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1a7c257-e8d5-87bb-a039-085e253dfc0a@redhat.com>
Date: Sat, 3 Oct 2020 11:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003025424.199291-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 04:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 04:54, Eduardo Habkost wrote:
> A few fixes to the QOM documentation in docs/devel/qom.rst and
> include/qom/object.h.
> 
> Eduardo Habkost (6):
>   qom: Fix DECLARE_*CHECKER documentation
>   docs/devel/qom: Fix indentation of bulleted list
>   docs/devel/qom: Fix indentation of code blocks
>   docs/devel/qom: Use *emphasis* for emphasis
>   docs/devel/qom: Remove usage of <code>
>   docs/devel/qom: Avoid long lines
> 
>  docs/devel/qom.rst   | 91 +++++++++++++++++++++++---------------------
>  include/qom/object.h | 16 ++++----
>  2 files changed, 55 insertions(+), 52 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

though see patch 5 for a small note that can even be fixed without a v2.

Paolo


