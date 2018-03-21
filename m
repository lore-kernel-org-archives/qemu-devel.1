Received: from eggs.gnu.org ([2001:4830:134:3::10]:43652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eykAN-0007SG-Tw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eykAM-0003Wp-Sg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:16:59 -0400
Date: Wed, 21 Mar 2018 16:16:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180321201651.GA32458@flamenco>
References: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
	<20180220210137.18018-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220210137.18018-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: use hardware sqrt if we can
 (EXPERIMENT!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Tue, Feb 20, 2018 at 21:01:37 +0000, Alex Bennée wrote:
> This is an attempt to save some of the cost of sqrt by using the
> inbuilt support of the host hardware. The idea is assuming we start
> with a valid input we can use the hardware. If any tininess issues
> occur this will trip and FPU exception where:
> 
>   - we turn off cpu->use_host_fpu
>   - mask the FPU exceptions
>   - return to what we were doing

Please see this thread for an alternative approach:

  [Qemu-devel] [PATCH v1 00/14] fp-test + hostfloat
  https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05908.html

		Emilio
