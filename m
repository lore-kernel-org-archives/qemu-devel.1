Received: from eggs.gnu.org ([2001:4830:134:3::10]:40074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkfjd-0000sy-0y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkfjb-0003CB-KG
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:15:29 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fkfjb-0003C3-Bt
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 21:15:27 -0400
Received: by mail-it0-x244.google.com with SMTP id h20-v6so7099048itf.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 18:15:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731155043.GK29167@redhat.com>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm>
	<87o9enqx4s.fsf@trasno.org> <20180731155043.GK29167@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 1 Aug 2018 09:14:46 +0800
Message-ID: <CAKXe6S+AyQyyOhwH4b5T+TE5x0_5zQ=KwOYUBwHMfGr3K-dFWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Add qmp command for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, liqiang02@corp.netease.com, Paolo Bonzini <pbonzini@redhat.com>, hzliuyingdong@corp.netease.com, rth@twiddle.net

2018-07-31 23:50 GMT+08:00 Daniel P. Berrang=C3=A9 <berrange@redhat.com>:

> On Tue, Jul 31, 2018 at 04:48:35PM +0200, Juan Quintela wrote:
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > * Li Qiang (liq3ea@gmail.com) wrote:
> > >> The default max cpu throttle is 99, this is too big that may
> > >> influence the guest loads. Add a qmp to config it can make it
> > >> more flexible.
> > >>
> > >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > >
> > > This should be done as a migration parameter rather than a new comman=
d.
> > > For example, follow the cpu-throttle-increment parameter; and this
> > > should work just like it.
> >
>


Hello all,

Thanks for your review. I will prepare another migration parameter version
patch set
for this.


Thanks,
Li Qiang

> I was about to comment this one.
> >
> > migrate_set_downtime, migrate_set_speed, migrate-set-cache-size,
> > query-migrate-cache-size are marked as deprecated.  Any way that we
> > could have make more clear that one should use
> > migrate_set/get_parameter/capability?
>
> Where are they marked as deprecated ?
>
They're not included in our official list of deprecated features, so per
> our deprecation policy, they are still considered supported.
>
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features


>
> To deprecate something it needs to be added to qemu-deprecated.texi, and
> ideally also made to print a message to stderr when triggered.
>
Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
