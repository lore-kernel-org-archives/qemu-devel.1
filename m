Received: from eggs.gnu.org ([2001:4830:134:3::10]:37005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcuHB-00056o-1r
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcuHA-0004DY-7j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:10:01 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:43669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcuHA-0004DK-2J
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:10:00 -0400
Received: by mail-oi0-x22d.google.com with SMTP id b15-v6so43210882oib.10
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 08:09:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710162208.7b1b5cdc.cohuck@redhat.com>
References: <20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 16:09:38 +0100
Message-ID: <CAFEAcA8AZK+Nsts2bPKAw-F=j5dFB0MBD5AO_9zf1ztbAYGWVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On 10 July 2018 at 15:22, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 10 Jul 2018 07:59:15 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> In addition to actively pulling libvirt developers into review of
>> deprecation patches, we should pursue the idea to optionally let QEMU
>> fail on use of deprecated features, then have libvirt run its test suite
>> that way.
>
> What about the following:
>
> qemu_deprecated_option("old_option", "modern_option");
>
> Which would then print (in normal operation)
>
> "WARNING: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
>
> to the monitor (or to stderr? to both?).
>
> If you start QEMU with a -no-deprecated-options switch, it would print
>
> "ERROR: 'old_option' is deprecated and will be removed; use 'modern_option' instead"

I'd prefer to see more hand-tailored deprecation messages that can
be more detailed about exactly what the new syntax needs to be.
The ideal would be if you could get right down to the detailed
level of "replace -old_thing -with_foo=x with -device new_thing,foo=x"...

thanks
-- PMM
