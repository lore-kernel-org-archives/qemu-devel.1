Received: from eggs.gnu.org ([209.51.188.92]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjpyX-0002vD-EM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjpyW-00072A-Ma
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjpyU-0006yS-Ic
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:40 -0500
References: <20190116174941.342900-1-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
Date: Wed, 16 Jan 2019 19:31:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190116174941.342900-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Eric Blake <eblake@redhat.com>

On 16/01/19 18:49, Stefano Garzarella wrote:
> This patch series is based on "[PATCH v3 0/4] QEMU changes to do PVH boot" and
> provides a PVH option rom that can be used with SeaBIOS to boot uncompressed
> kernel using the x86/HVM direct boot ABI.
> 
> Patches 1 and 2 are to prepare the PVH option rom, moving common functions in
> the new headers.  Patch 3 adds the new PVH option rom. Patch 4 uses it when we
> are booting an uncompressed kernel using the x86/HVM direct boot ABI. Patch 5
> adds the support of loading the initrd in the PVH option rom.
> 
> Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>

I get this:

  CC      optionrom/pvh_main.o
/tmp/ccoel69H.s: Assembler messages:
/tmp/ccoel69H.s:171: Error: attempt to move .org backwards

when applying this series on CentOS 7.

Paolo
