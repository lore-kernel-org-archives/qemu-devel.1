Received: from eggs.gnu.org ([2001:4830:134:3::10]:56371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dII3F-0001Lk-7k
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dII3C-0004pN-4a
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dII3B-0004p4-WB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:13:50 -0400
Date: Tue, 6 Jun 2017 13:13:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606171349.GA6658@flamenco>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
	<CAJhHMCBkf7dhNJpZ37U5j3TfPqQPUOfYaE9=ZXeM1wsR3OWMBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhHMCBkf7dhNJpZ37U5j3TfPqQPUOfYaE9=ZXeM1wsR3OWMBA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jun 06, 2017 at 01:36:50 -0400, Pranith Kumar wrote:
> Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>
> 
> Thanks for doing this Emilio. Do you plan to continue working on rth's
> suggestions in that email? If so, can we co-ordinate our work?

My plan is to work on instrumentation. This was just low-hanging fruit;
I was curious to see the impact on cache miss rates of bringing the TB's
close to the corresponding translated code. Turns out it's pretty small
or my L1's are too big :-) The memory savings are significant though,
with the added benefit that this can enable more efficient translated
code as Richard pointed out.

I've just left a message on the GSoC thread with ideas.

		Emilio
