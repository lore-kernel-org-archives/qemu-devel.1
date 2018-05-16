Received: from eggs.gnu.org ([2001:4830:134:3::10]:54647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fIske-0005jU-Jq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fIska-00084O-Ke
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fIska-0007y2-GQ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:36 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
Date: Wed, 16 May 2018 11:29:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180515123007.10164-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

Hi Marc-Andr=C3=A9,

On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
> with TPM2 (I haven't tested TPM1, for lack of interest).

I got the review of this patch series added to my TODO list, but I'll
have to ask for your patience. :(

>From an extremely superficial skim:

* please use the

    TopDirPkg/ModuleName: blah blah blah

  subject format, or more generally, if a module cannot be identified,

    TopDirPkg: blah blah blah

* the subject line and the commit message shouldn't be wider than 74
  chars;

* edk2 uses two spaces for general indentation, and I'm noticing some
  inconsistency there (4 spaces like in QEMU).

* Please consider formatting the patches with "--find-copies-harder"
  (although I can look at them with the same option after fetching the
  series from your repo). This option is usually helpful for reviewers
  when cloning and modifying modules cross-package.

* Please consider adopting the git settings at
  <https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt=
-git-guide-for-edk2-contributors-and-maintainers>,
  in particular:

  - "--stat=3D1000 --stat-graph-width=3D20", so that pathnames are not
    truncated in the diffstats,

  - the "xfuncname"-related settings, so that git diff hunk headers @@
    are useful for DSC and INF files too,

  - the diff order file, so that files are listed in patches in logical
    order, going from abstract / descriptive (.inf, .h) to concrete /
    imperative (.c).

Not much of a review, I know; this is all I can offer right now. If you
have the time to respin just with these superficial changes, that might
make my life easier. If you prefer to delay them, that's 100% fine too.

Thanks
Laszlo
