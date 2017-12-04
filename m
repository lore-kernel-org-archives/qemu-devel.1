Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLo3O-0007EK-T1
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLo3O-0006R7-5e
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:32:50 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:34060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLo3N-0006R0-VO
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:32:50 -0500
Received: by mail-ot0-x236.google.com with SMTP id o23so14290504otd.1
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 02:32:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204101636.GA11502@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
	<f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
	<48c19394-6a8d-e2c1-3380-7f27c2f63909@redhat.com>
	<20171204101636.GA11502@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 10:32:28 +0000
Message-ID: <CAFEAcA-M0m=FWYU4kZUrhsHUyCze+bz+GkcZctOrj3fyqD=KWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4 December 2017 at 10:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Yes, please!  __attribute__((cleanup)) is great and we should use it in
> QEMU.
>
> I haven't looked at compiler support though... :)

Looks like it came in in gcc 3.6, which is earlier than our earliest
required version. For clang, it's harder to say because the clang
documentation doesn't mention it at all, even though they actually
support it AFAICT from googling.

thanks
-- PMM
