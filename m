Received: from eggs.gnu.org ([2001:4830:134:3::10]:60117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj93D-00017Y-H8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj93B-0001qB-4A
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:32:35 -0500
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cj93A-0001o6-Lw
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:32:33 -0500
Received: by mail-lf0-x236.google.com with SMTP id a6so23445031lfa.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 10:32:32 -0800 (PST)
MIME-Version: 1.0
References: <05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
	<20170301181146-mutt-send-email-mst@kernel.org>
	<20170301163104.GJ10160@redhat.com>
	<20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301181117.GR10160@redhat.com>
	<20170301201347-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170301201347-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Mar 2017 18:32:19 +0000
Message-ID: <CAJ+F1CKM1JEqCv5mVUmP8E8WxEsjKY7zVTqqcTckvgmCDgmrEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH,
	CHING C" <cs1815@att.com>

Hi

On Wed, Mar 1, 2017 at 10:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:

>
> > You're also tieing the code
> > into the QEMU release cycle, again for no tangible benefit.
>
> No need for ABI stability would be the benefit.
>

We are talking about the control channel ABI (the data channel is using TCG
defined command streams afaict - don't remember what it is called)


>
> > Conceptually
> > swtpm does not depend on, or require, QEMU to be useful - it can have
> > other non-QEMU consumers - bundling with QEMU is not helpful there.
>
> Maybe it could but it isn't.
>

Right, it would be reasonable to have qemu provide it's own private "swtpm"
(linking with libtpms, doing most of the job), that way it wouldn't have to
rely on a stable ABI (as long as the process isn't shared across different
qemu versions, which should be quite easy to achieve)

>
> >
> > > I don't know what are the other options.  How is depending on an ABI
> > > with a utility with no other users and not packaged by most distros
> > > good? You are calling out to a CUSE device but who's reviewing that
> > > code?
> >
> > If anyone is motivated enough to review the code, they can do it whethe=
r
> > it is in QEMU git or its own git. Pulling entire of swtpm into QEMU GIT
> > isn't magically going to get useful reviews done on the code. The QEMU
> > maintainers already have far more code to review than available review
> > bandwidth, and lack domain knowledge in TPM concepts.
>
> I was the only one merging TPM code so far. I don't call myself an
> expert.  If someone steps up to do the work, is trusted by Peter to
> maintain it for X years and doesn't care about the extra hurdles, more
> power to them.
>

Why not give Stefan maintainership of TPM?

>
> > > Anyway, it all boils down to lack of reviewers. I know I am not mergi=
ng
> > > the current implementation because I could not figure out what do qem=
u
> > > bits do without looking at the implementation. I don't want to jump
> > > between so many trees and coding styles. bios/qemu/linux/dpdk are
> > > painful enough to manage. If some other maintainer volunteers, or if
> > > Peter wants to merge it directly from Stefan, I won't object.
> >
>

ok


> >
> > Regards,
> > Daniel
> > --
> > |: http://berrange.com      -o-
> http://www.flickr.com/photos/dberrange/ :|
> > |: http://libvirt.org              -o-
> http://virt-manager.org :|
> > |: http://entangle-photo.org       -o-
> http://search.cpan.org/~danberr/ :|
>
--=20
Marc-Andr=C3=A9 Lureau
