Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chjx6-0001Ej-8X
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chjx5-0001cW-I4
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:28 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chjx5-0001bx-BG
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:27 -0500
Received: by mail-wr0-x22c.google.com with SMTP id m5so11683035wrm.0
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 13:32:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 21:32:05 +0000
Message-ID: <CAFEAcA_J1P_zU0=T+UEUBfxTtUrRcmM61VXcbB1iPc1ZK1xhEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/17] KVM and cpu-exec patches for 2.9 soft
 freeze
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

On 24 February 2017 at 17:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit a1cf5fac2b929ffa2abd1285401f2535ff8c6fea:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-02-21' into staging (2017-02-21 13:58:50 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f9e640f9a1a7185591985e10a557f11fbe783b87:
>
>   qmp-events: fix GUEST_PANICKED description formatting (2017-02-24 16:19:44 +0100)
>
> ----------------------------------------------------------------
> * kernel header update (requested by David and Vijay)
> * GuestPanicInformation fixups (Anton)
> * record/replay icount fixes (Pavel)
> * cpu-exec cleanup, unification of icount_decr with tcg_exit_req (me)
> * KVM_CAP_IMMEDIATE_EXIT support (me)
> * vmxcap update (me)

The patchew s390 host build failure looks like a genuine
problem, so I'm dropping this from my to-merge queue.

thanks
-- PMM
