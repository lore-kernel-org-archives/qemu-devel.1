Received: from eggs.gnu.org ([2001:4830:134:3::10]:42173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9un-0005m4-KU
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9uk-0007NB-Hs
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:33:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1et9uk-0007N2-Dd
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:33:46 -0500
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-13-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_9WhO31ZWTT_OK-ruO+PNFR+nBCUbEyTgbnDZbz7Xm9w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d82b597-e73d-a3be-69bf-f9de9e70b595@redhat.com>
Date: Tue, 6 Mar 2018 11:33:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9WhO31ZWTT_OK-ruO+PNFR+nBCUbEyTgbnDZbz7Xm9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/51] build-sys: compile with -Og or -O1
 when --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 02/03/2018 19:48, Peter Maydell wrote:
> On 16 January 2018 at 14:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> When --enable-debug is turned on, configure doesn't set -O level, and
>> uses default compiler -O0 level, which is slow.
>>
>> Instead, use -Og if supported by the compiler (optimize debugging
>> experience), or -O1 (keeps code somewhat debuggable and works around
>> compiler bugs).
>=20
> This gives me a noticeably worse debug experience (using -Og),
> because gdb shows a lot more "<optimised out>" variables and
> function arguments. (I've been mildly irritated by this for
> the last few weeks and only just figured out why this was
> happening.)
>=20
> Can we go back to the previous behaviour, please ? I don't
> care if the build is slow if I'm debugging, but I really do
> care that I don't have my variables and arguments all
> optimised away by the compiler so I can't tell what's going on.

Ok, will do.

Thanks,

Paolo
