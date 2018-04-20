Received: from eggs.gnu.org ([2001:4830:134:3::10]:43856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9cEk-0000sm-2Y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9cEh-0003Cw-1j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:02:26 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9cEg-00038M-SM
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:02:22 -0400
Date: Fri, 20 Apr 2018 16:02:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180420200220.GA517@flamenco>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
	<20180420183557.GA29359@flamenco>
	<9b39de2c-5682-bbbc-43f9-cc3397ea6e93@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b39de2c-5682-bbbc-43f9-cc3397ea6e93@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into
 normal code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Apr 20, 2018 at 16:11:35 -0300, Philippe Mathieu-Daudé wrote:
> On 04/20/2018 03:35 PM, Emilio G. Cota wrote:
> > I also changed the patches to make the series simpler: one patch
> > to add softmmu.c (without compiling it yet), one patch to
> > actually use softmmu.c, and a final patch to remove the template
> > file.
> 
> By "without compiling" you mean it is not compilable?
> That would mean not script-bisectable.

I mean it's committed but not yet buildable, i.e. makefiles
don't know anything about it. (So no, the build isn't broken.)

The point is to make the diff's as easy to review as possible.

> > The executable is now larger:
> 
> This is odd, I was expecting some shrinking...
>
> What kind of build are doing? More such -ggdb or such -O3?

I'm using the defaults.

Why would you expect a size reduction? With flatten we tell the
compiler to expand everything it can, so it makes sense that
it leads to larger code size vs. letting the compiler decide
what (or not) to inline.

Cheers,

		Emilio
