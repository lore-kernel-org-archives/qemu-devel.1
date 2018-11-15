Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNI1R-0000nD-Lh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNI1L-0002zO-GS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:49:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNI1G-0002qT-Qt
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:49:20 -0500
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
	<292e35d1375b7bb87a641a8158a0e6e033070894.1542287931.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5d08c25-90a7-400b-b858-161925f855b9@redhat.com>
Date: Thu, 15 Nov 2018 07:49:01 -0600
MIME-Version: 1.0
In-Reply-To: <292e35d1375b7bb87a641a8158a0e6e033070894.1542287931.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/7] cpus: convert
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

On 11/15/18 7:22 AM, Simon Ruderich wrote:
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
