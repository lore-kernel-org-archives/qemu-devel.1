Received: from eggs.gnu.org ([2001:4830:134:3::10]:57605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6jsz-0006fm-Tw
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6jsw-0007Dz-Pr
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:03:49 -0400
Date: Mon, 23 Oct 2017 22:03:42 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171023210342.GD18719@redhat.com>
References: <20171019075031.25507-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019075031.25507-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tpm: Don't call tpm_cleanup unless
 CONFIG_TPM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com


Since I posted this, there are more failures with --disable-tpm ...

  LINK    x86_64-softmmu/qemu-system-x86_64
../vl.o: In function `main':
/home/rjones/d/qemu/vl.c:4908: undefined reference to `tpm_cleanup'
../tpm.o: In function `qmp_query_tpm_types':
/home/rjones/d/qemu/tpm.c:230: undefined reference to `tpm_be_find_by_type'
../tpm.o: In function `qmp_query_tpm_types':
tpm.c:(.text+0x4a): undefined reference to `tpm_be_find_by_type'
tpm.c:(.text+0x7a): undefined reference to `tpm_be_find_by_type'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:193: qemu-system-x86_64] Error 1

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
