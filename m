Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73256C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD2F20735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8SXcfQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD2F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6zE-0004pD-G2
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jY6yY-0004Pi-TP
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:52:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jY6yX-0004IG-KC
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589197918;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z5FRk2Sm2l7dnzJKF3AK5SiJZPPrwM4iC2XyI0EVWCo=;
 b=c8SXcfQwWrvWSnA8viKvAPSvepbZq6VyJO4OI5X3WWK0r3I/xw15j3tsGBjfYew1b8CduI
 3Y5d5i/sgxe26xkNcfcZN3Znb+wJDnD7JfZ8MhycSu3J9H95l6wR5otUsxmNlTve5TXBDn
 VXLSu/+jDp/8mkBYQEi7sr/nEMs4Gik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-g8GSjqPMP3CjmUZMCdkQIA-1; Mon, 11 May 2020 07:51:56 -0400
X-MC-Unique: g8GSjqPMP3CjmUZMCdkQIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9265B800687;
 Mon, 11 May 2020 11:51:55 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6767049C;
 Mon, 11 May 2020 11:51:49 +0000 (UTC)
Date: Mon, 11 May 2020 12:51:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 2/5] io/channel.c,io/channel-socket.c: Add yank feature
Message-ID: <20200511115146.GK1135885@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <db00ff13f62fe97634132e43105b9bf63bbbf582.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <db00ff13f62fe97634132e43105b9bf63bbbf582.1589193717.git.lukasstraub2@web.de>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 01:14:41PM +0200, Lukas Straub wrote:
> Add qio_channel_set_yank function to channel and to channel-socket,
> which will register a yank function. The yank function calls
> shutdown() on the socket.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  Makefile.objs               |  1 +
>  include/io/channel-socket.h |  1 +
>  include/io/channel.h        | 12 ++++++++++++
>  io/channel-socket.c         | 29 +++++++++++++++++++++++++++++
>  io/channel.c                |  9 +++++++++
>  5 files changed, 52 insertions(+)

Assuming we want the yank feature (which I'm not entirely convinced
of), then I don't think any of this addition should exist. The
QIOChannel class already provides a "qio_channel_shutdown" method
which can be invoked. The layer above which is using the QIOChannel
should be calling this existing qio_channel_shutdown method in
response to any yank request.  The I/O layer shouldn't have any
direct dependancy on the yank feature.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


