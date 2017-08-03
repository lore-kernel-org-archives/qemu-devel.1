Received: from eggs.gnu.org ([2001:4830:134:3::10]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGSm-0006mD-Kf
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGSj-0006qW-Nn
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:46:56 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:36613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGSj-0006og-KM
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:46:53 -0400
Received: by mail-qk0-x22e.google.com with SMTP id d136so7718930qkg.3
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 06:46:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
Date: Thu, 3 Aug 2017 10:46:47 -0300
MIME-Version: 1.0
In-Reply-To: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Greg,

On 08/02/2017 11:47 AM, Greg Kurz wrote:
> Building QEMU on fedora26 with the latest gcc package fails:
> 
>    CC      ppc64-softmmu/target/ppc/kvm.o
> In file included from include/sysemu/hw_accel.h:16:0,
>                   from target/ppc/kvm.c:31:
> target/ppc/kvm.c: In function ‘kvmppc_booke_watchdog_enable’:
> include/sysemu/kvm.h:449:35: error: ‘args_tmp[i]’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
>               cap.args[i] = args_tmp[i];                               \
>                                     ^
> target/ppc/kvm.c: In function ‘kvmppc_set_papr’:
> include/sysemu/kvm.h:449:35: error: ‘args_tmp[i]’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors

I'm trying to reproduce this in our docker images (all x86_64 based) but 
can't reproduce.

./configure shows:

KVM support       yes

but in "sysemu/kvm.h" CONFIG_KVM_IS_POSSIBLE is not defined

I can see CONFIG_KVM defined, but no NEED_CPU_H.

 >
 > $ rpm -q gcc
 > gcc-7.1.1-3.fc26.ppc64le

I don't have native ppc64le to build, do you know if it is possible to 
cross-compile enabling kvm? It seems I have the correct Linux headers, I 
wonder if this isn't a ./configure test which disable the kvm cross-build.

Regards,

Phil.
