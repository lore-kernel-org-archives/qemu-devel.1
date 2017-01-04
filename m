Received: from eggs.gnu.org ([2001:4830:134:3::10]:33650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nathan@nathanrossi.com>) id 1cOo0N-0005s0-PI
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nathan@nathanrossi.com>) id 1cOo0H-0008WT-RS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:01:35 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nathan@nathanrossi.com>)
	id 1cOo0H-0008WM-NR
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:01:29 -0500
Received: by mail-qt0-x241.google.com with SMTP id w39so1138558qtw.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 08:01:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170104152731.GF10541@redhat.com>
References: <20170104145652.30442-1-nathan@nathanrossi.com>
	<20170104152731.GF10541@redhat.com>
From: Nathan Rossi <nathan@nathanrossi.com>
Date: Thu, 5 Jan 2017 02:01:28 +1000
Message-ID: <CA+aJhH3eimB=2+bu6UgkDprgL6fWueFTke8Ja2fSaVB8OODmPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: For libgcrypt if pkg-config is
 available use it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

On 5 January 2017 at 01:27, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Jan 05, 2017 at 12:56:52AM +1000, Nathan Rossi wrote:
>> If libgcrypt info is available with pkg-config use it over using the
>> libgcrypt-config. pkg-config is preferred due to is compatibility with
>> cross-compilation (where you cannot execute the targets version of
>> libgcrypt-config).
>
> It can be made to work, but you need to modify $PATH to ensure it finds
> the build target libgcrypt-config first.
>
> eg on Fedora you'd do this with mingw32
>
>    PATH=/usr/i686-w64-mingw32/sys-root/mingw/bin:$PATH ./configure ...
>
>> This change makes configure check for libgcrypt in pkg-config first,
>> then falling back to use libgcrypt-config if available. This follows a
>> similar process to how libsdl is handled.
>
> AFAIK, no version of libgcrypt has ever shipped a pkg-config file. Their
> maintainers have explicitly rejected patches adding that, ironically
> because they claim pkg-config doesn't handle cross-compilation and
> libgcrypt-config does :-)
>
> https://lists.gnupg.org/pipermail/gcrypt-devel/2007-February/001109.html
> https://lists.gnupg.org/pipermail/gcrypt-devel/2015-September/003569.html
>

Sorry for the noise. Turns out Yocto/OE patches support in to
libgcrypt for pkg-config, I did not realize (too many different things
in play :| ).

Regards,
Nathan

>
> So overall, I don't think this patch is needed/desirable for QEMU.
>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
