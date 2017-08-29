Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmiUA-0002Mv-Dw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmiU9-0004Fk-D6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:31:26 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dmiU9-0004F9-6j
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:31:25 -0400
Received: by mail-wm0-x231.google.com with SMTP id x189so67682wmg.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:31:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829092226.4zxhyfgagkyrj2go@var.youpi.perso.aquilenet.fr>
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8LYZ28FFmb=HLvoBbx=w60OjBAKFogGScxV1bL8bee-Q@mail.gmail.com>
	<20170829092226.4zxhyfgagkyrj2go@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2017 16:31:03 +0100
Message-ID: <CAFEAcA_a9+U_otb6AhB=hQvRR1tPF=KQy4y77x8ZP4Mbf+nkMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 29 August 2017 at 10:22, Samuel Thibault <samuel.thibault@gnu.org> wrote=
:
> Peter Maydell, on mar. 29 ao=C3=BBt 2017 10:20:31 +0100, wrote:
>> On 28 August 2017 at 00:05, Samuel Thibault
>> <samuel.thibault@ens-lyon.org> wrote:
>> > warning: redirection vers https://people.debian.org/~sthibault/qemu.gi=
t/
>> > The following changes since commit 04d74e07b4542aad5aa4ad03951b38b767f=
5314a:
>> >
>> >   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12=
 +0200)
>> >
>> > are available in the git repository at:
>> >
>> >   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>> >
>> > for you to fetch changes up to 04d74e07b4542aad5aa4ad03951b38b767f5314=
a:
>> >
>> >   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12=
 +0200)
>> >
>> > ----------------------------------------------------------------
>> > slirp updates
>> >
>> > ----------------------------------------------------------------
>>
>> Is this pull request intended to be for 2.10 (in which
>> case it needs justification) or for 2.11 (in which case
>> it's a bit early) ?
>
> It is for 2.10. It fixes at least a DOS: userland can at least crash
> qemu with specially-crafted packets.

It's really really hard to justify putting this in now.
If it had come in last Wednesday it would have been
easy to put into rc4. If it had come in next Thursday
we'd have shrugged and said "ok, needs to go into next
stable release". Right now it's a choice of "treat it
as if it had arrived in two days time" (ie don't put it
in 2.10) or delay the release by yet another rc cycle.

thanks
-- PMM
