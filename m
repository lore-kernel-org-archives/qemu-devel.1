Received: from eggs.gnu.org ([2001:4830:134:3::10]:58315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpI5j-0001yn-O8
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpI5i-0005AF-VD
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:35 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpI5i-00059W-On
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:34 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l37so69257736wrc.1
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 10:24:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317152214.6148-1-pbonzini@redhat.com>
References: <20170317152214.6148-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 17:24:13 +0000
Message-ID: <CAFEAcA_tzumRXsQRNbHsFn6149EKEpYNmPJJPyJDrJNMLoLRzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: fix compilation on OpenBSD
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

On 17 March 2017 at 15:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> si_band is not found in OpenBSD.   It is marked as obsolescent in
> POSIX, so we can delete it without any remorse.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/oslib-posix.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 94d81b9..3fe6089 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -709,8 +709,6 @@ void sigaction_invoke(struct sigaction *action,
>          si.si_pid = info->ssi_pid;
>          si.si_status = info->ssi_status;
>          si.si_uid = info->ssi_uid;
> -    } else if (info->ssi_signo == SIGIO) {
> -        si.si_band = info->ssi_band;
>      }
>      action->sa_sigaction(info->ssi_signo, &si, NULL);
>  }
> --
> 2.9.3

Applied to master as a buildfix, thanks.

-- PMM
