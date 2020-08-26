Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8561C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0232071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwnTv95D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0232071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAr3g-0005Kz-TF
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAr37-0004ur-L1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:44:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAr35-0001CI-OF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598431490;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cUZ0MZdDipPbWrS4uNtDj5PpuGn1UxYq6JXLkN5KTLg=;
 b=gwnTv95DvXpUpC4q6oR6twCfyaM65lwIgADS5L5p2sjUc6xGZq7TmW7OhUAlkczZRo1j27
 KRTqDRpYTRYsUnk2WxtvnMTt02mfKHYmC2KbFYka7SahdvGgwcwFU+hBC3mFsLSVzIBEE5
 QGfYlP+/ZAerTxkx3XF8cYkZBk2U6/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-Dzvd_I-TOTayTEO0TxaBXg-1; Wed, 26 Aug 2020 04:44:48 -0400
X-MC-Unique: Dzvd_I-TOTayTEO0TxaBXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE7FC64095;
 Wed, 26 Aug 2020 08:44:47 +0000 (UTC)
Received: from redhat.com (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 604BA7C5F6;
 Wed, 26 Aug 2020 08:44:45 +0000 (UTC)
Date: Wed, 26 Aug 2020 09:44:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: linux-user static build broken
Message-ID: <20200826084442.GH168515@redhat.com>
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:
> Hi,
> 
> since we have switched to meson, the statically linked binaries of qemu
> linux-user are broken:
> 
> cd $OBJ
> $SRC/configure --static --target-list=m68k-linux-user
> make
> ./qemu-m68k
> Segmentation fault (core dumped)
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7bd6833 in __dcigettext ()
> (gdb) bt
> #0  0x00007ffff7bd6833 in __dcigettext ()
> #1  0x00007ffff7bd5352 in __assert_fail ()
> #2  0x00007ffff7c4d74c in _dl_relocate_static_pie ()
> #3  0x00007ffff7bc713e in __libc_start_main ()
> #4  0x00007ffff7a0029e in _start ()
> 
> If I build with --disable-pie it works again.
> 
> Any idea?

I'd suggest checking the compiler args used with v5.1.0 vs git master
and see if any flags related to PIE or similar changed. I already found
one bug wrt PIE on Windows builds this way.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


