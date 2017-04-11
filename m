Received: from eggs.gnu.org ([2001:4830:134:3::10]:39787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxxoR-0001lA-7j
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxxoQ-0005WV-CR
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:34:35 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxxoQ-0005WE-5u
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:34:34 -0400
Received: by mail-wm0-x232.google.com with SMTP id w64so66952675wma.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:34:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgr77z82.fsf@dusky.pond.sub.org>
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
	<87lgr77z82.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 16:34:12 +0100
Message-ID: <CAFEAcA_UqJ1mrTxtcRKbPA=xB2k1zFDo_wPZK0VBw3o2aqS8VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest.c: Delete possible stale
 unix sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 April 2017 at 16:14, Markus Armbruster <armbru@redhat.com> wrote:
> No objection to this work-around for tests leaving crap behind, but I
> think we should also try harder not to leave crap behind.  Say give each
> test its own scratch directory, make sure no test writes outside it, and
> have the harness remove it afterwards.

That would all be nice, yes :-)

thanks
-- PMM
