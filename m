Received: from eggs.gnu.org ([2001:4830:134:3::10]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ckpJk-0002wT-T8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ckpJg-0004oR-2c
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:52:36 -0500
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
	<d5475df8-290b-07d4-d177-979d78850615@redhat.com>
	<CAFEAcA90FRxghG0ZdH7H9y2bDk2U9XO1TUJgx0MN+N=7LzO5pQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a30ecb4-77d0-795f-bf61-378546a8b034@redhat.com>
Date: Mon, 6 Mar 2017 10:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90FRxghG0ZdH7H9y2bDk2U9XO1TUJgx0MN+N=7LzO5pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config
 for ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 06.03.2017 10:47, Peter Maydell wrote:
> On 6 March 2017 at 07:00, Thomas Huth <thuth@redhat.com> wrote:
>> Note: In case you respin the series, you might want to add this
>> CONFIG_SM501 to ppc64-softmmu.mak, too, since it is a superset of the
>> 32-bit config (i.e. it can also emulate the 32-bit embedded chips).
> 
> Yes, definitely do this please.
> (Missed this because ARM's 64-bit default config includes the
> 32-bit one rather than duplicating its contents.)

I guess we could do something like that on ppc, too (and ppc-softmmu.mak
should likely include ppcemb-softmmu.mak), but
that's something for QEMU 2.10 / 3.0 / whichever version will be next.

 Thomas
