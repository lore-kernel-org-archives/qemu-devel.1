Received: from eggs.gnu.org ([2001:4830:134:3::10]:55269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXV7-0002VR-QU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXV6-0002nr-RB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:11:09 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAXV6-0002nO-Mo
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:11:08 -0400
Received: by mail-oi0-x233.google.com with SMTP id e23-v6so13580385oiy.1
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 02:11:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
References: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
	<8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 10:10:47 +0100
Message-ID: <CAFEAcA9pJBRXTes8V8C0ka7_QYcehgPJzd6RNqGyktn7PLMKqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unknown keycodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mike R <picnet@me.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 23 April 2018 at 04:31, Thomas Huth <thuth@redhat.com> wrote:
> On 21.04.2018 11:27, Mike R wrote:
>> (qemu) unknown keycodes `empty+aliases(qwerty)=E2=80=99, please report t=
o qemu-devel@nongnu.org
>>
>> reported.
>
> Well, please also report:

It's kind of our own fault that we didn't ask for those
sorts of details in that error message. I think that a lot
of the time it was reported without necessarily meaning that
any interesting keys weren't being handled correctly.

In any case, as of commit 2ec78706d188 that message has
been removed, so the 2.12 release should fix this, or
at least not produce unhelpful warnings :-)

thanks
-- PMM
