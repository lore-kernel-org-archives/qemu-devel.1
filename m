Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb14p-0006Jt-5s
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb14j-0002Q1-D3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb14j-0002PJ-79
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:29:05 -0500
References: <2f3d36f8.1ce36.160f49d0471.Coremail.linzc@zju.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be21e8c9-651d-a11c-fffa-53e47c5abc3f@redhat.com>
Date: Mon, 15 Jan 2018 10:29:00 +0100
MIME-Version: 1.0
In-Reply-To: <2f3d36f8.1ce36.160f49d0471.Coremail.linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] question about share flatviews
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: CheneyLin <linzc@zju.edu.cn>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

On 14/01/2018 13:20, CheneyLin wrote:
> I'm wondering why we have to shares flatviews between different ASes. I=
n
> my opinion, arch like=C2=A0x86 only have two ASes(memory AS and io AS),=
 each
> AS is related with only one flatview. Their ASes are definitely differe=
nt.

Every PCI device has its own AddressSpace.  A PCI device's is either the
same as the memory AS or the same as the empty AS, hence sharing the
FlatView can provide substantial memory usage improvements.

Paolo
