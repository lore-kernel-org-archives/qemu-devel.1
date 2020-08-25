Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3410BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B7620782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR0JIcft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B7620782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaNH-000130-AH
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAaMG-0008Gk-GE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAaME-0001DB-0P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRsPOYfoYoLzWazF9cgUHeBpYzCQmCw4DsY5QEF1IvU=;
 b=CR0JIcftB5IRN/U5Th5ux0L+fBzzScqhV7+ow2bU8YTzqO5vLRJIEsVr8IYVeOG9kHIO9x
 Z9Ea4WtdLX/BEQ03OlwAEPC+zie2lHUhaQXq6wKVXvQKFN/f0JLs0aQsx5F6x+rWmXbxau
 rRHL7btebn8EXtrpC67G5puHSxaHh1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-WozOHy5cO0uC864z8gjd8A-1; Tue, 25 Aug 2020 10:55:23 -0400
X-MC-Unique: WozOHy5cO0uC864z8gjd8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC3A18BFEC0;
 Tue, 25 Aug 2020 14:55:22 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E8795D9CA;
 Tue, 25 Aug 2020 14:55:20 +0000 (UTC)
Date: Tue, 25 Aug 2020 15:55:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] nbd: build qemu-nbd on Windows
Message-ID: <20200825145517.GT107278@redhat.com>
References: <20200824170218.106255-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200824170218.106255-1-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 06:02:16PM +0100, Daniel P. Berrangé wrote:
> We are already building the NBD client and server on Windows when it is
> used via the main system emulator binaries. This demonstrates there is
> no fundamental blocker to buildig the qemu-nbd binary too.
> 
> 
> In testing this I used:
> 
>    wine qemu-nbd.exe -t -p 9000 demo.img 
> 
> and
> 
>    wine qemu-img.exe info nbd:localhost:9000
> 
> In fact I tested the full matrix of native vs windows client and native
> vs windows server.
> 
> I did notice that native qemu-img will sometimes hang when talking to
> the windows qemu-nbd.exe binary, and the windows qemu-img will almost
> always hang.
> 
> The hang happens in the "blk_unref" call in collect_image_info_list().
> This suggests something related to the socket teardown / cleanup in
> the NBD code.
> 
> While we should obviously investigate and fix that, I didn't consider
> it a blocker for enabling build of qemu-nbd.exe, since we're already
> building the same (buggy) NBD code in the system emulators on Windows.

After more debugging here's where it is getting stuck...

The main NBD client coroutine in qemu-img.exe is getting stuck in
nbd_read_eof() call where it has done qio_channel_readv() and got
QIO_CHANNEL_ERR_BLOCK. It has thus run qio_channel_yield(G_IO_IN)
and is waiting for that to return control, where upon it will exit
on EOF

Meanwhile the main qemu-img thread is in nbd_teardown_connection
having run qio_channel_shutdown(BOTH), and is now stuck forever in
BDRV_POLL_WHILE(bs, s->connection_co); waiting for the main NBD
coroutine to exit.


On native builds, we'll get G_IO_IN|G_IO_HUP in the coroutine after
calling the qio_channel_shutdown() in the main thread, and thus
the coroutine exits.

On windows builds running under Wine this doesn't seem to happen.
If I strace the wine program it does happen. IOW there's is some
kind of race condition wrt socket shutdown in QEMU when run in
Wine.

On windows builds running Windows Server 2008 r2, it appears to
work correctly. Maybe this is just luck, or maybe the bug really
is only affecting Wine. 

I don't intend to investigate this hang any more though, given
that it doesn't seem to reproduce in native Windows


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


