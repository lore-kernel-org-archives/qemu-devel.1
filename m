Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clBtH-000494-2c
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clBsl-0007t4-MH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:58:47 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clBsl-0007oc-D6
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:58:15 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l37so135269192wrc.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 01:58:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 09:57:52 +0000
Message-ID: <CAFEAcA-c1mNqzFoHYLjpqPMi5_cmz-7ADHAZQKO=uD7D11BrWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] 9pfs fixes for 2.9 2017-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 17:54, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 56b51708e9e22809d2a78f38d0ac84bb3f3fca92:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170306' into staging (2017-03-06 13:06:30 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/fixes-for-2.9
>
> for you to fetch changes up to b003fc0d8aa5e7060dbf7e5862b8013c73857c7f:
>
>   9pfs: fix vulnerability in openat_dir() and local_unlinkat_common() (2017-03-06 17:34:01 +0100)
>
> ----------------------------------------------------------------
> Fixes issues that got merged with the latest pull request:
> - missing O_NOFOLLOW flag for CVE-2016-960
> - build break with older glibc that don't have O_PATH and AT_EMPTY_PATH
> - various bugs reported by Coverity
>
> ----------------------------------------------------------------
> Greg Kurz (6):
>       9pfs: fix bogus fd check in local_remove()
>       9pfs: fix fd leak in local_opendir()
>       9pfs: fail local_statfs() earlier
>       9pfs: don't use AT_EMPTY_PATH in local_set_cred_passthrough()
>       9pfs: fix O_PATH build break with older glibc versions
>       9pfs: fix vulnerability in openat_dir() and local_unlinkat_common()
>

Applied, thanks.

-- PMM
