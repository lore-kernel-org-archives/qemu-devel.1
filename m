Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSJo8-0001Q1-14
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSJo7-0000NO-4E
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:12:15 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSJo6-0000N0-Uj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:12:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id k190-v6so17357909oib.9
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 03:12:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611093800.GH11636@redhat.com>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
	<CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
	<20180611093800.GH11636@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 11:11:53 +0100
Message-ID: <CAFEAcA-_3UbuDa1H=eX5wGhV6ENSLGMbUAfOv6YSizcj09ccBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Keno Fischer <keno@juliacomputing.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>

On 11 June 2018 at 10:38, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Mon, Jun 11, 2018 at 09:52:55AM +0100, Peter Maydell wrote:
>> There's an argument that we should also log every config check
>> result somehow (I think autoconf configures do this), but I
>> don't think that our 'print stuff to stdout' is the right place
>> for that.

> It is sometimes useful to know the answer of individual checks, but
> if we really wanted todo that, we should just create a logfile for
> that info, or just write more into our existing config.log file.

Yes, that's what I had in mind. On the other hand, if we're not
in practice running into issues from users that would be easier
to debug with that detailed log info, it doesn't seem worth
the effort of trying to improve our config.log data...

thanks
-- PMM
