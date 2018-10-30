Received: from eggs.gnu.org ([2001:4830:134:3::10]:44372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gHWRK-0001Sb-5P
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gHWRA-00053g-L7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:00:21 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:51387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gHWR9-0004t6-Lr
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:00:12 -0400
Date: Tue, 30 Oct 2018 17:00:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181030160009.faxqtyhssmous52t@function>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-2-git-send-email-max7255@yandex-team.ru>
	<20181027111141.tpzhv6xcrhxet6li@function>
	<4e542b8d-c273-c473-379c-887af2df6473@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e542b8d-c273-c473-379c-887af2df6473@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH RFC 1/4] slirp: add helper for tcp6 socket
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>
Cc: qemu-devel@nongnu.org

Maxim Samoylov, le mar. 30 oct. 2018 16:58:17 +0300, a ecrit:
> On 27.10.2018 14:11, Samuel Thibault wrote:
> > Is there a reason why you set SO_OOBINLINE, but not TCP_NODELAY? That's
> > the kind of discrepancy we don't want to let unseen, thus the reason for
> > a shared implementation :)
> 
> Actually my code was initially based on the last year master state, so I
> missed your changes on TCP_NODELAY while rebasing

Which shows why it's useful to share the code :)

Samuel
