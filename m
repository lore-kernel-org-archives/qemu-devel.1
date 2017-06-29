Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhs2-0001ky-KR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhry-0002YG-LO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:25:06 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQhry-0002Y2-Gq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:25:02 -0400
Date: Thu, 29 Jun 2017 18:25:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629222501.GC9797@flamenco>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
	<149873913645.9180.8565004941097105027.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149873913645.9180.8565004941097105027.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v10 3/7] trace: [tcg] Delay changes to
 dynamic state when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jun 29, 2017 at 15:25:36 +0300, Lluís Vilanova wrote:
> This keeps consistency across all decisions taken during translation
> when the dynamic state of a vCPU is changed in the middle of translating
> some guest code.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  include/qom/cpu.h      |    3 +++
>  trace/control-target.c |   20 +++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
