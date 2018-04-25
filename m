Received: from eggs.gnu.org ([2001:4830:134:3::10]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fBHqR-0002h6-CD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fBHqO-0001Jq-3T
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:40:15 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <omer@kazuar-tech.com>)
	id 1fBHqN-0001Id-M4
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:40:12 -0400
Received: by mail-lf0-x22c.google.com with SMTP id r125-v6so24737126lfe.2
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 03:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
	<20180425095657.GF30024@redhat.com>
In-Reply-To: <20180425095657.GF30024@redhat.com>
From: Omer Katz <omer@kazuar-tech.com>
Date: Wed, 25 Apr 2018 10:39:59 +0000
Message-ID: <CAA-pg_oDCGqVDzk67Rw4mL83SexPbt1eZ8AoSMux9Xjda8nUFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Filtering files passing through MTP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

We're connecting USB drives that we want the guests to copy files from.
The user should only be allowed to copy certain files into the system.
The same thing goes for copying files to the USB drive. We only allow
certain files to be exported from the guest.

On Wed, Apr 25, 2018, 12:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Mon, Apr 23, 2018 at 03:10:32PM +0000, Omer Katz wrote:
> > Hi everyone,
> >
> > We have a use case that requires us to only allow certain files to pass
> > through to the guest machine from USB storage devices.
> >
> > I was told on IRC that such a feature does not exist but the easiest wa=
y
> to
> > achieve our goal is to contribute a patch the the MTP device driver sin=
ce
> > other drivers operate on a filesystem level instead of a file level whi=
ch
> > is what we need.
>
> IMHO the easiest way to stop the guest accessing files is to simply not
> put them in the directory that you are exporting the guest in the first
> place. If you have a directory that has some files you don't want accesse=
d
> and can't remove them, then perhaps create a second directory and use
> symlinks or hardlinks to pull in files from the original directory.
>
> > The plan is to pass the contents of each file to a program through stdi=
n
> > and decide based on the exit code if the file should be allowed to pass
> > through to the guest or not.
>
> I can't say I like this idea. It is a really very inefficient and heavy
> solution.
>
> > Since this is the first time I'm contributing to QEMU I'd like some
> > guidance to where the filtering code should be.
> > https://github.com/qemu/qemu/blob/master/hw/usb/dev-mtp.c doesn't look
> that
> > complicated but I still need to understand it better to continue.
> > Furthermore, I need to know where to add such a command line option to
> > point QEMU to the filtering program.
> >
> > Would such a patch be accepted if all the requirements above are met?
>
> Can you explain the usage scenario you have in more details, rather than
> just the high level abstract.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
