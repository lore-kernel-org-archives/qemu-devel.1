Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsnLJ-0008Mz-NR
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsnLG-0001Hk-7u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:59:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsnLG-0001GX-2j
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:59:54 -0400
Date: Thu, 23 Aug 2018 11:59:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180823105948.GI23703@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
	<CAFEAcA-jfnWjAA3zhUKZ2ZBJdD+JmndLgrigJnxuVFJN5e=pXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-jfnWjAA3zhUKZ2ZBJdD+JmndLgrigJnxuVFJN5e=pXg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 23, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
> On 23 August 2018 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> > In some cases the Author: email address in patches submitted to the
> > list gets mangled such that it says
> >
> >     John Doe via Qemu-devel <qemu-devel@nongnu.org>
> >
> > This change is a result of workarounds for DMARC policies.
>=20
> I do wonder if overall we'd be better off with the other
> workaround (don't change From lines in list emails, don't
> add "[Qemu-devel]" prefix to subject lines)... It would be
> a one-off annoyance to people who filter list mail on subject
> rather than other headers, but it would get rid of this annoying
> wart where a handful of senders end up with their mail with
> a from address that our patch management tools don't handle
> very well...

I kind of like seeing the qemu-devel prefix, since I don't tend to
pre-filter email into separate folders per list. I only do per-list
filtering (on headers) once at start of the day when reading the
overnight backlog. For rest of the day have a single inbox and tend
to rely on subject alone.

Of course the prefix isn't entirely reliable regardless, as if you
are CC'd on mails you'll probably see the copy delivered via the CC
long before you get the copy via the list.

AFAIK, the libvirt mailing list isn't mangling From lines, and it
also has a subject prefix added, so I wonder why it doesn't have
a need for the same workaround wrt DMARC ?  Or maybe it does need
it and we've never realized.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
