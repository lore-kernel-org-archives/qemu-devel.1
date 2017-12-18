Received: from eggs.gnu.org ([2001:4830:134:3::10]:57940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQue9-0004ce-9z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQue4-0006Oq-9b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eQue4-0006OY-3l
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:35:48 -0500
Date: Mon, 18 Dec 2017 13:35:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171218133538.398b77de.cohuck@redhat.com>
In-Reply-To: <deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
References: <20171218121635.25494-1-cohuck@redhat.com>
	<deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tpm: add stubs for qdev-prop-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org

On Mon, 18 Dec 2017 13:27:09 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 18/12/2017 13:16, Cornelia Huck wrote:
> > Building with --disable-tpm yields
> > 
> > ../hw/core/qdev-properties-system.o: In function `set_tpm':
> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined reference to `qemu_find_tpm_be'
> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined reference to `tpm_backend_init'
> > ../hw/core/qdev-properties-system.o: In function `release_tpm':
> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined reference to `tpm_backend_reset'
> > 
> > Add some proper stubs for those functions.
> > 
> > Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Maybe all the new code can be moved from qdev-properties-system.c to
> hw/tpm/qdev.c instead?  (Adding stubs should be the last resort,
> especially if the stubs are never used outside system emulation).

Probably hw/tpm/tpm-tis.c?
