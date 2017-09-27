Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCDc-0006WL-TJ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCDT-0005pg-DD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxCDT-0005pQ-6l
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3327DC0641EA
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 13:17:30 +0000 (UTC)
Date: Wed, 27 Sep 2017 14:17:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927131726.GG12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] guestperf: Configure logging on all
 shell frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Wed, Sep 27, 2017 at 10:03:35AM -0300, Eduardo Habkost wrote:
> The logging module will eventually replace the 'debug' parameter
> in QEMUMachine and QEMUMonitorProtocol.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/migration/guestperf/shell.py | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
