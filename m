Received: from eggs.gnu.org ([2001:4830:134:3::10]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Uvj-0007du-N5
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Uvg-0008Rx-K7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:21:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5Uvg-0008Pk-EY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:21:12 -0400
Date: Tue, 2 May 2017 11:21:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170502102105.GH3459@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493719600-30853-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On Tue, May 02, 2017 at 12:06:40PM +0200, Thomas Huth wrote:
> The '-enable-...' option do not make too much sense: They do not
> allow additional parameters, using '-accel xxx' is shorter than
> '-enable-xxx' and we're also inconsistent here, since there is
> no '-enable-xen' option available. So let's try to convince the
> users to use '-accel xxx' instead.

What is our general approach to deciding which of our "legacy" parameters
are merely syntactic sugar for other parameters, vs stuff we want to
deprecate & eventually remove ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
