Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E346C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60AC2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtAaRTWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60AC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbm80-0004Bw-28
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbm7S-0003Ty-3j
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:24:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbm7R-0006ig-Bl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590071060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3n5camu2vTy8AoeCRgCA3pumHzNMzQABEKgM7+acVc=;
 b=JtAaRTWQV25+H+dSMzRb5FPadoKrz3wXz5F5DxwaBPkz86gD3FQjuHjdYoz2Oda6gp1zwb
 nQw8YhhwXGo+0UdrFUpsFyDZHLJzO9e5HMtbhrhyMl4RLE+kMXMNZSmczs55J5WmIMQO8S
 +ZLgo4q0d6Ll+6aXJa53ZoP+KuYMgxg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-ruZv7UicMvKpq9sRkgdCYw-1; Thu, 21 May 2020 10:24:16 -0400
X-MC-Unique: ruZv7UicMvKpq9sRkgdCYw-1
Received: by mail-wm1-f69.google.com with SMTP id o8so1039537wmd.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r3n5camu2vTy8AoeCRgCA3pumHzNMzQABEKgM7+acVc=;
 b=qzmqZRW6cKNlr7PoDDIasuNIDymYCBE6UOrJfmITDWFooXN7jfaDH4r2jayB4I0Bn4
 3UPbvjxICqvW9IDNR9r3Qevrc4VXbQvZEKRKnVaqAlTBT/V2+0TSxA+ZoZ+ZTMM+3OtZ
 YwE/q7RoF1yNJWPOahRYYIOWw9YOr2M8UTjHH+gFhiaXpxGUgfaiL1yMZZamTwP+mvhU
 xv8JnHSuWX5cHYrwqo7HdHA7xhKsC1SNEbEvZdTAKBhcmbJfbxk0fQXPHx51mQPTlINW
 liwA2kIYJqIWH1Y5Vb6XvI5Sg6ZaTdbSe4B08mxD8uDjRw5twt/NMvJo0gxVLcMZOFGO
 UWZA==
X-Gm-Message-State: AOAM533WNr2xxFxcXBgWEfqfjMROkQ7FbclayWo/7kHa7a19jEfBFJqW
 RphTzg2kU2b08ZNwCJjuS+St55IJEwtY6Mgs2OEHrZyKOVh2Hgj1HgI504sapQTQfkZwJEa82C1
 spKggF4XFX4MN80Q=
X-Received: by 2002:a1c:5402:: with SMTP id i2mr9838504wmb.185.1590071055746; 
 Thu, 21 May 2020 07:24:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFmFKdGMrESw2ueQQCNe0ifN+qu9jqAtZOw98ddEAV+rcvPQfKiHrIoTOZpRHRsfygqP9Y7g==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr9838488wmb.185.1590071055550; 
 Thu, 21 May 2020 07:24:15 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id f128sm7067932wme.1.2020.05.21.07.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:24:14 -0700 (PDT)
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200407114449.482532-1-clg@kaod.org>
 <87a72q6fi4.fsf@dusky.pond.sub.org> <20200507170611.GF2699@work-vm>
 <87h7wq2a8t.fsf@dusky.pond.sub.org> <20200520095920.GB2820@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c148331-78ae-31f7-8702-d65c37a090b0@redhat.com>
Date: Thu, 21 May 2020 16:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520095920.GB2820@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 11:59, Dr. David Alan Gilbert wrote:
>> Count me in favour.  I'd like to see the matching change to HMP qom-set,
>> though.
> It turns out I actually did do a JSON version, as the follow up to the
> version Cédric reposted; but then that got lost in people not liking
> JSON;   https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.html

Great.  I think we're in agreement then that making qom-get and qom-set
just take JSON is the best option.  So qom-get would be
"path:s,property:s" as in your patch, and qom-set would be
"path:s,property:s,value:S".

It is not a big deal to make this a backwards-incompatible change.

Paolo


