Received: from eggs.gnu.org ([2001:4830:134:3::10]:58290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjV2s-0006kf-Ku
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjV2r-0008SU-Nu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:01:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjV2r-0008RV-HE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:01:41 -0500
References: <20170228161402.25122-1-pbonzini@redhat.com>
	<CAFEAcA-yYjQab=g2C8WbP=zAy5q8r6o=z-UHh0Q9NDO3um_OCA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <442ad062-5b45-bea0-3276-0cef76234477@redhat.com>
Date: Thu, 2 Mar 2017 19:01:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yYjQab=g2C8WbP=zAy5q8r6o=z-UHh0Q9NDO3um_OCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/19] KVM and cpu-exec patches for 2.9
 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 01/03/2017 18:58, Peter Maydell wrote:
> Fails to build, ppc64, aarch64 (and probably others):
>=20
> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>                  from /home/pm215/qemu/kvm-all.c:16:
> /home/pm215/qemu/kvm-all.c: In function =E2=80=98kvm_cpu_exec=E2=80=99:
> /home/pm215/qemu/kvm-all.c:1995:22: error: =E2=80=98have_sigbus_pending=
=E2=80=99
> undeclared (first use in this function)
>          if (unlikely(have_sigbus_pending)) {
>                       ^
> /home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
> macro =E2=80=98unlikely=E2=80=99
>  #define unlikely(x)   __builtin_expect(!!(x), 0)
>                                            ^
> /home/pm215/qemu/kvm-all.c:1995:22: note: each undeclared identifier
> is reported only once for each function it appears in
>          if (unlikely(have_sigbus_pending)) {
>                       ^
> /home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
> macro =E2=80=98unlikely=E2=80=99
>  #define unlikely(x)   __builtin_expect(!!(x), 0)

Are you sure you updated the tag?  Line 1995 here is:

#ifdef KVM_HAVE_MCE_INJECTION

and that error would have come from v3.

Paolo
