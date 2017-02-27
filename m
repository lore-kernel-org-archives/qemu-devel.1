Received: from eggs.gnu.org ([2001:4830:134:3::10]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQpn-0005l7-HH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQpm-0003hB-HC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:19:47 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciQpm-0003h1-9k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:19:46 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so70663941wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:19:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227164950.15062-1-pbonzini@redhat.com>
References: <20170227164950.15062-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 19:19:24 +0000
Message-ID: <CAFEAcA86vPxFF2X-=jiRCZ0wLQf1cgeDMadQh0b2K7iUHNHYWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v3 00/17] KVM and cpu-exec patches for 2.9
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

On 27 February 2017 at 16:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0819248d30877a9e0f063e7246e522a67548fc3e:
>
>   qmp-events: fix GUEST_PANICKED description formatting (2017-02-27 16:31:08 +0100)
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
>
> ----------------------------------------------------------------
> * kernel header update (requested by David and Vijay)
> * GuestPanicInformation fixups (Anton)
> * record/replay icount fixes (Pavel)
> * cpu-exec cleanup, unification of icount_decr with tcg_exit_req (me)
> * KVM_CAP_IMMEDIATE_EXIT support (me)
> * vmxcap update (me)

Fails to build, OSX:

/home/petmay01/qemu/kvm-all.c: In function 'kvm_cpu_exec':
/home/petmay01/qemu/kvm-all.c:1995:33: error: 'have_sigbus_pending'
undeclared (first use in this function)
         if (unlikely(have_sigbus_pending)) {
                                 ^
/home/petmay01/qemu/kvm-all.c:1995:33: note: each undeclared
identifier is reported only once for each function it appears in

thanks
-- PMM
