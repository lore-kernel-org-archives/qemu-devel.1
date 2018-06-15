Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTlFG-0004Fi-DF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTlFD-0008Ey-8b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:42:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTlFD-0008ET-4b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:42:11 -0400
Date: Fri, 15 Jun 2018 10:42:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180615094207.GK31552@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-2-tamiko@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615044042.7928-2-tamiko@43-1.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

On Thu, Jun 14, 2018 at 11:40:41PM -0500, Matthias Maier wrote:
> This commit removes the PYTHON_UTF8 workaround. The problem with setting
> 
>   LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8
> 
> is that the en_US.UTF-8 locale might not be available. In this case

What platform are you using where  UTF8 locale is not available ?

Indeed I would ideally like to make the entire of QEMU build with an
explicit en_US.UTF-8 or C.UTF-8 locale, to ensure that we get reliably
reproducible builds, as locale differences have been known to impact
output of many tools not just python.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
