Received: from eggs.gnu.org ([2001:4830:134:3::10]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqOPQ-0002Nu-5t
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqOPM-0007dS-VV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqOPM-0007dG-Qp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:58:12 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<07cfe62acc1e955eaa626096e86b848092391a64.1534409363.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42c4c8bc-14dc-2d33-a26c-1850b3ba97ea@redhat.com>
Date: Thu, 16 Aug 2018 14:58:11 -0500
MIME-Version: 1.0
In-Reply-To: <07cfe62acc1e955eaa626096e86b848092391a64.1534409363.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] cpus: convert
 qmp_memsave/qmp_pmemsave to use qemu_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

On 08/16/2018 04:01 AM, Simon Ruderich wrote:
> qemu_open() allow passing file descriptors to qemu which is used in
> restricted environments like libvirt where open() is prohibited.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>   cpus.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
