Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ8QJ-00054O-Ht
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ8QI-0005ui-Gd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:38:39 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:35897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQ8QI-0005uT-Aa
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:38:38 -0400
Received: by mail-ot0-x235.google.com with SMTP id m11-v6so2012934otf.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 02:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604112036.2715-1-stefanha@redhat.com>
References: <20180604112036.2715-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 10:38:17 +0100
Message-ID: <CAFEAcA8UGhob5NMUkLkqyWMMXXj3C4aK27gXze9q518hgTtaAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On 4 June 2018 at 12:20, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit c25e8bba1f546ea72744ccfab77f8a9e8a323be8:
>
>   Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180601' into staging (2018-06-01 13:11:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 21891a5a3011608845b5d7f1f9cce60cdc2bcc62:
>
>   main-loop: drop spin_counter (2018-06-01 16:01:29 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
>  * Copy offloading for qemu-img convert (iSCSI, raw, and qcow2)
>
>    If the underlying storage supports copy offloading, qemu-img convert will
>    use it instead of performing reads and writes.  This avoids data transfers
>    and thus frees up storage bandwidth for other purposes.  SCSI EXTENDED COPY
>    and Linux copy_file_range(2) are used to implement this optimization.
>
>  * Drop spurious "WARNING: I\/O thread spun for 1000 iterations" warning
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
