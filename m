Received: from eggs.gnu.org ([2001:4830:134:3::10]:47171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXFyT-0002RF-2j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXFyP-00022j-Tf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXFyP-00022M-LG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:45 -0400
Date: Mon, 17 Jul 2017 20:02:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718000244.GB30851@flamenco>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170711175937.23140-2-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] include/exec/exec-all: document
 common exit conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Tue, Jul 11, 2017 at 18:59:32 +0100, Alex Bennée wrote:
> As a precursor to later patches attempt to come up with a more
> concrete wording for what each of the common exit cases would be.
(snip)
> + * In these cases as long as the PC is updated we can chain to the
> + * next TB either by exiting the loop or looking up the next TB via
> + * the loookup helper.

'o' x 3

> + *
> + *   DISAS_UPDATE  - CPU State was modified dynamically
> + *
> + * This covers any other CPU state which necessities us exiting the
> + * TCG code to the main run-loop.

s/necessities/necessitates/

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
