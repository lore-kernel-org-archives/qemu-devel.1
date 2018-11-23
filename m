Received: from eggs.gnu.org ([2001:4830:134:3::10]:34749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQGDR-0003uE-1O
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQG2x-0008Kp-RB
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:19:20 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQG2x-0008Jg-H4
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:19:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so10620964oie.7
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
	<bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
	<20181123181638.GO18284@habkost.net>
In-Reply-To: <20181123181638.GO18284@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 18:19:07 +0000
Message-ID: <CAFEAcA8rcxJFtHxDJzcNurOoB7kAktNTFRbesy71Y=sEqsr5DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, 23 Nov 2018 at 18:16, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I think this is good enough for now (as long as there's a comment
> like Peter suggested).  Allowing parent_realize to be NULL would
> be inconvenient to all code that uses parent_realize today.
>
> Personally, I would love to get rid of parent_realize entirely.
> We could simply provide a helper to let device subclasses call
> the parent's realize function without the need to copy function
> pointers around.

Agreed -- parent_realize is a hack that is working around
a deficiency in our object model, and it would be nice to
deal with that. But let's do our cleanups one at a time :-)

thanks
-- PMM
