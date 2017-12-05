Received: from eggs.gnu.org ([2001:4830:134:3::10]:52471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM8nA-0006OH-GV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM8n5-0000d0-Ks
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 03:41:28 -0500
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
Date: Tue, 5 Dec 2017 09:41:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171201143136.62497-4-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On 01.12.2017 15:31, Halil Pasic wrote:
> With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict
> cssids") the s390-squash-mcss machine property should not be used.
> Actually libvirt never supported this, so the expectation is that
> removing it should be pretty painless.  But let's play nice and deprecate
> it first.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
[...]
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index db2351c746..874432d87c 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2501,6 +2501,14 @@ enabled via the ``-machine usb=on'' argument.
>  
>  The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
>  
> +@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)

The machine is called "s390-ccw-virtio", not "virtio-ccw". Anyway, I
think you could also rather omit the machine name here (since it is the
default) and just write "-machine s390-squash-mcss=on|off".

 Thomas
