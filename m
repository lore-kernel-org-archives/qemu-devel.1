Received: from eggs.gnu.org ([209.51.188.92]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1VuP-0000pE-LW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1VuO-0007D3-T1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:44:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1VuO-0007CX-Md
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:44:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04CDF30917AB
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 12:44:28 +0000 (UTC)
Date: Wed, 6 Mar 2019 12:44:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190306124419.GG20806@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <32ad1a44-5398-53de-9adf-9e6ac9f60805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32ad1a44-5398-53de-9adf-9e6ac9f60805@redhat.com>
Subject: Re: [Qemu-devel] recursive submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Mar 06, 2019 at 01:30:06PM +0100, Laszlo Ersek wrote:
> Hi,
> 
> in order to build any OVMF platform firmware image from the submodule at
> "roms/edk2", the (recursive) OpenSSL submodule at
> "roms/edk2/CryptoPkg/Library/OpensslLib/openssl" needs to be initialized
> as well.
> 
> Am I right to think this would be the first recursive submodule in QEMU?
> How should I approach this? (I see we have a related script at
> "scripts/git-submodule.sh".)

The scripts/git-submodule.sh file is called automatically by "make"
in QEMU to activate any submodules that are required during the normal
build a QEMU developer does.

The ROM submodules are special though. AFAIK, these are never built as a
side effect of the QEMU build process, so never need to be initialized by
the git-submodule.sh script.  Developers always just use the pre-built
ROM files bundled in QEMU. The only people checking out the ROM submodules
are the maintainers who periodically build a new binary ROM.

So in this sense the fact that EDK has submodules shouldn't be a factor,
as we would not expect EDK to be built by regular QEMU developers

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
