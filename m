Received: from eggs.gnu.org ([2001:4830:134:3::10]:43097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDOkD-0002E2-8C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDOk9-0004JO-UY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:58:49 -0400
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-49-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b76f9b0e-16f6-e51b-250b-4a0f3b71552c@redhat.com>
Date: Fri, 19 Oct 2018 08:58:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-49-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 48/56] ppc: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 19/10/2018 03:06, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/translate_init.inc.c | 77 +++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 4 deletions(-)
> 

Perhaps we should instead define both ->cpu_has_work and
->cpu_has_work_with_iothread_lock members, and move the generic
unlock/relock code to common code?

Paolo
