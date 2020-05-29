Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21AC20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avBuiXIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21AC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefx1-0003eq-Vo
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefWa-00020d-26
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:58:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefWZ-0006BJ-5t
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590760693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/x9tO4BQ7uwPwEwbV192uAZ4YFpLY/ahrULk+3N5Bw=;
 b=avBuiXIvNRbT8bX/eVdakc93kPwn0rnYchVrCHGZnAW6yONANh6hPGjhkJ5Uv+DI2l1ENl
 Ler/NWE/Bww+MRFLAE1sNopX6oJru5Uism9w4QYQy61W8gM0VqAjwsiDDI/oEXU+j+Qg54
 iw/ot36IgyR39vXKxn9F/M6tsz28G7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Edg8FJTbPtKek37W0wA_TA-1; Fri, 29 May 2020 09:58:12 -0400
X-MC-Unique: Edg8FJTbPtKek37W0wA_TA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B705EC1A8;
 Fri, 29 May 2020 13:58:11 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 646D65D9D5;
 Fri, 29 May 2020 13:58:07 +0000 (UTC)
Subject: Re: [Libguestfs] Provide NBD via Browser over Websockets
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <alpine.LRH.2.11.1810131833150.18520@mx.ewheeler.net>
 <CAMRbyytcufK8-XdFu7LU+UwO_FRoGJO2FhhBHtH9etf3A2htwQ@mail.gmail.com>
 <alpine.LRH.2.11.2005280014150.13970@mail.ewheeler.net>
 <20200528090443.GN7304@redhat.com>
 <alpine.LRH.2.11.2005282147410.13970@mail.ewheeler.net>
 <20200529093744.GS3888@redhat.com>
 <13571029-5bf4-2dfa-6879-0ad2642afb3f@redhat.com>
 <20200529135042.GJ2755532@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ff2e7dd1-c8b2-b46c-3c3b-ed88d9ad9689@redhat.com>
Date: Fri, 29 May 2020 08:58:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529135042.GJ2755532@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eric Wheeler <nbd@lists.ewheeler.net>, QEMU <qemu-devel@nongnu.org>,
 "Richard W.M. Jones" <rjones@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 nbd@other.debian.org, libguestfs <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 8:50 AM, Daniel P. Berrangé wrote:

>>> (2) You need to persuade qemu's NBD client to read from a WebSocket.
>>> I didn't really know anything about WebSockets until today but it
>>> seems as if they are a full-duplex protocol layered on top of HTTP [a].
>>> Is there a WebSocket proxy that turns WS into plain TCP (a bit like
>>> stunnel)?  Google suggests [b].
>>>
>>> [a] https://en.wikipedia.org/wiki/WebSocket#Protocol_handshake
>>> [b] https://github.com/novnc/websockify
>>
>> qemu already knows how to connect as a client to websockets; Dan Berrange
>> knows more about that setup.  I suspect it would not be too difficult to
>> teach the qemu NBD client code to use a WebSocket instead of a Unix or TCP
>> socket as its data source.
> 
> Actually the inverse. The QIOChannelWebsocket impl is only the server
> side of the problem, as used by QEMU's VNC server. We've never implemented
> the client side. There is nothing especially stopping us doing that - just
> needs someone motivated with time to work on it.

In the meantime, you may still be able to set up something like:

local machine:
iso -> NBD server -> Unix socket -> websockify -> WebSocket

remote machine:
WebSocket -> websockify -> Unix socket -> qemu NBD client

Adding websocket client support into qemu would reduce the length of the 
chain slightly (for less data copying) by getting rid of a websockify 
proxy middleman, but would not necessarily improve performance (it's 
hard to say where the latency bottlenecks will be in the chain).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


