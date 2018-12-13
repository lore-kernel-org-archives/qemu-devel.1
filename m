Received: from eggs.gnu.org ([2001:4830:134:3::10]:58856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXZFU-0002YE-Rh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXZFF-0001JW-Pk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:14:19 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:40080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gXZFB-0000uc-So
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:14:10 -0500
Received: by mail-vk1-f175.google.com with SMTP id v70so829087vkv.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
	<20181213140513.GD5427@linux.fritz.box>
	<CAMRbyytod-tELpdzmgp_mzwut=AuH4J1JsQ93QiFqz9RORV28g@mail.gmail.com>
	<ac589e0c-0294-8ce1-977b-eecdfea42eb8@redhat.com>
In-Reply-To: <ac589e0c-0294-8ce1-977b-eecdfea42eb8@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 14 Dec 2018 00:13:53 +0200
Message-ID: <CAMRbyyv5GE5EQ0e6DcHGdQWBTac+j6Rr2aVnAntoA_ri=Uojfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 11:27 PM Eric Blake <eblake@redhat.com> wrote:

> On 12/13/18 11:44 AM, Nir Soffer wrote:
>
> >> The things is, qemu-io was never meant to be used by other
> >> applications that need to process the results, it's a tool for testing
> >> and debugging. If we had meant it to be used by other programs, we would
> >> have given it a machine-friendly interface.
> >>
> >> The machine-friendly interface to the QEMU block layer is qemu-nbd.
> >>
> >
> > nbd is awesome, but much more complicated to use for testing. You need
> to:
> >
> > 1. start qemu-nbd
> > 2. wait until it is ready
> > 3. use nbd client (we have one now), or connect the qemu-nbd to
> /dev/ndbX,
> > which on
> >    Fedora 28 leaves stale /dev/nbdX devices after disconnection
> >    (I reported this few month ago here).
>
> Is that true even when you use 'qemu-nbd -d /dev/nbdX' after you are done?
>

It was true when I reported this here:
http://lists.nongnu.org/archive/html/qemu-block/2018-07/msg00168.html
