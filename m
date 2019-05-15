Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43DCC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A785720815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQyLD-0006QN-VY
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 14:09:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQyIz-00058U-NZ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQy6u-0004ET-Ak
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:54:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQy6u-0004CT-5D
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50CF55D5FE;
	Wed, 15 May 2019 17:54:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F4965D9CC;
	Wed, 15 May 2019 17:54:33 +0000 (UTC)
Date: Wed, 15 May 2019 18:54:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <20190515175431.GM4751@redhat.com>
References: <7c80a63c-a7ce-1e83-650b-0b8343563127@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c80a63c-a7ce-1e83-650b-0b8343563127@profihost.ag>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 15 May 2019 17:54:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] cpu.fail / MDS fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 07:13:56PM +0200, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> i've updated my host to kernel 4.19.43 and applied the following patch
> to my qemu 2.12.1:
> https://bugzilla.suse.com/attachment.cgi?id=798722
> 
> But my guest running 4.19.43 still says:
> Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state
> unknown
> 
> while the host says:
> Vulnerable: Clear CPU buffers attempted, SMT Host state unknown

That suggests your host OS hasn't got the new microcode installed
or has not loaded it.

You want the host to report that it is Mitigated, and for the
host's /proc/cpuinfo to report "md-clear" exists.

> I expected the guest can use the new microcode.

You've not said what CPU model you've given to the guest.

You need either "-cpu host", or if using a named CPU model
you need to explicitly turn on the "md-clear" feature
(and all previous fixes)

   eg  "-cpu Haswell,+spec-ctrl,+ssbd,+md-clear"

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

