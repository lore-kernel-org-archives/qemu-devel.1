Received: from eggs.gnu.org ([2001:4830:134:3::10]:57401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCIN-0000qm-N4
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCIH-0008Q6-UA
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxCIH-0008Pk-Nl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1D17129867
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 13:22:28 +0000 (UTC)
Date: Wed, 27 Sep 2017 14:22:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927132224.GK12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] scripts: Remove debug parameter from
 QEMUMachine
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

On Wed, Sep 27, 2017 at 10:03:39AM -0300, Eduardo Habkost wrote:
> All scripts that use the QEMUMachine and QEMUQtestMachine classes
> (device-crash-test, tests/migration/*, iotests.py, basevm.py)
> already configure logging.
> 
> The basicConfig() call inside QEMUMachine.__init__() is being
> kept just to make sure a script would still work if it didn't
> configure logging.

I don't find that compelling. IIUC, if we remove this basicConfig
they'll see a message that logging is not configured, which is a
suitable hint to fix the script to configure logging.

>  
>          # just in case logging wasn't configured by the main script:
> -        logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> +        logging.basicConfig()

So I'd just remove this line entirely


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
