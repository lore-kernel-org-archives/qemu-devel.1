Received: from eggs.gnu.org ([2001:4830:134:3::10]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgzm-0002m5-7s
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgzl-0005zX-8d
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:34:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVgzl-0005zC-3J
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:34:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id d19-v6so404991oti.8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 10:34:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618201612-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
	<20180615090314.GA31552@redhat.com>
	<20180618171431.GK7451@localhost.localdomain>
	<20180618201612-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 18:33:51 +0100
Message-ID: <CAFEAcA_qRKA6QK42YdpbVRifXoCitxq-ZMZkVz=ESy9f3GdwOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 18 June 2018 at 18:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jun 18, 2018 at 02:14:31PM -0300, Eduardo Habkost wrote:
>> > Sure if someone does that, we'll have no choice, but as long as 'pc' is
>> > shipped we shouldn't gratuitously break apps by changing the default.
>>
>> Right.  I just want to make sure "omitting the machine-type may
>> stop working in the future" is documented somehow.
>
> I still think we should just add links to the qemu binary and
> use ARGV to detect the machine type.
>
> qemu-pc-i386
> qemu-q35-x86_64

Do you really want 60 different qemu-something-arm symlinks?

thanks
-- PMM
