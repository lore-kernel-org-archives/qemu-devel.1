Received: from eggs.gnu.org ([2001:4830:134:3::10]:43958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK0Nn-0005US-L3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK0Nk-0004pA-BW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:22:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK0Nk-0004nf-4a
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:22:56 -0500
References: <20181106115351.9422-1-ppandit@redhat.com>
	<CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af8e80fd-4249-2eb3-3646-4bbaa65acd40@redhat.com>
Date: Tue, 6 Nov 2018 13:22:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 06/11/2018 13:03, Peter Maydell wrote:
> When can this masking have any effect? These functions are
> the read and write ops for lsi_ram_ops, which we register with
>     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
>                           "lsi-ram", 0x2000);
> which specifies a memory region size of 0x2000. So the input
> addr must be in the 0..0x1fff range already -- or have I missed
> something ?
>=20
> It would probably be helpful (for readers and static analysers)
> to assert() that addr is < 0x2000, though.

Indeed, there are cases where the address is used blindly in a memcpy
with size>1, but this is not one of them.

Paolo
