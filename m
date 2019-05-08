Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F84C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C94320578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C94320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJaF-0007hI-Ow
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:13:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOJZH-00079p-B3
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOJZD-0004Bs-B0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOJZB-00047F-9i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9454F30832E1;
	Wed,  8 May 2019 10:12:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 082BE600D4;
	Wed,  8 May 2019 10:12:35 +0000 (UTC)
Date: Wed, 8 May 2019 11:12:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org, S KH <sgh8183@gmail.com>
Message-ID: <20190508101233.GF32552@redhat.com>
References: <CAE519-=VsRtsLhd9T-RWSV-29yGz_0Zp7-TdMfXKcrV1wN0GWg@mail.gmail.com>
	<20190508091519.GD32552@redhat.com>
	<CAE519-niSfXffzKMY09_JJZ7q3KDRf+z-AU-XNeNqD=Z-DAeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE519-niSfXffzKMY09_JJZ7q3KDRf+z-AU-XNeNqD=Z-DAeoA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 08 May 2019 10:12:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question in QEMU : The result of printf does not
 appear in the qemu VM's log.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-adding qemu-devel - please don't take mailing list threads private.

On Wed, May 08, 2019 at 07:07:01PM +0900, S KH wrote:
> Hello.
> 
> Thanks to help, I can see the results of the output in the log file. Thank
> you very much for your help. I am currently working with the QEMU source as
> well as the SPICE source. After checking the source, I found that the QEMU
> source calls the SPICE function. So I used the 'g_printerr' function in the
> SPICE source to figure out the flow. Maybe it should be obvious,
> 'g_printerr' used by SPICE will not show in 'domain_name.log' file
> 'in/var/log/libvirt/qemu.' It may not be a good question for qemu-devel,
> but I wonder where the 'g_printerr' results from SPICE sources can be seen.

The SPICE server library is linked directly to QEMU so g_printerr should
work fine from SPICE code in the same way as QEMU code.  If you're not
seeing the results, then my guess would be that the QEMU you are launching
is not actually using the SPICE library you built with debugging. It is
probably still using the SPICE library from the OS distro. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

