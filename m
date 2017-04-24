Received: from eggs.gnu.org ([2001:4830:134:3::10]:39230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2cos-0003Fo-RC
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2cos-0004zP-1B
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:10:18 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2cor-0004z9-R0
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:10:17 -0400
Received: by mail-wm0-x231.google.com with SMTP id w64so60002926wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 05:10:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1704211236100.58688@zero.eik.bme.hu>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-10-kraxel@redhat.com>
	<alpine.BSF.2.20.1704211236100.58688@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 13:09:56 +0100
Message-ID: <CAFEAcA9P9EECgmqubfN+71cYxsB5bbTddooyBfpM7=C2-6iTXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 9/9] sm501: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 11:42, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 21 Apr 2017, Gerd Hoffmann wrote:
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> hw/display/sm501.c | 23 ++++++-----------------
>> 1 file changed, 6 insertions(+), 17 deletions(-)
>
>
> Hold on with this please too. I have a series pending that changes this.

Gerd: I've now applied Zoltan's patchset to git master, so you'll
want to rebase your changes on it.

thanks
-- PMM
