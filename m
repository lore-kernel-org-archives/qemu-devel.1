Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daLHe-0005hf-E0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daLHa-00021x-Ez
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daLHa-00020N-8z
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59EBA461FE
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:19:17 +0000 (UTC)
Date: Wed, 26 Jul 2017 13:19:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726121913.GJ7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170726114437.19624-1-pbonzini@redhat.com>
	<9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 26, 2017 at 01:57:35PM +0200, Thomas Huth wrote:
> On 26.07.2017 13:44, Paolo Bonzini wrote:
> > We don't want the page to become too long, but these are good suggestions.
> > 
> > Also tone down the sentence about using the latest release or latest git
> > tree, though we do prefer those.
> 
> Well, sometimes people still report bugs against QEMU 2.1 or so ... so
> I'd say everything that is older than the current version - 2 has a very
> high chance to be ignored completely. So maybe we should ask people to
> use at least one of the versions that is mentioned on the front-page of
> www.qemu.org ?

The biggest reason people would be using old versions of QEMU is if they
are running a distro's build. Such people should really file bugs in
their vendor's bug tracker, rather than against upstream directly.

IOW, it would be worth having a bit of text on the bug reporting page
to suggest people should preferrentially use their vendor's bug tracker,
if they are using a 3rd party build of QEMU.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
