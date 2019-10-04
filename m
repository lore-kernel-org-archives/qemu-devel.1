Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0BECE589
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E378C2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E378C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJ42-0002kt-Kk
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iGJ28-0001ON-Ip
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iGJ27-0008Fi-9H
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iGJ27-0008F4-3v
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:33:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FE34A44AFA;
 Fri,  4 Oct 2019 08:33:48 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF75360BE1;
 Fri,  4 Oct 2019 08:33:41 +0000 (UTC)
Date: Fri, 4 Oct 2019 09:33:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Subject: Re: Skip
 LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6 on
 32-bit hosts?
Message-ID: <20191004083237.GA25716@redhat.com>
References: <20191004052906.GC27597@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004052906.GC27597@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 04 Oct 2019 08:33:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-adding qemu-devel since it seems to have been Bcc'd.

On Fri, Oct 04, 2019 at 03:29:06PM +1000, David Gibson wrote:
> When I run make check-acceptance in a 32-bit (i686) container, this
> test fails, because it tries to start a guest with 4G of RAM, which
> can't fit in the userspace address space on a 32-bit host, obviously.
> 
>  (16/44) /home/dwg/src/qemu/tests/acceptance/linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6: FAIL: Regex didn't match: '.*initrd is too large.*max: \\d+, need 2147483648.*' not found in 'qemu-system-x86_64: -m 4096: ram size too large\n' (0.12 s)
> 
> Should we simply skip this test on 32-bit hosts?

There's a thread right now asking if we should drop support for 32-bit
hosts entirely

  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06168.html

I'm curious why you were testing with 32-bit host ? Do you have some
use case that needs it, or was this just responding to some user bug
report

As long as we do support 32-bit hosts though, this test definitely needs
fixing. It is attempting to boot with a 2 GB initrd, so I guess RAM
needs to be big enough to fit that & boot the guest OS image. Possibly
it might still work in 2.5-3.0 GB of RAM in guest if that's sufficiently
small for 32-bit host testing. If not, then skipping seems reasonable,
as no one will ever use such huge initrds on 32-bit hosts in real world.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

