Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5BEC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1FA2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLWUoh5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1FA2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7b2-0001lG-SW
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7YQ-00087L-Go
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7YO-00045Q-Sz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mccxb4QjTU5GxZJg4XGIJ14V+UUBEDIesBcZDT5nzRk=;
 b=MLWUoh5BZ5ZLHfs5Y7uIt9ZNa4GGsXx+egXyKSVDo6fqsm6ePQmG3607kQr4Xm9nDA0fWn
 HqdsH6iW6TPQf9SaHNPpfMvLeeYH+B5PmSyZERompCnUQZU20abXd0MN586VuQxCNyRDPF
 mk+T+EXxXc776tbuoOQPol+7GuQ6U0k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-P0PtpeDeOnWRW-MQxxvnFA-1; Mon, 09 Nov 2020 08:49:50 -0500
X-MC-Unique: P0PtpeDeOnWRW-MQxxvnFA-1
Received: by mail-wr1-f69.google.com with SMTP id e18so4342569wrs.23
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mccxb4QjTU5GxZJg4XGIJ14V+UUBEDIesBcZDT5nzRk=;
 b=Iks97Nokl0bYphXDkA+a7Pej1BJs63YI187QgEp4dYExfKxHpW5uJJp9NOWzW6b5Yd
 llz9yolSkBaWJW7bb2f68okjz1CjxCt0qQr6ncTEyojVaJOdgJTtI+LaIZs5Kwe2fW27
 POtpL4ouBvbEzqvLbGKBOhZfgSvYs4P21p8iUli9Po8mZOJi8DBNeJnw60bjQ9quBuhs
 WKzjD1zST8Lz0eus8w0MxtbUwC5QFhX6AQDTilASMEuwvuMUDU66Dj/hh7oZfTg2qaQs
 cLZLVnCOBFz5PL051YsD3j4EqCUI/1Vd34F810tL+AjC0kkas7C2w8CbGs0zncctJ7Ch
 5HDQ==
X-Gm-Message-State: AOAM532/HrVpEdBwau933yk/dOebJHQWzGmNwN88JZH8bp+UeY3pzPS7
 RXtdbxzyOACfM+ziImQY4XGphNV0YNhUZxFTJrmdz7kQihDf/cgQXysyS1Eq4GuH+C8FLNLL5Ix
 bpZ1ny1gUEe+LBQ0=
X-Received: by 2002:adf:d188:: with SMTP id v8mr17896385wrc.167.1604929788844; 
 Mon, 09 Nov 2020 05:49:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyO06CFaqF5YSSwOteZ711If8ldg3sTQwzcGXgU8+jqPb7k57aG9TtVFypy2NTuSAdoNFVP8g==
X-Received: by 2002:adf:d188:: with SMTP id v8mr17896366wrc.167.1604929788655; 
 Mon, 09 Nov 2020 05:49:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id k16sm7121537wrl.65.2020.11.09.05.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 05:49:47 -0800 (PST)
Subject: Re: [External] [PATCH 1/1] pvpanic: Advertise the PVPANIC_CRASHLOADED
 event support
To: zhenwei pi <pizhenwei@bytedance.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <1604346639-27090-1-git-send-email-alejandro.j.jimenez@oracle.com>
 <a595f137-b1d2-56b6-9391-f1c5c80beabf@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55ee6d1b-0211-43eb-be38-6c597a07146a@redhat.com>
Date: Mon, 9 Nov 2020 14:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a595f137-b1d2-56b6-9391-f1c5c80beabf@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 12:40, zhenwei pi wrote:
> Hi, Paolo
> 
> This patch seems getting ignored. Because no maintainers found for 
> hw/misc/pvpanic.c, I also send this to you(hope it doesn't disturb you).

Actually it needs compat stuff for old machine types.  I'll send v2.


