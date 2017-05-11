Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8mBw-0006Vh-5K
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8mBq-00069m-2N
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:23:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52130)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8mBp-00068a-QQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:23:25 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<006301d2c994$7bd42850$737c78f0$@ru> <87efvw91m0.fsf@linaro.org>
In-Reply-To: <87efvw91m0.fsf@linaro.org>
Date: Thu, 11 May 2017 14:23:17 +0300
Message-ID: <000601d2ca48$fd051330$f70f3990$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/9] BQL and Replay Lock changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>=20
> > Guest Windows XP doesn't boot with these patches.
>=20
> I'm guessing there is hardware attached to that machine?=20

Only mouse, keyboard and hdd.

> Did the asserts catch double locking?=20

No, they didn't.
The emulation also became much slower.
Maybe Windows boots, but with huge slowdown?

> As I said there are still changes to be made to
> the hardware emulation that saves async events with the device data.

What devices do you mean?

> But the real question is do you think that re-purposing replay_lock to
> give the sequential guarantees that the BQL used to is the right
> approach?

This approach seems to be ok - you raised the lock and io/cpu threads =
are now synchronized.
This is how BQL worked before.


Pavel Dovgalyuk
