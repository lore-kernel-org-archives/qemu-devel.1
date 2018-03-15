Received: from eggs.gnu.org ([2001:4830:134:3::10]:36207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewX9B-0002v0-Mj
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewX9A-0002GR-Nr
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:58:37 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewX9A-0002G1-Hc
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:58:36 -0400
Received: by mail-ot0-x22a.google.com with SMTP id 79-v6so7731455oth.11
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:58:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520959261-96820-1-git-send-email-pbonzini@redhat.com>
References: <1520959261-96820-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 17:58:15 +0000
Message-ID: <CAFEAcA8cP_48-eY3=PM1jHSDi09QBmETecKKfTyUkjKgsUDNfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/22] KVM patches for QEMU 2.12 soft
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

On 13 March 2018 at 16:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit fb5fff15881ba7a002924b967eb211c002897983:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180312-pull-request' into staging (2018-03-12 18:35:37 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-sev
>
> for you to fetch changes up to 9f750794985d7386f088da941c76b73880b2b6c4:
>
>   sev/i386: add sev_get_capabilities() (2018-03-13 12:04:04 +0100)
>
> ----------------------------------------------------------------
> * Migrate MSR_SMI_COUNT (Liran)
> * Update kernel headers (Gerd, myself)
> * SEV support (Brijesh)
>
> I have not tested non-x86 compilation, but I reordered the SEV patches
> so that all non-x86-specific changes go first to catch any possible
> issues (which weren't there anyway :)).
>
> ----------------------------------------------------------------

Applied, thanks. The issues were indeed not there :-)

-- PMM
