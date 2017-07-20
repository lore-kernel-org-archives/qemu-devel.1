Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dYB9I-0004VG-Il
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dYB9F-0000uZ-Q9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dYB9F-0000u2-Fz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:05:45 -0400
Date: Thu, 20 Jul 2017 15:05:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170720150537.1bf00f96@gondolin>
In-Reply-To: <1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
References: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
	<1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/cpumodel: remove KSS from the
 default model of z14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On Thu, 20 Jul 2017 13:27:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The SIE_KSS feature will allow a guest to use KSS for a nested guest.
> To create a nested guest the SIE_F2 facility is still necessary.
> Since SIE_F2 is not part of the default model it does not make
> a lot of sense to provide the SIE_KSS feature in the default model.
> Let's also create a dependency check.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_models.c   | 1 +
>  target/s390x/gen-features.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

I can either queue this; or, if you want to push this out as a fixup,
feel free to add

Acked-by: Cornelia Huck <cohuck@redhat.com>
