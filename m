Received: from eggs.gnu.org ([2001:4830:134:3::10]:56351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8R0z-0006m5-FR
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8R0y-0002hQ-N6
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:21 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:45152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8R0y-0002hE-Gu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:51:20 -0400
Received: by mail-ot0-x231.google.com with SMTP id w4-v6so2433979ote.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
References: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
	<d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 14:50:59 +0100
Message-ID: <CAFEAcA_rswg=c-QWcL1VraqiOEN1+zPmGG=-AP2f2CnYUA0K+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Last call for release-critical fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 April 2018 at 14:19, Stefan Weil <sw@weilnetz.de> wrote:
> Update po files? That's not a "must fix", but it would be nice to have
> those files synchronized with ui/gtk.c again.

Judging by the "POT-Creation-Date" timestamps, we haven't done
that for a year or so, so there doesn't seem to be a great
urgency to do it now.

Overall:
 * I don't really understand why we need to keep doing this;
   I tried "make -C po update" but all it did was update the
   date stamp and a bunch of comments in the .po files
 * If we do need to do this, we need to come up with a
   process (preferably automatic) that ensures that we do
   it in a more timely manner than "somebody mentions it
   on the day we're thinking of tagging the final rc"

Asking me to manually run a magic command I don't understand
doesn't really work, as you can see from how infrequently
it's happened.

thanks
-- PMM
