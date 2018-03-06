Received: from eggs.gnu.org ([2001:4830:134:3::10]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCrU-0001Tp-CZ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCrT-0005vH-I9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:42:36 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etCrT-0005um-Bj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:42:35 -0500
Received: by mail-oi0-x22b.google.com with SMTP id f186so14827495oig.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:42:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306133842.GH6163@redhat.com>
References: <20180306132430.32110-1-berrange@redhat.com>
	<CAFEAcA95xt-9MJHcRC7WovEB3W259_eFD7Q8v_pG5rGh3L7oCg@mail.gmail.com>
	<20180306133842.GH6163@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 13:42:14 +0000
Message-ID: <CAFEAcA98ZTXqXqtHFOaEvwCbO=206u3jNjN2MDq31m4d=bwkOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: don't use hwaddr as a type in trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 6 March 2018 at 13:38, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Tue, Mar 06, 2018 at 01:33:42PM +0000, Peter Maydell wrote:
>> If the type isn't "hwaddr" then HWADDR_PRIx is the wrong
>> format string macro -- those should change to PRIx64.
>
> Eeek, that HWADDR_PRIx macro is used throughout this file, sometimes
> even with uint32_t as the arg !

Mmm, it's used where PRIx64 should be, but I think only for uint64_t
arguments; I can't see a uint32_t one. hw/ide/trace-events also has
a couple of HWADDR_PRIx uses.

thanks
-- PMM
