Received: from eggs.gnu.org ([2001:4830:134:3::10]:56009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcasu-0007jw-Am
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcast-0007Gw-GS
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:23:08 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcast-0007GD-8o
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:23:07 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so21006830wmt.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 10:23:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1743b106-1217-92ee-589d-9ba99f76556d@redhat.com>
References: <150160611982.36.12492156362530631521@93e45bedd699>
	<09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
	<CAFEAcA9Mea6ysDVm76rf20HKC+z1jcMfM88zmCdHod=jt1e62Q@mail.gmail.com>
	<1743b106-1217-92ee-589d-9ba99f76556d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 18:22:45 +0100
Message-ID: <CAFEAcA_ikSRG6+dMuDeuJG_=S2G7Yk-nsHzORGGKZ8gaC6i=zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 1 August 2017 at 18:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Ok, for this patch I kept it consistent within the file, but for 2.11 we
> can change everything to "while (0)".

Is this a proposal to bite the bullet and fix all our
code style issues in existing code? :-)

It would be an interesting question to find out what % of
QEMU's lines of code have not been touched in the six
years since we added checkpatch, and how they're
distributed in the codebase (are there any neat
visualisations of this sort of thing?) Fix-when-touched
works OK where we're actively working but can leave
some big dead spots I suspect.

thanks
-- PMM
