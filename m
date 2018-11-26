Received: from eggs.gnu.org ([2001:4830:134:3::10]:43584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNyx-0002Tz-OY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNyt-0003xH-Nz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRNyt-0003x0-J6
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:47 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 26 Nov 2018 18:59:39 -0200
Message-Id: <20181126205941.19021-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] x86 fixes for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

The following changes since commit d522fba24478474911b0e6e488b6d1dcf1af54=
f8:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81126' into staging (2018-11-26 13:58:46 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-for-3.1-pull-request

for you to fetch changes up to 30a759b61a9247378a9cb84fbe4e437ae66e0461:

  hw/hyperv: fix NULL dereference with pure-kvm SynIC (2018-11-26 14:14:3=
8 -0200)

----------------------------------------------------------------
x86 fixes for -rc3

* Fix SynIC crash
* Fix x86 crash on MSR code on AMD hosts

----------------------------------------------------------------

Bandan Das (1):
  kvm: Use KVM_GET_MSR_INDEX_LIST for MSR_IA32_ARCH_CAPABILITIES support

Roman Kagan (1):
  hw/hyperv: fix NULL dereference with pure-kvm SynIC

 hw/hyperv/hyperv.c |  6 +++++-
 target/i386/kvm.c  | 15 +++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
