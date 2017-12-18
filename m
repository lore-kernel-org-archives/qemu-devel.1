Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQxjx-00084t-Sa
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eQxju-0006yx-QT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eQxju-0006yD-Kk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:54:02 -0500
Date: Mon, 18 Dec 2017 16:53:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171218165346.1fe50257.cohuck@redhat.com>
In-Reply-To: <151360760770.51.389844259110219934@5adcb62bf0d6>
References: <20171218140002.23677-1-cohuck@redhat.com>
	<151360760770.51.389844259110219934@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, thuth@redhat.com

On Mon, 18 Dec 2017 06:33:29 -0800 (PST)
no-reply@patchew.org wrote:

> ../hw/tpm/tpm_tis.o:tpm_tis.c:(.data+0x50): undefined reference to `qdev_prop_tpm'
> collect2: error: ld returned 1 exit status
> Makefile:193: recipe for target 'qemu-system-x86_64w.exe' failed
> make[1]: *** [qemu-system-x86_64w.exe] Error 1
> make: *** [subdir-x86_64-softmmu] Error 2
> Makefile:384: recipe for target 'subdir-x86_64-softmmu' failed

Seems we need to build tpm_util also when tpm_tis is built (and none of
the others).
