Received: from eggs.gnu.org ([2001:4830:134:3::10]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1csdU1-00011g-T9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1csdTy-0002V8-Rn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:51:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1csdTy-0002Te-Mi
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:51:26 -0400
Date: Mon, 27 Mar 2017 18:51:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170327225124.GA21029@flamenco>
References: <20170327131718.18268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327131718.18268-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: fix tcg tracing build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Mon, Mar 27, 2017 at 14:17:18 +0100, Stefan Hajnoczi wrote:
> Commit 0ab8ed18a6fe98bfc82705b0f041fbf2a8ca5b60 ("trace: switch to
> modular code generation for sub-directories") forgot to convert "tcg"
> trace events to the modular code generation approach where each
> sub-directory has its own trace-events file.
> 
> This patch fixes compilation for "tcg" trace events.  Currently they are
> only used in the root ./trace-events file.
> 
> "tcg" trace events can only be used in the root ./trace-events file for
> the time being.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Tested-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
