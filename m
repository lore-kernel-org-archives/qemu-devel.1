Received: from eggs.gnu.org ([2001:4830:134:3::10]:55601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2wQX-0002jI-6X
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2wQT-00056s-0B
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2wQS-00055p-Py
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAEC4881D
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 09:06:22 +0000 (UTC)
Date: Tue, 25 Apr 2017 10:06:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425090618.GB21129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170424153615.18614-1-berrange@redhat.com>
	<8760htaqre.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760htaqre.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] crypto: move 'opaque' parameter to
 (nearly) the end of parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On Tue, Apr 25, 2017 at 09:30:13AM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > Previous commit moved 'opaque' to be the 2nd parameter in the list:
> >
> >   commit 375092332eeaa6e47561ce47fd36144cdaf964d0
> >   Author: Fam Zheng <famz@redhat.com>
> >   Date:   Fri Apr 21 20:27:02 2017 +0800
> >
> >     crypto: Make errp the last parameter of functions
> >
> >     Move opaque to 2nd instead of the 2nd to last, so that compilers help
> >     check with the conversion.
> >
> > this puts it back to the 2nd to last position.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> I could take this through my tree, but I suggest you stick it into your
> next crypto pull request.

Yes, I'll submit it myself as I have a bunch of other stuff pending.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
