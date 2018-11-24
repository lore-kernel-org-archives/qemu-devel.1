Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLW7-0007N7-6Q
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLW1-0002PY-UE
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:09:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQLW1-0002LZ-P2
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:09:41 -0500
Date: Fri, 23 Nov 2018 19:09:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181124000938.GD17229@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-13-cota@braap.org>
	<871s7dhw8t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s7dhw8t.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 12/48] atomic_template: define pre/post macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Nov 22, 2018 at 17:12:34 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > In preparation for plugin support.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> More macros for the macro-god. I guess this works but I wonder if it's
> possible to do a clean-up ala softfloat and the experimental softmmu
> re-factor that makes this less a mess of macros?

Heh, point taken.

I'll try to fix this once (and if!) the series graduates from RFC
to proper patchset. BTW I'm planning to pick rth's softfloat
cleanup soon, so that should help.

Thanks,

		Emilio
