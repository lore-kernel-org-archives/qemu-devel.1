Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxvct-0005fQ-8q
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 10:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxvcs-00020X-AJ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 10:51:19 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxvcs-0001yZ-3s
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 10:51:18 -0400
Received: by mail-oi0-x244.google.com with SMTP id t68-v6so20977717oie.12
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 07:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Sep 2018 15:50:56 +0100
Message-ID: <CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 6 September 2018 at 13:02, Thomas Huth <thuth@redhat.com> wrote:
> I somehow fail to see that something outside of lsi53c895a.c should
> really need to access the internals of LSIState. If there is something
> that needs to be configured from the outside, it should be done via QOM
> properties instead, shouldn't it? So I think I'd rather prefer if you
> could do it the other way round and change the lsi*_create() functions
> to return a pointer to PCIDevice instead, if possible.

Nothing typically does, but the "modern" style of having QOM objects which
use other QOM objects do so by embedding the child object's struct into
the struct of the parent requires that the struct definition is available.
The only thing of it that is used is (effectively) its size and alignment
requirements.

(I had an RFC patch some years back that would allow you to mark
up the fields of the struct as private, so the struct could be
put in the header but the compiler would complain if you tried
to actually access any of its fields:
http://lists.gnu.org/archive/html/qemu-devel/2014-05/msg01846.html )

thanks
-- PMM
