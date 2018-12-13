Received: from eggs.gnu.org ([2001:4830:134:3::10]:58423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSAT-0003YQ-J9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSAQ-0001ed-DD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:40:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXSAQ-0001di-7O
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:40:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
	<CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
	<87o99pa9w8.fsf@dusky.pond.sub.org> <20181213123908.GI5171@redhat.com>
	<CAFEAcA9z=oDWYBv_C3gyL5xSr8rBGk=zOmZ0iuQd+uQxbXUSCA@mail.gmail.com>
Date: Thu, 13 Dec 2018 15:40:43 +0100
In-Reply-To: <CAFEAcA9z=oDWYBv_C3gyL5xSr8rBGk=zOmZ0iuQd+uQxbXUSCA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 13 Dec 2018 12:54:54 +0000")
Message-ID: <87zht9o5g4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 13 Dec 2018 at 12:39, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> The problem with this assertion is that there's many places which
>> call qemu_set_nonblock, so you don't know which code to look at,
>> as we don't know the caller.
>
> In an ideal world assert would print a stack backtrace :-)

That feature would make even me make peace with g_assert() ;)
