Received: from eggs.gnu.org ([2001:4830:134:3::10]:48499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5ssl-0000qJ-Jl
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5ssk-0003Fg-Iw
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:55:47 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5ssk-0003FI-BF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:55:46 -0400
Received: by mail-wr0-x241.google.com with SMTP id g12so22416884wrg.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 04:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
	<877f1zcjcf.fsf@dusky.pond.sub.org> <20170502163629.GA5640@work-vm>
	<20170502164838.GL16624@redhat.com>
	<1dda0b40-e473-638e-7a89-891f578d3186@openvz.org>
	<87shkm2n62.fsf@dusky.pond.sub.org> <20170503113507.GB3985@redhat.com>
In-Reply-To: <20170503113507.GB3985@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 11:55:34 +0000
Message-ID: <CAJ+F1CKghUBTeN4FNkqTwZ9MRKa5YQx4cBzTf4NRbqXBHezsHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Hi

On Wed, May 3, 2017 at 3:36 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Wed, May 03, 2017 at 01:29:57PM +0200, Markus Armbruster wrote:
>
> > The only difference to before that I can see is that we can read ahead.
> > That's a feature.
> >
> > Looks safe to me.  Opinions?
>
> Yes, I concur, it looks safe for QMP.
>
> I might suggest putting an assert(!qmp) in monitor_suspend() to guarantee
> no one accidentally introduces usage of the suspend feature in QMP in
> future.
>

fwiw, in the qapi-async series, I added a bunch of related assert:
https://github.com/elmarco/qemu/commit/48d0691fef7602b652b8e2a2a8c0c6665f8e=
7c14
--=20
Marc-Andr=C3=A9 Lureau
