Received: from eggs.gnu.org ([2001:4830:134:3::10]:44096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQxql-00058T-Dv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQxqf-0005GU-KN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQxqf-0005Fi-E6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:01:01 -0500
Date: Mon, 18 Dec 2017 11:00:59 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <180764363.27732961.1513612859884.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171218165346.1fe50257.cohuck@redhat.com>
References: <20171218140002.23677-1-cohuck@redhat.com>
	<151360760770.51.389844259110219934@5adcb62bf0d6>
	<20171218165346.1fe50257.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: no-reply@patchew.org, qemu-devel@nongnu.org, famz@redhat.com, stefanb@linux.vnet.ibm.com, marcandre lureau <marcandre.lureau@redhat.com>, thuth@redhat.com

> > ../hw/tpm/tpm_tis.o:tpm_tis.c:(.data+0x50): undefined reference to
> > `qdev_prop_tpm'
> > collect2: error: ld returned 1 exit status
> > Makefile:193: recipe for target 'qemu-system-x86_64w.exe' failed
> > make[1]: *** [qemu-system-x86_64w.exe] Error 1
> > make: *** [subdir-x86_64-softmmu] Error 2
> > Makefile:384: recipe for target 'subdir-x86_64-softmmu' failed
> 
> Seems we need to build tpm_util also when tpm_tis is built (and none of
> the others).

Or place the property in its own file.

Paolo
