Received: from eggs.gnu.org ([2001:4830:134:3::10]:39331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3wb-0007wA-Iy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3wa-0005XR-Kp
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:05:25 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj3wa-0005XH-EG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:05:24 -0500
Received: by mail-wr0-x22a.google.com with SMTP id u48so29748130wrc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:05:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301122950.3587-1-pbonzini@redhat.com>
References: <20170301122950.3587-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 13:05:02 +0000
Message-ID: <CAFEAcA9sTx6RYYcNXX94VK1O_TznpS=nooH-9rRyhb7S3Q+-Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 1 March 2017 at 12:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236ff:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' into staging (2017-02-26 22:40:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b9a93b6cfddd348286cd8e44d7c4d964d9553a9f:
>
>   vl: disable default cdrom when using explicitely scsi-hd (2017-02-28 11:51:12 +0100)
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
>
>

Isn't this the same as your existing pull request that's
already in my queue? The hash seems to be the same...

thanks
-- PMM
