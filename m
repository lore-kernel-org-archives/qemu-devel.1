Received: from eggs.gnu.org ([2001:4830:134:3::10]:36042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6GCo-00028V-Gi
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6GCl-0007ol-Cw
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:54:34 -0400
References: <20180411070418.6304-1-david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89ae5f83-ee3a-9d71-1f66-019821109c49@redhat.com>
Date: Wed, 11 Apr 2018 15:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180411070418.6304-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 for-2.13 0/2] Helpers to obtain host page
 sizes for guest RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/04/2018 09:04, David Gibson wrote:
> This series makes some small changes to make it easier to obtain the
> host page size backing given portions of guest RAM.  We use this in a
> couple of places currently, and I have one or two more to add in some
> upcoming code.
> 
> Assuming there are no objections, what should be the procedure for
> staging this?  Can I put it in my for-2.13 ppc tree, even though it's
> technically generic code, or should it go through someone else's tree?

Yes, go ahead:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
