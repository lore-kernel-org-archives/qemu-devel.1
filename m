Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj8Wc-00012q-Nd
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj8Wb-0008KO-RR
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:58:54 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj8Wb-0008KA-K8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:58:53 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so5687300wma.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 09:58:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228161402.25122-1-pbonzini@redhat.com>
References: <20170228161402.25122-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 17:58:31 +0000
Message-ID: <CAFEAcA-yYjQab=g2C8WbP=zAy5q8r6o=z-UHh0Q9NDO3um_OCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 16:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b9a93b6cfddd348286cd8e44d7c4d964d9553a9f:
>
>   vl: disable default cdrom when using explicitely scsi-hd (2017-02-28 11=
:51:12 +0100)
>
> v3->v4: added two patches
>
>         fixed #ifdef KVM_HAVE_MCE_INJECTION
>
> v2->v3: replace SIGPOLL with SIGIO
>
>         another missing #ifdef KVM_HAVE_MCE_INJECTION
>
> v1->v2: add missing #ifdef KVM_HAVE_MCE_INJECTION
>
>         rebase over MTTCG pull request.  -icount is currently broken but
>         I'd like to preserve bisectability, so this pull request brings
>         in the icount patches through a merge commit.

Fails to build, ppc64, aarch64 (and probably others):

In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
                 from /home/pm215/qemu/kvm-all.c:16:
/home/pm215/qemu/kvm-all.c: In function =E2=80=98kvm_cpu_exec=E2=80=99:
/home/pm215/qemu/kvm-all.c:1995:22: error: =E2=80=98have_sigbus_pending=E2=
=80=99
undeclared (first use in this function)
         if (unlikely(have_sigbus_pending)) {
                      ^
/home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
macro =E2=80=98unlikely=E2=80=99
 #define unlikely(x)   __builtin_expect(!!(x), 0)
                                           ^
/home/pm215/qemu/kvm-all.c:1995:22: note: each undeclared identifier
is reported only once for each function it appears in
         if (unlikely(have_sigbus_pending)) {
                      ^
/home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
macro =E2=80=98unlikely=E2=80=99
 #define unlikely(x)   __builtin_expect(!!(x), 0)
                                           ^

thanks
-- PMM
