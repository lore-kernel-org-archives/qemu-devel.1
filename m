Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60DE20709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/RD6ok1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60DE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5447-0006Tr-Q0
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k543X-00062M-NP
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:25:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k543U-00006f-VV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597051518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adicw9cHZDZ8SENuP3BJxYhqgAmhQ5Ad9MTRSQoe+/Y=;
 b=F/RD6ok1ebIFy+CSyYQ4q2JnaSZxKpi3o2exlXUo3vQ5YIvjlx732x9sOGtBQCNMMkT68E
 f7Nnrq7Ubeu6GcilAiJoBwYm6XQLeVeYgIWTjtBYnCMY92on8SVAaE/lh0eECu8Fn8xlZv
 ie+twAGxl6V1SKbwwnKqJrEIxGYbeOI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-24D8URe4Oqqlf5X4VMfF3w-1; Mon, 10 Aug 2020 05:24:59 -0400
X-MC-Unique: 24D8URe4Oqqlf5X4VMfF3w-1
Received: by mail-wm1-f70.google.com with SMTP id v8so2550822wma.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=adicw9cHZDZ8SENuP3BJxYhqgAmhQ5Ad9MTRSQoe+/Y=;
 b=PVJbM6Yg2HiVEleK/1hP8PtHh1AUL4yxQRI61BmGMlBPXpS7Bnbixu7F6opKLTlMhA
 xT/SyiZ/U71geCbibT61ckhoQMpgh26hjoYopiHbCAyvkrNjPDWtxq3ptleH5dU8ays7
 z19iGW4RZLdsYkGQI4PBTgWvHBMR5V4ptFIybStrUY5G3Y5eH5e6joTZAJNors45rgjQ
 bNoHMbnQV0mldlycwqTFhiu0LgxmoJOi4XicYBi/0er8X8kqrP7ce54VCkDIHXzizmjB
 loG5jJmNZhuDglwO+vXrg/RYQnIi3YxhcBDo/r+gJydlpzhgRClXMRus3K5XyBJQHoDr
 PqiA==
X-Gm-Message-State: AOAM532xeIEFJVNjRNwyfdAes7W/KFLyizin7SqSWR6VVkH6+GECdduu
 T13bOHK2153NMK2mxWc0PBZxbwr07kRgz5361DjGfd7JIvBcBwk6dxI0DsGM0+a709n/xool/ll
 OL92lliGp76tR+W4=
X-Received: by 2002:a5d:420b:: with SMTP id n11mr524940wrq.11.1597051497979;
 Mon, 10 Aug 2020 02:24:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqjZYOhdw+1DHoB/gOt2CIuon1/9zwpdokjmx8uFYQyiw2H2l9/HCfwgEgeF5/psOGcD5R3A==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr524924wrq.11.1597051497718;
 Mon, 10 Aug 2020 02:24:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id i82sm21267551wmi.10.2020.08.10.02.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 02:24:57 -0700 (PDT)
Subject: Re: [PATCH] acceptance: update asset hashes for the Bionic aarch64
 installer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200809223741.56570-1-pbonzini@redhat.com>
 <13b3586c-4d0e-76bc-4716-b6ee88e9686a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06ed9cc7-2204-395c-2395-d5c750c75635@redhat.com>
Date: Mon, 10 Aug 2020 11:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <13b3586c-4d0e-76bc-4716-b6ee88e9686a@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 11:06, Philippe Mathieu-Daudé wrote:
> The 'bug' is this link is using "current" which will be a problem each
> time Ubuntu update the installer (latest update was last Wed, Aug 5).
> 
> Acceptance tests should be stick to a particular set of binary, knew to
> have worked once in the past. If a new set works, I'd rather see a new
> test added (because it might have a different QEMU coverage).

That seems overkill but yeah the tests should have used
20101020ubuntu543.15 instead of current.  I think this should get into rc4.

Paolo


