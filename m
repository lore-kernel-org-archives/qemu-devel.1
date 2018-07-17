Received: from eggs.gnu.org ([2001:4830:134:3::10]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPNX-0001dV-UQ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPNT-00053y-VQ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:46:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffPNT-00053g-P4
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44F2C81A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:46:51 +0000 (UTC)
Date: Tue, 17 Jul 2018 13:46:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717124646.GP18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717113402.5510-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/25] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Jul 17, 2018 at 01:33:38PM +0200, Juan Quintela wrote:
> If you don't want to compile everything, you configure
> config-devices.mak.  And then make clean remove it, and make will
> create a default one without your configuration.  Fix it by not
> removing it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 2da686be33..2ffbcde323 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -751,7 +751,7 @@ clean:
>  	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
>  	rm -f $$d/qemu-options.def; \
>          done
> -	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
> +	rm -f config-all-devices.mak
>  
>  VERSION ?= $(shell cat VERSION)

This feels wrong to me.  If 'make' is creating config-devices.mak, then
either 'make clean' or 'make distclean' must remove it. So if you remove
it here, it should be added to distclean instead.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
