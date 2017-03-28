Received: from eggs.gnu.org ([2001:4830:134:3::10]:53724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csnd5-0003GA-E6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csnd4-0000wL-Dv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:41:31 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csnd4-0000wB-7m
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:41:30 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l43so95286041wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:41:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490690794-19023-1-git-send-email-groug@kaod.org>
References: <1490690794-19023-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 10:41:08 +0100
Message-ID: <CAFEAcA9aCygBr6pzsrsuY8qDc6dNBwGDRoAgyy+0hDrRaFPHLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.9 2017-03-28
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

On 28 March 2017 at 09:46, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 34ef723ce34aaa14f94530c06a0ab3170a19bb59:
>
>   tests/virtio-9p-test: Don't call le*_to_cpus on fields of packed struct (2017-03-27 21:15:31 +0200)
>
> ----------------------------------------------------------------
> This series fixes potential memory/fd leaks in 9pfs and a crash when
> running tests/virtio-9p-test on SPARC hosts.
>
> ----------------------------------------------------------------
> Li Qiang (1):
>       9pfs: fix file descriptor leak
>
> Peter Maydell (1):
>       tests/virtio-9p-test: Don't call le*_to_cpus on fields of packed struct

Applied, thanks.

-- PMM
