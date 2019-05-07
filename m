Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB02F20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB02F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNzgI-0003Gh-6w
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:58:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzfZ-0002xV-5S
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzfX-0006Ql-U3
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNzfX-0006PN-Mq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1896F307D85A;
	Tue,  7 May 2019 12:58:02 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2395560C43;
	Tue,  7 May 2019 12:57:59 +0000 (UTC)
Date: Tue, 7 May 2019 13:57:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507125756.GP27205@redhat.com>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1895198.u98Sn5qOsY@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1895198.u98Sn5qOsY@silver>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 07 May 2019 12:58:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 07:58:28PM +0200, Christian Schoenebeck via Qemu-devel wrote:
> This is the counter part patch against latest libvirt git master head to
> support the 'vii' feature of patch 5, which introduces the XML config
> XML tag "important" on libvirt side.
> 
> To stick with the previous example mentioned with patch 5, likewise
> libvirt XML configuration might then look like this:
> 
>   <domain type='kvm'>
>     ...
>     <devices>
>       ...
>       <filesystem type='mount' accessmode='mapped'>
>         <source dir='/vm/fs'/>
>         <target dir='root'/>
>         <important path='/var/shares'/>
>         <important path='/tmp'/>
>       </filesystem>
>     </devices>
>   </domain>
> 
> Like with the vii qemu virtfs command line argument, the order of the
> "important" tag defines which one gets the highest inode namespace
> (smallest generated suffix) on guest side.

Do we think anyone is likely to use this feature in the real world ?

I'm not really a fan of the representation, because this is affecting
guest ABI via a side effect of the ordering which is the kind of thing
that has got us in trouble before.  If we need control over the IDs
used for each mount point, then I tend to think we need to represent
it explicitly such that the mgmt app sets the exact ID used.

     <pathid dir="/var/shares" id="0x1"/>
     <pathid dir="/tmp" id="0x3"/>

this ensures that the IDs are still stable when adding or removing
paths


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

