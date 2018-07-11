Received: from eggs.gnu.org ([2001:4830:134:3::10]:52729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdInl-0006Vm-Ie
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdInk-0001Yb-Kv
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:21:17 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <955f26d7-5a0b-28e0-bd0f-f663593afefe@redhat.com>
Date: Wed, 11 Jul 2018 19:21:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 10/07/2018 08:50, Peter Maydell wrote:
>>> Yuck. The real problem here is that we're still requiring the
>>> code that creates these QOM devices to manually set the parent
>>> in the first place. It's not surprising that we don't get it right
>>> (either parenting in the wrong place or not at all). I'd much
>>> rather see us fix that properly than keep papering over places
>>> where we get it wrong.
>> Sorry, I'm still not an expert in all this QOM stuff yet ... so what d=
o
>> you exactly recommend to do instead?
> I'm not clear either, but I don't think that what we're
> currently doing can be right.

Well, in theory it should work...  I sent the expected flow in another em=
ail.

Paolo
