Received: from eggs.gnu.org ([2001:4830:134:3::10]:33167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHji-0006IR-Jm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHje-0003cT-KD
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:17:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elHje-0003bQ-Fl
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:17:46 -0500
References: <20180212124008.8960-1-cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d369e62c-3fe6-060b-9e2a-6ae948d939dd@redhat.com>
Date: Mon, 12 Feb 2018 11:17:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180212124008.8960-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 02/12/2018 06:40 AM, Cornelia Huck wrote:
> Some pointers on how to get a patch into stable.
> 
> [contains some suggestions by mdroth]
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> RFC/D->v2: added mdroth's suggestions
> ---
>   docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>   create mode 100644 docs/stable-process.rst
> 

> +     Cc: qemu-stable@nongnu.org
> +
> +  to the patch description. By default, this will send a copy of the  patch

Spurious double space.

> +  to ``qemu-stable@nongnu.org`` if you use git send-email, which is where
> +  patches that are stable candidates are tracked by the maintainers.
> +

> +Stable release process
> +----------------------
> +
> +When the stable maintainers prepare a new stable release, they will prepare
> +a git branch with a release candidate and send the patches out to
> +``qemu-devel@nongnu.org`` for review. If any of your patches are included,
> +please verify that they look fine.

Maybe add: especially if the maintainer had to tweak the patch as part 
of back-porting things across branches.


>        You may also nominate other patches that
> +you think are suitable for inclusion. After review is complete (may involve
> +more release candidates), a new stable release is made available.
> 

What you have is an obvious improvement over the "nothing" that was 
before, so whether or not you fold in my additional comments, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
