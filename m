Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A166BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758ED20989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758ED20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjvQ-0002vP-Mk
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:21:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOjuQ-0002Yy-7n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOjuO-0007J8-W2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:20:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOjuO-0007He-KX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:20:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAC9C3087BA9;
	Thu,  9 May 2019 14:20:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A005B687;
	Thu,  9 May 2019 14:20:15 +0000 (UTC)
Date: Thu, 9 May 2019 15:20:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190509142012.GZ31299@redhat.com>
References: <CAE519-nz3KE2GcQCj_4Ufs+ZR_jKwoMDpdrZS43bbZ_SxSjHeg@mail.gmail.com>
	<20190509134525.GD17133@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509134525.GD17133@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 09 May 2019 14:20:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question on QEMU : How to record debug log in VM
 of QEMU
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
Cc: qemu-devel@nongnu.org, S KH <sgh8183@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 02:45:25PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 07, 2019 at 11:29:03AM +0900, S KH wrote:
> > This is a question I have encountered while using QEMU.
> > 
> > I want to compile the source directly rather than through apt or yum and
> > install QEMU and input the output statement to the source to check the
> > output value.
> > 
> > When I compiled QEMU using dpkg-buildpackage in Ubuntu, I verified that
> > when QEMU's VM is executed by inputting and compiling the output statement,
> > the output value is recorded in the log file(ex.
> > /var/log/libvirt/qemu/win7.log) of that VM.
> > 
> > In Centos, I tried to use rpmbuild to input the output to QEMU source,
> > compile and check the output value. I confirmed that the log file is not
> > written, but I have confirmed that the output value is rare from the
> > terminal during the compilation process.
> > 
> > What I want to do is to get the output to be written to the log file like
> > in Ubuntu.
> 
> Try diffing /etc/libvirt/qemu.conf between the Ubuntu and CentOS hosts.
> Maybe they have different logging setups.  In particular, the
> stdio_handler setting might be different.

That shouldn't matter - regardless of which stdio_handler is in use,
the logs end up in the same file, with no buffering added by libvirt.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

