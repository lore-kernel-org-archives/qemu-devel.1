Received: from eggs.gnu.org ([2001:4830:134:3::10]:41831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6vWC-0007dk-HM
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6vWA-0005DM-7Q
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:33:36 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:46556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6vW6-000565-Cw
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:33:32 -0400
Received: by mail-ot1-x336.google.com with SMTP id q4-v6so12467865otf.13
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 03:33:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001092659.19418-1-pbonzini@redhat.com>
References: <20181001092659.19418-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 11:32:53 +0100
Message-ID: <CAFEAcA9qKJ5N6ZDB4Pa4ZEcnb1r02QXtHjjuxVKF+3Mj4DYTaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/79] Misc patches for 2018-09-30
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

On 1 October 2018 at 10:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 042938f46e1c477419d1931381fdadffaa49d4=
5e:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0926a' into staging (2018-09-28 17:07:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9e909b84144c79672b0847808358e8a4d134ced0:
>
>   hw/scsi/mptendian: Avoid taking address of fields in packed structs (20=
18-10-01 11:25:42 +0200)
>
> ----------------------------------------------------------------
> * configure fix for environment variables (Daniel)
> * fix memory leaks (Alex)
> * x86_64 MTTCG fixes (Emilio)
> * introduce atomic64 (Emilio)
> * Fix for virtio hang (Fam, myself)
> * SH serial port fix (Geert)
> * Deprecate rotation_rate for scsi-block (Fam)
> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
> * MSI/IOMMU fix (Jan)
> * Socket reconnection fixes (Marc-Andr=C3=A9)
> * icount fixes (Emilio, myself)
> * QSP fixes for Coverity (myself)
> * Some record/replay improovements (Pavel)
> * Packed struct fixes (Peter)
> * Windows dump fixes and elf2dmp (Viktor)
> * kvmclock fix (Yongji)
>
> ----------------------------------------------------------------
> Now without UTF-8 mojibake.

Looks like you missed one:

[staging c0a3e6c2bf] Merge remote-tracking branch
'remotes/bonzini/tags/for-upstream' into staging
 Date: Mon Oct 1 11:30:41 2018 +0100
    Suggested-by: Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com>
ERROR: pull request includes tag with UTF-8 error in person name

(commit b59878a1940c3 in your tree, in both the commit message
and the tag; commit db5910481bb in just the commit message).

thanks
-- PMM
