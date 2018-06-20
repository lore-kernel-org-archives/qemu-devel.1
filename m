Received: from eggs.gnu.org ([2001:4830:134:3::10]:47843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVeKj-0005qn-Eb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fVeKg-0002Xf-B2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:41 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fVeKg-0002XK-17
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:43:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id e16-v6so201096wmd.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:43:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180620083459.GB3441@redhat.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
	<20180619134933.GY20929@redhat.com>
	<CAKPgXcHrZY1=65jOg3Y3bDdwNnik7x-Ti-3PAryYsRuvRWk=iA@mail.gmail.com>
	<20180620083459.GB3441@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 20 Jun 2018 17:43:36 +0300
Message-ID: <CAKPgXcHJCTKphNhp8gca46BTY-YJMkkXfVP59HjKDLjBxaAP4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>

On Wed, Jun 20, 2018 at 11:34 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com>
wrote:

> On Tue, Jun 19, 2018 at 05:37:10PM +0300, Sameeh Jubran wrote:
> > This patch is actually a preparation for an upcoming patch set that I
> want
> > to integrate into virtio-net which implements the RSS feature. (
> > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html)
> > So there is a use case. The rationale behind this is to distinguish the
> > infrastructure preparation needed for the BPF from the actual RSS featu=
re
> > implementation.
>
> Ah, so IIUC, that is not actually doing network filtering, rather it is
> some performance related feature than happens to make of use of BPF.
>
> I think it is be important to submit code changes for the virtio driver
> at the same time, so we can properly understand the interface and usage
> model exposed to the user CLI (if any).
>
I understand, but I thought about adding the bpf support in an elegant way
that might serve others in the future.

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>



--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
