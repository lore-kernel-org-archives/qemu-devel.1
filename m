Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fExH2-00047U-7I
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fExGx-0002hA-B2
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:30:52 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fExGx-0002g9-2C
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:30:47 -0400
Received: by mail-lf0-x241.google.com with SMTP id b23-v6so34640587lfg.4
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 06:30:46 -0700 (PDT)
Date: Sat, 5 May 2018 15:30:43 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180505133043.lsjorp43en4dkj7m@toto>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-15-edgar.iglesias@gmail.com>
	<CAKmqyKM8REvf4oJSdcwhwU2iD_vGbQsZqPnZj1MeHBAEAiCGiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKM8REvf4oJSdcwhwU2iD_vGbQsZqPnZj1MeHBAEAiCGiw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 14/29] target-microblaze: Name special
 registers we support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 03, 2018 at 08:30:13PM +0000, Alistair Francis wrote:
> On Thu, May 3, 2018 at 2:28 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
> wrote:
> 
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> > Name special registers we support.
> 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >   target/microblaze/translate.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> > diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> > index c971fe3b72..57cd00ab3e 100644
> > --- a/target/microblaze/translate.c
> > +++ b/target/microblaze/translate.c
> > @@ -105,8 +105,8 @@ static const char *regnames[] =
> 
> >   static const char *special_regnames[] =
> >   {
> > -    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
> > -    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
> > +    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
> > +    "sr8", "sr9", "sr10", "rbtr", "sr12", "rbtr"
> 
> Hey Edgar,
> 
> Where do the two rbtr registers come from?

Thanks Alistair, sr13 should be redr. I've fixed it in v2.

Cheers,
Edgar
