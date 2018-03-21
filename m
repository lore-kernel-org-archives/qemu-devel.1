Received: from eggs.gnu.org ([2001:4830:134:3::10]:36517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eylY7-00027B-De
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eylY4-0000ax-SF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:45:35 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eylY3-0000ZL-T5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:45:32 -0400
Date: Wed, 21 Mar 2018 17:45:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180321214530.GA4256@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-8-git-send-email-cota@braap.org>
	<b342cf3b-d594-9728-a12d-d5b8c7090e09@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b342cf3b-d594-9728-a12d-d5b8c7090e09@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v1 07/14] fpu: introduce hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, Mar 21, 2018 at 21:41:19 +0100, Laurent Vivier wrote:
> Le 21/03/2018 à 21:11, Emilio G. Cota a écrit :
> > diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
> > index ac61948..2868b11 100644
> > --- a/target/m68k/Makefile.objs
> > +++ b/target/m68k/Makefile.objs
> > @@ -1,5 +1,5 @@
> >  obj-y += m68k-semi.o
> >  obj-y += translate.o op_helper.o helper.o cpu.o
> > -obj-y += fpu_helper.o softfloat.o
> > +obj-y += fpu_helper.o softfloat.o hostfloat.o
> 
> I don't think you need to add hostfloat.o here,
> the softfloat.o in this list contains function specific to m68k
> emulation, it's not the one from fpu/

Aah yes indeed. Didn't consider there might be another softfloat.c =)

Thanks,

		E.
