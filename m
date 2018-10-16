Received: from eggs.gnu.org ([208.118.235.92]:57219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKWF-0005ZC-SA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKVP-0008S3-0r
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:15:59 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCKVL-0008Jh-66
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:15:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id w81-v6so17309305oiw.9
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 01:14:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181015180130.GO31060@habkost.net>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
	<CAFEAcA_H78rpT-9-M-NhTNXtMy8dpmC8_Yvb_4MyJ+GD8ZEptg@mail.gmail.com>
	<20181015180130.GO31060@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 09:14:37 +0100
Message-ID: <CAFEAcA_8AbfCJRO+1TvmDmOMMw_1LSKsLAT9+1pY9Nhy_Si74Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 15 October 2018 at 19:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Oct 15, 2018 at 05:55:27PM +0100, Peter Maydell wrote:
>> I also suspect "a few months" is an underestimate. My guess
>> would be we're going to want to keep Python 2 support for
>> at least the next year, maybe two.
>
> Python 2.7 will die in less than 15 months[1].  I really want us
> to stop reviewing and maintaining Python 2 code in QEMU in less
> than 1 year.  Preferably in less than 6 months.

Well, as with all our dependencies it depends on what the
default python is in the various LTS distro versions we
support. Once the last LTS distro with python 2 falls off
our this-is-what-we-support list we can drop 2 support,
possibly with a deprecate-and-warn-then-drop cycle.

thanks
-- PMM
