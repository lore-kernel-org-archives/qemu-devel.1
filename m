Received: from eggs.gnu.org ([2001:4830:134:3::10]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpFjM-0004sC-Fn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpFjH-0001V3-JG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpFjH-0001Um-D5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A9C62D59E2
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 15:25:30 +0000 (UTC)
Date: Tue, 5 Sep 2017 16:25:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170905152524.GF311@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170905151319.10756-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905151319.10756-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] buildsys: Move -lnettle and -lgnutls
 to per object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Sep 05, 2017 at 11:13:17PM +0800, Fam Zheng wrote:
> Not all targets need the flags and libs of nettle/gnutls, so move
> them out from global variables, as done with other libraries.
> 
> Fam Zheng (2):
>   buildsys: Move nettle cflags/libs to per object
>   buildsys: Move gnutls cflags/libs to per object

The same change for 'gcrypt' is needed

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
