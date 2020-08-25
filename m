Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24094C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19E6206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dx8IXna5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19E6206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgjR-0004rR-3b
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAgia-0003YY-1U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAgiX-0006xr-EA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598391775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpIpIgzeMd9jR3nmKiVH8lFFkJ9XeJyQdGtV2kpy7i8=;
 b=dx8IXna5jt0cjHblYxzLYNXmB9M3OdjYufY1n9enfN+Ed9CFjepxnq5AQrVRNj9Bud48r0
 /9RoG0TJdbkb6+w84CJhRI6/W3vqy8krBWB95ZcRmbPyQ08KjVmBeuRm63zASCSE3S5tIF
 kBR0+lm0x6UAJ0GMn8P+99qHrHUk1W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-xGtbMqBuN4yn4X4w3JoWlA-1; Tue, 25 Aug 2020 17:42:50 -0400
X-MC-Unique: xGtbMqBuN4yn4X4w3JoWlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FE4F1005E5B;
 Tue, 25 Aug 2020 21:42:49 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9AEA5D9D3;
 Tue, 25 Aug 2020 21:42:48 +0000 (UTC)
Subject: Re: [PATCH 1/4] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: luoyonggang@gmail.com, qemu-devel@nongnu.org
References: <20200825165341.520-1-luoyonggang@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <05e2badc-19b5-6f47-73f8-de30732fa236@redhat.com>
Date: Tue, 25 Aug 2020 16:42:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825165341.520-1-luoyonggang@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 17:42:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RGFuaWVsIFAgLiBCZXJyYW5n6IyF?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 11:53 AM, luoyonggang@gmail.com wrote:
> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> SIMPLE_PATH_RE should match the full path token.
> Or the $ and : contained in path would not matched if the path are start with C:/ and E:/
> ---

Missing a Signed-off-by tag.  Without that, we cannot apply it.

Also missing a 0/4 cover letter; less essential, but useful for 
continuous integration tools and for replying to the series as a whole.

More patch submission hints can be found at 
https://wiki.qemu.org/Contribute/SubmitAPatch

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


