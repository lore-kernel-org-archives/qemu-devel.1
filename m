Received: from eggs.gnu.org ([2001:4830:134:3::10]:38621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAI5T-0002JG-L2
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAI5Q-0008D0-Am
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:11:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAI5Q-0008CC-4Q
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:11:20 -0400
Date: Thu, 2 Nov 2017 16:11:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171102161103.GU32533@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509638660.11873.13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509638660.11873.13.camel@redhat.com>
Subject: Re: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Nov 02, 2017 at 05:04:20PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> One problem we have with the serial console support in seabios and
> sgabios:  It can happen that both are activated.  We'll go fix that in
> qemu, but that'll work for new qemu versions only, not for the old
> already released ones.
> 
> So I think it would be useful if seabios makes sure sgabios and serial
> console are not both active at the same time, i.e. in case we find
> "vgaroms/sgabios.bin" being present either turn off builtin serial
> console, or don't load sgabios (and possibly also enable builtin serial
> console).

Historically libvirt will always use '-device sgabios' if the user has
requested <bios useserial='yes'/>.  So if that -device arg is given, I
think QEMU must honour it, which implies QEMU must disable Seabios'
own built-in serial console impl in that scenario.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
