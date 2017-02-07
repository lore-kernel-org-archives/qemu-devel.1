Received: from eggs.gnu.org ([2001:4830:134:3::10]:44497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9WI-0002Yx-Bq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9WH-0008La-7F
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:25:34 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9WH-0008IR-11
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:25:33 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so20618636wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:25:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E1cWIBq-0000iN-MH@clearmind.me>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-2-ale+qemu@clearmind.me>
	<CAFEAcA-52cjhLWWVGQ0qPeF3uKA67-ZBk=EQT2ARL1tjATWMkQ@mail.gmail.com>
	<E1cWIBq-0000iN-MH@clearmind.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:25:11 +0000
Message-ID: <CAFEAcA9QpTLgjnmmx4PmQni6zq8DC+OfAEs-Bk5f6h+0eUs1Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] Factor out {linux, bsd}-user/qemu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2017 at 07:38, Alessandro Di Federico
<ale+qemu@clearmind.me> wrote:
> On Tue, 24 Jan 2017 11:18:07 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> If we had more active testing of bsd-user I'd be a bit keener
>> about removing some of the code duplication.
>
> Currently, the code looks exactly the same to me. If we don't factor it
> out I'll have to make a third copy of it for libtcg, which is kinda
> annoying. I'm factoring out only a portion of the header, which
> probably doesn't change that much. If in the future there's some change
> we're not sure about we can keep it in the non-factored out part.

OK, fair enough.

Regarding whether the linux-* and bsd-* put_user are equivalent,
they should be; it's just that bsd-* doesn't get fixes that
we make to linux-* because it's unmaintained code.

thanks
-- PMM
