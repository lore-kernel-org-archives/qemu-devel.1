Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3Up-000609-1k
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3Uo-00086E-Av
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:14:11 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo3Uo-00085Q-5A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:14:10 -0400
Received: by mail-oi0-x244.google.com with SMTP id 8-v6so14746062oip.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:14:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180810090821.l6r4vlisx7htbvv3@var.youpi.perso.aquilenet.fr>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180809111233.GA2619@work-vm>
	<CAFEAcA-+5xFDMuvK2W8v=Ufs2E1K4y9onZY_4x6RMYbHLFpkxA@mail.gmail.com>
	<20180809113204.GB2618@work-vm>
	<20180809215421.hexdewc3igklwvob@var.youpi.perso.aquilenet.fr>
	<CAFEAcA9hquE5jck7=-c6Xd36uDfm7Z_Kw39P1vCkZRqE1M4EDQ@mail.gmail.com>
	<20180810090821.l6r4vlisx7htbvv3@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 10:13:49 +0100
Message-ID: <CAFEAcA_KjCMf4hfyj4jnjsmxf-s4Q8hadF8HME+gwUMTW4GLSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

On 10 August 2018 at 10:08, Samuel Thibault <samuel.thibault@gnu.org> wrote=
:
> Peter Maydell, le ven. 10 ao=C3=BBt 2018 10:02:37 +0100, a ecrit:
>> (a) you should add a comment describing what 'gapsize'
>> is, ie that there may be a gap between the in-use data and the
>> start of the allocated buffer, and
>> (b) m_inc() should change its variable name to match.
>
> Right, I have done so in my tree.  Do you prefer to have it pushed for
> qemu 3.0?

No, this is definitely 3.1 material (also you should
post the patch for review as its own email, please).

thanks
-- PMM
