Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciMpJ-00045L-Rw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciMpJ-0002XC-0n
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:03:01 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciMpI-0002W9-Rm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:03:00 -0500
Received: by mail-wm0-x235.google.com with SMTP id v186so63436711wmd.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:03:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HOjCv1FniO6Zs_s75wHCru+c-PkAfbODcjYSqJZwX0Q@mail.gmail.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
	<CAFEAcA8HOjCv1FniO6Zs_s75wHCru+c-PkAfbODcjYSqJZwX0Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 15:02:35 +0000
Message-ID: <CAFEAcA8y=UGyErOA-oCn7tFyC3DheWyYt4WV+bgY6OU=FCKzrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/17] KVM and cpu-exec patches for 2.9
 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 14:37, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> PPC64, AArch64, ARM:
>
> /home/pm215/qemu/kvm-all.c:1898:23: error: =E2=80=98pending_sigbus_addr=
=E2=80=99
> defined but not used [-Werror=3Dunuse
> d-variable]
>  static __thread void *pending_sigbus_addr;
>                        ^
> /home/pm215/qemu/kvm-all.c:1899:21: error: =E2=80=98pending_sigbus_code=
=E2=80=99
> defined but not used [-Werror=3Dunuse
> d-variable]
>  static __thread int pending_sigbus_code;
>                      ^

...this is the same failure that patchew complains about
on s390.

thanks
-- PMM
