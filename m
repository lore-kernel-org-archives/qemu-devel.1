Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B86C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6214D20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+xyAiO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6214D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9UFJ-0007jG-Ij
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9UD5-0003vj-0e
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9UD3-000508-8X
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:37:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9UD1-0004wE-OX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583329030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szksgriR2PczV19DSaTwRW+5lJXWlb+Zw9O3ByYy/P4=;
 b=A+xyAiO1gCFzM9sbZL7/3Z9ZwO4wIaTQKxSKFSPA+zalOBrH3kHoaqT+fEG8pNNQ100wHb
 WPbB9R6aKFpNZZFn0GVi5Dv80+CYl3ZvSwoDlrQovf8c9gUBSQanQJ/Wi9Z8iUAFTlqXiZ
 c7pcHh39T6WS0SKsVDN1HCveEsjg8ks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-s1W8Bd55M7aPNeKSAOo5Pw-1; Wed, 04 Mar 2020 08:37:08 -0500
X-MC-Unique: s1W8Bd55M7aPNeKSAOo5Pw-1
Received: by mail-wm1-f70.google.com with SMTP id d129so879532wmd.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 05:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=szksgriR2PczV19DSaTwRW+5lJXWlb+Zw9O3ByYy/P4=;
 b=lC6CEKBJEGdDRjOp8avysm6eu+bB6qGpRfQPGcwx+HY/41Gi8uBaZDNFITLfBr1X49
 2CfzWKOmWqJJleGT9VdzMKwtSsmOfYokrAN3iab8n9Mh8p2OS+dTrFAgK1/ZrUUi1+Uq
 WtRtiAg4alW+E81CQC1hWR7Ju+w2Nia8sjRI8g2BEOnbigO9e821bUedh4ptX1ybw9qG
 eWTYQDsCScjUgYSjZg4Kn+e2RXLyA9joAoPEPUb3K/SYFwXGe0YqJ9iC1zMgw9CZV10Z
 xfntzt3VuLNp00ReyDfTaoTuijZYoqlmApD301Qj9u2bPkUn0WPrr+am6j2IPlOfUd6I
 h7GA==
X-Gm-Message-State: ANhLgQ0rDbOgp5TCd5tBolia6kTuTWzbOQrYVrOw/6IvjW5CgYGjmyPb
 fjHKz51QmZUe9T2EdLs7ZKIm+3XEwne2FDm1bZ4+KcYtKg5DcWG0BTqaevWzpreveM8XRi/v80q
 c7wmT7odeHImCFN4=
X-Received: by 2002:adf:f343:: with SMTP id e3mr4136053wrp.402.1583329027131; 
 Wed, 04 Mar 2020 05:37:07 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs1Yh9bP2hy/Abu5UkkPnfsV6q97xsL0Qaluo4yXblECySqhzb8fMEQJaNlU1j8MMvnyV5jeA==
X-Received: by 2002:adf:f343:: with SMTP id e3mr4136031wrp.402.1583329026884; 
 Wed, 04 Mar 2020 05:37:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id v8sm4562427wma.28.2020.03.04.05.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 05:37:06 -0800 (PST)
Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
 <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
 <3049425105b94f6cb9cd846c84c95a84@intel.com>
 <783bac16-0e4d-f027-3e4a-b6fff500c244@redhat.com>
 <c6564993-ec06-7fe1-137d-956f3d554e74@intel.com>
 <679426098de74479a19c2287c68785c4@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <029efd6f-f461-da09-c6b6-1acf67818b64@redhat.com>
Date: Wed, 4 Mar 2020 14:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <679426098de74479a19c2287c68785c4@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 09:06, Zhang, Chen wrote:
>> Hi Eric and Paolo, Can you give some comments about this series?
>>
>>
> No news for a while...
> We already have some users(Cloud Service Provider) try to use is module in their product.
> But they also need to follow the Qemu upstream code.

My main comment about this series is that it's not clear why it is
needed and how to use it.  The documentation includes a demo, but no
description of what is an awd_node, a notification_node and an
opt_script.  I can more or less understand the notification_node and
opt_script role from the documentation, but not entirely because, for
example, the two-host demo has hardcoded IP addresses without saying
which host is which IP address.

The documentation does not describe the protocol, which is absolutely
necessary, and does not describe _why_ the protocol was designed like
that.  Without such documentation it's not clear if, for example, the
watchdog protocol could be implemented as QMP commands (e.g.
start-watchdog, stop-watchdog, notify-watchdog).  Another possibility
could be to use the systemd watchdog protocol, which consists of
essentially three commands (WATCHDOG=1, WATCHDOG=trigger,
WATCHDOG_USEC=...) which are transmitted as datagrams.  Documentation is
important for reviewers to judge the merits of the protocol without (or
before) diving into the code.

In the demo, the opt_script mechanism is currently using the "human"
monitor as opposed to QMP.  The human monitor interface is not stable
and not meant for consumption by management interface.  It is not clear
if this is just a sample usage, and in practice the notification_node
would be outside of QEMU, or not.  In general I would prefer to have the
script as an optional feature, and report the triggering of the watchdog
via QMP events.

Paolo


