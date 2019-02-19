Received: from eggs.gnu.org ([209.51.188.92]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwA5G-0001nc-6b
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwA5F-0002Ci-FN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:25:34 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gwA5F-0002Bk-5A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:25:33 -0500
Date: Tue, 19 Feb 2019 13:25:28 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190219182528.GA19925@flamenco>
References: <20190215143115.28777-1-alex.bennee@linaro.org>
	<87d0nn6eoi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0nn6eoi.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH  v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

On Tue, Feb 19, 2019 at 14:22:37 +0000, Alex Bennée wrote:
> Emilio,
> 
> Any chance you could run it through your benchmark suite?

Something isn't quite right. For instance, gcc in SPEC doesn't
complete; it fails after 2s with some errors about the syntax of
the source being compiled. Before the patches the error isn't
there (the test completes in ~7s, as usual), so I suspect
some guest memory accesses aren't going to the right place.

I am too busy right now to try to debug this, but if you have
patches to test, I can run them. The patches I tested are in
your v3 branch on github, i.e. with 430f28154b5 at the head.

Thanks,

		Emilio
