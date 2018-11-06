Received: from eggs.gnu.org ([2001:4830:134:3::10]:39088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKAhE-0004Fs-Qs
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKASr-0000vh-Of
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:08:59 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gKASr-0000mg-6m
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:08:53 -0500
Date: Wed, 7 Nov 2018 00:08:50 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181106230850.66lufoxqwckxrzgt@function>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
	<20181106151323.16154-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151323.16154-4-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 3/4] slirp: Remove code that
 handles socreate() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

Peter Maydell, le mar. 06 nov. 2018 15:13:22 +0000, a ecrit:
> Now that socreate() can never fail, we can remove the code
> that was trying to handle that situation.
> 
> In particular this removes code in tcp_connect() that
> provoked Coverity to complain (CID 1005724): in
>  closesocket(accept(inso->s, (struct sockaddr *)&addr, &addrlen));
> if the accept() call fails then we pass closesocket() -1
> instead of a valid file descriptor.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied, thanks!
