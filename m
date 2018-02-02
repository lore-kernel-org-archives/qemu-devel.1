Received: from eggs.gnu.org ([2001:4830:134:3::10]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eheaX-0004aX-Ux
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eheZT-0006Gr-NL
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:53:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eheZT-0006F9-2B
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:52:15 -0500
Date: Fri, 2 Feb 2018 13:13:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180202131314.GF15403@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-12-berrange@redhat.com>
	<20180201204646.GK21702@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201204646.GK21702@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v5 11/14] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Miika S <miika9764@gmail.com>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Thu, Feb 01, 2018 at 06:46:46PM -0200, Eduardo Habkost wrote:
> On Tue, Jan 16, 2018 at 01:42:14PM +0000, Daniel P. Berrange wrote:
> > From: Miika S <miika9764@gmail.com>
> > 
> > keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana
> > 
> > Signed-off-by: Miika S <miika9764@gmail.com>
> 
> Oops, this conflicts with:
> 
> commit ae6b06ab655b21c19b234ce3422f694d11a013e0
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Wed Jan 17 16:41:18 2018 +0000
> 
>     hw: convert virtio-input-hid device to keycodemapdb
>     
>     [...]
> 
> Patch 11/14 and 12/14 need to be redone.  I'm removing patches
> 11-14 from python-next until this is sorted out.

You can literally just drop the patch chunk which touches
the hw/input/virtio-input-hid.c file entirely, as that table
is now auto-generated.  I can resend the series with that if
you prefer though ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
