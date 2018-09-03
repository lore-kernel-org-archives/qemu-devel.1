Received: from eggs.gnu.org ([2001:4830:134:3::10]:45595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwlQo-0007r1-Cd
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwlQm-0004R5-AA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwlQk-0004OE-EP
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9A1B804B9F1
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 09:45:54 +0000 (UTC)
Date: Mon, 3 Sep 2018 10:45:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903094550.GB3467@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180902175401.8195-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902175401.8195-1-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 0/3] Formatted INFO files to fit
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, stefanha@redhat.com

On Sun, Sep 02, 2018 at 08:53:58PM +0300, Yoni Bettan wrote:
> This patch make INFO files (e.g. README, CODING_STYLE and HACKING) much more
> readable when watched from GitHub GUI.
> 
> ./VERSION, ./MAINTAINERS were leave untouched otherwise
> ./scripts/get_maintainer.pl breaks.
> 
> ./COPYING, ./LICENSE ./COPYING.LIB were leave untouched because it look likes
> they come from GNU and not QEMU. 
> 
> Visualization of the change can be found at
> https://github.com/ybettan/qemu/tree/md.

As Peter mentioned on v1, QEMU has decided on using RST for docs, so I agree
with him that adding Markdown is not desirable.

As you can see from existing docs, GitHub knows how to display RST nicely
already:

  https://github.com/ybettan/qemu/blob/md/docs/pr-manager.rst

So if we did want to change these files, we should stick with RST.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
