Received: from eggs.gnu.org ([2001:4830:134:3::10]:49610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSJTb-0003zN-QU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSJTX-00080h-TJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSJTX-0007zz-Ne
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:23:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0FF9307CDF4
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:23:14 +0000 (UTC)
Date: Thu, 29 Nov 2018 10:23:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181129102308.GA25007@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181128113337.7238-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128113337.7238-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 0/5] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On Wed, Nov 28, 2018 at 12:33:32PM +0100, Juan Quintela wrote:
> - Finish tl trasport test
>   I already knew that I hate certificates, but this is too much.  Trying
>   to understand how to use them.

I'll happily contribute TLS tests on top of your basic series here
if you want. Just let me know...

If you prefer to try to do it yourself though, take a look at the
test-io-channel-tls.c  test which goes through the process of
creating certificates and loading the QEMU TLS credential objets

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
