Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXAo-0002Mj-Tv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXAl-0004hX-LJ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXAl-0004gS-ET
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:40:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF7588C55B
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:40:05 +0000 (UTC)
Date: Thu, 28 Sep 2017 12:40:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928114000.GI12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927203225.30896-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 27, 2017 at 05:32:23PM -0300, Eduardo Habkost wrote:
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  This series cleans up the code, updates
> documentation, and document -nodefconfig as deprecated.
> 
> Eduardo Habkost (2):
>   vl: Eliminate defconfig variable
>   qemu-options: Deprecate -nodefconfig
> 
>  vl.c            |  5 +----
>  qemu-options.hx | 13 +++++++------

This must be listed in the qemu-doc.texi appendix to comply with
the deprecation policy

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
