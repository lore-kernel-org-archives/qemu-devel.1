Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C41C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BFC2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fruYPevj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BFC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYby-0000Oe-MF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtYZS-0006O7-3X
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:34:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtYZP-0003YJ-I0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594308881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUUZMKzG3HElZpaU5Bfc1hDOw6I1pjVK5k9m9qb3Gc0=;
 b=fruYPevjWZXneiDIyU1bSO0f3Kz8HnLNRq4dwz/TYv1FiRvxuPYM5dIhsUgcm8Dcq7O7nu
 7V1rBe1Uj3bQnEcGzeqzDTCvRpc72rvphCMU+xjP4EuRJB0qB0tXFcFuCHgMFmbzIclaRk
 1WGKSfc9hesq+rfLuomfkmJawDajU3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-phJc49R_PUiT1PrPoqi9pQ-1; Thu, 09 Jul 2020 11:34:34 -0400
X-MC-Unique: phJc49R_PUiT1PrPoqi9pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7751219057A2;
 Thu,  9 Jul 2020 15:34:33 +0000 (UTC)
Received: from [10.3.113.207] (ovpn-113-207.phx2.redhat.com [10.3.113.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BEDC5D9C9;
 Thu,  9 Jul 2020 15:34:29 +0000 (UTC)
Subject: Re: [PATCH 0/2] keepalive default
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200709083510.GF3753300@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <daa7864d-8979-1987-caf7-cca3cb9849ca@redhat.com>
Date: Thu, 9 Jul 2020 10:34:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709083510.GF3753300@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 3:35 AM, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 10:15:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> We understood, that keepalive is almost superfluous with default 2 hours
>> in /proc/tcp_keepalive_time. Forcing user to setup keepalive for the
>> whole system doesn't seem right, better setup it per-socket.
> 
> Adding the ability to explicitly configure the keepalive settings makes
> sense for QEMU. Completely ignoring system defaults when no explicit
> settings are given though is not valid IMHO.

We already have the ability to add per-socket keepalive (see commit 
aec21d3175, in 4.2).  I guess what you are trying to further do is 
determine whether the default value for that field, when not explicitly 
specified by the user, can have saner semantics (default off for chardev 
sockets, default on for nbd clients where retry was enabled).  But since 
you already have to explicitly opt-in to nbd retry, what's so hard about 
opting in to keepalive at the same time, other than more typing?  Given 
that the easiest way to do this is via a machine-coded generation of the 
command line or QMP command, it doesn't seem that hard to just keep 
things as they are with explicit opt-in to per-socket keepalive.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


