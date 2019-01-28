Received: from eggs.gnu.org ([209.51.188.92]:58373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4v2-0003R8-Q7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go4v1-0000Hy-1B
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:17:36 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go4v0-0000Gh-S3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:17:34 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so14278410otl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20190125182626.9221-1-peter.maydell@linaro.org>
	<20190125182626.9221-6-peter.maydell@linaro.org>
	<CABoDooO-8HDMU6u_+JZHJRSvSCNp6bWewVoorX8_ekDRsyqtew@mail.gmail.com>
In-Reply-To: <CABoDooO-8HDMU6u_+JZHJRSvSCNp6bWewVoorX8_ekDRsyqtew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 11:17:21 +0000
Message-ID: <CAFEAcA9piu-pD1Y2MkD7jiPxc=TwWZO8d9yc2tdiXeMTY=mTzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm/translate-a64: Don't
 underdecode add/sub extended register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Mon, 28 Jan 2019 at 11:16, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
>
> On Fri, Jan 25, 2019 at 7:26 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > In the "add/subtract (extended register)" encoding group, the "opt"
> > field in bits [23:22] must be zero. Correctly UNDEF the unallocated
> > encodings where this field is not zero.
> >
> > Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/translate-a64.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> > index 2cade64ed25..efd2f6490b5 100644
> > --- a/target/arm/translate-a64.c
> > +++ b/target/arm/translate-a64.c
> > @@ -4204,12 +4204,13 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
> >      bool setflags = extract32(insn, 29, 1);
> >      bool sub_op = extract32(insn, 30, 1);
> >      bool sf = extract32(insn, 31, 1);
> > +    bool opt = extract32(insn, 22, 2);
>
> I'd prefer an int to a bool.

Oops, yes. I think I got mixed up with all the other bool
flags here, but it's a 2 bit field so definitely should be int.

thanks
-- PMM
