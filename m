Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e42PU-00049X-EA
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e42PR-00082O-9t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:14:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e42PR-000829-3Q
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:14:09 -0400
Date: Mon, 16 Oct 2017 11:14:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171016101402.GE17583@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
	<a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
	<1508139882.15782.2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508139882.15782.2.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Oct 16, 2017 at 09:44:42AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > By the way, looks like OpenBSD is also switching to clang by default
> > soon:
> > 
> > https://www.phoronix.com/scan.php?page=news_item&px=OpenBSD-Default-
> > Clang
> 
> It did happen already.  On openbsd 6.2 (released a week ago) cc is
> clang:
> 
> $ cc --version
> OpenBSD clang version 4.0.0 (tags/RELEASE_400/final) (based on LLVM
> 4.0.0)

Oh, I didn't notice that was out already. Lets drop my patch and I'll
update the BSD page on the wiki

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
