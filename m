Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB82206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmzyqH4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB82206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVckT-00071n-Ev
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVcYg-0000ny-2e
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:59:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVcYe-0005GF-TB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588604339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afD5CDIuXr8nQJgoMOgjybbyyLq9lZ4Ok7wBpJono9o=;
 b=OmzyqH4magGU4Y8K3/yRifThTkivfxaEX9NtDNc76ko48UqA7qm14Zo2dGXckrtPutMTSo
 z3k++WSSIpb23ASWrrvhV7vmuyDHh01WPiksj4T+2ovM2Ksj2HaHpZs7UHjNPQHFD/DrgT
 qPWEwgmcP4Vqz+1i+oSpcG6ibMewq+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-unlLrXSnOa-rM5557PRZ_A-1; Mon, 04 May 2020 10:58:57 -0400
X-MC-Unique: unlLrXSnOa-rM5557PRZ_A-1
Received: by mail-wm1-f69.google.com with SMTP id s12so5045372wmj.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=afD5CDIuXr8nQJgoMOgjybbyyLq9lZ4Ok7wBpJono9o=;
 b=sepvPLFFxeZHViy4CqgE20STp+lpEqONRlh8jJXa/McetnByl+kpFIVVnBIvHy3SVU
 bMuPJqKWAiMWOS2KUKux7eQusHM86GHuKoDf1BIpaGDx2oRkgpd1P5iQiWBnyug6JCNz
 CYG8QnNTiHOHaK22tdTbnEQr7rm1Or1aBdUPG4mBbZo6jKYfXuZniMHd+/sQVVdWDngj
 yotgRHj2Td8NzwBmkFRoD7mwnTTyHb5Mfhvl3cM4H+hF+DJyR8YLODevvOiolAtTYtcN
 Ku2nF+7DXIT+sws4g0wCDI2TWGygY1NgBKXyjSnkujqdKkS4MmpeOASmbq3gu9f4TURE
 YZzQ==
X-Gm-Message-State: AGi0PuY9eghuTlx3YkCnqDxZuuy3W9c1ygPGIIQe+S5/yirGV6AzddKw
 pz/GFm3AMsdjBZ92BZu7bxj7EY7XHYsa8nB7K/CKjvDOqRvilrmv1+96KbUjP8gnZV1fPfqWWVR
 YJrFHb4YPvKg7bK8=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr15642304wme.79.1588604336234; 
 Mon, 04 May 2020 07:58:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUIPra+P8ZwVE63ETHbOIdXdVcJUWEg2ai76iMmiXOHTxRCsY50vabYxEktxyzNVxQxq2NiA==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr15642283wme.79.1588604336002; 
 Mon, 04 May 2020 07:58:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id y11sm18272252wrh.59.2020.05.04.07.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:58:55 -0700 (PDT)
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
Date: Mon, 4 May 2020 16:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87tv0vzrwj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/05/20 16:38, Markus Armbruster wrote:
> makes no progreess because OBJECT(dev)->parent is still null, and
> therefore object_unparent() does nothing.
> 
> Possible culprit: qdev_try_create() calls qdev_set_parent_bus(), which
> adds the device to the bus, but leaves ->parent null.  If this isn't
> wrong outright, it's at least a dangerous state.
> 
> Work-around: call qdev_set_id(dev, NULL) right after qdev_create().
> This sets ->parent.

That's a good one, and especially a safe one, since it matches
qdev_device_add.  It has the disadvantage of having to touch all
qdev_create() calls.

Even better however would be to move the bus argument (and thus
qdev_set_parent_bus) to qdev_init, and likewise in qdev_device_add move
qdev_set_id after qemu_opt_foreach.  I looked at the property setters
and couldn't find anything suspicious (somewhat to my surprise), but I
haven't honestly tried.

Paolo


