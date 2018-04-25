Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBHAm-0007Br-8y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBHAj-0004qR-LI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:57:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBHAj-0004q8-H0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:57:09 -0400
Date: Wed, 25 Apr 2018 10:56:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180425095657.GF30024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
Subject: Re: [Qemu-devel] Filtering files passing through MTP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Omer Katz <omer@kazuar-tech.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Apr 23, 2018 at 03:10:32PM +0000, Omer Katz wrote:
> Hi everyone,
> 
> We have a use case that requires us to only allow certain files to pass
> through to the guest machine from USB storage devices.
> 
> I was told on IRC that such a feature does not exist but the easiest way to
> achieve our goal is to contribute a patch the the MTP device driver since
> other drivers operate on a filesystem level instead of a file level which
> is what we need.

IMHO the easiest way to stop the guest accessing files is to simply not
put them in the directory that you are exporting the guest in the first
place. If you have a directory that has some files you don't want accessed
and can't remove them, then perhaps create a second directory and use
symlinks or hardlinks to pull in files from the original directory.

> The plan is to pass the contents of each file to a program through stdin
> and decide based on the exit code if the file should be allowed to pass
> through to the guest or not.

I can't say I like this idea. It is a really very inefficient and heavy
solution.

> Since this is the first time I'm contributing to QEMU I'd like some
> guidance to where the filtering code should be.
> https://github.com/qemu/qemu/blob/master/hw/usb/dev-mtp.c doesn't look that
> complicated but I still need to understand it better to continue.
> Furthermore, I need to know where to add such a command line option to
> point QEMU to the filtering program.
> 
> Would such a patch be accepted if all the requirements above are met?

Can you explain the usage scenario you have in more details, rather than
just the high level abstract.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
