Received: from eggs.gnu.org ([2001:4830:134:3::10]:47373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g0qVl-0002m1-M1
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g0qVk-0005uE-T9
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:00:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g0qVk-0005tb-O4
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 12:00:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id h26-v6so5051665otl.9
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 09:00:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb23ae44-1634-d608-fa1e-92511ffe6d9e@redhat.com>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081950.3228.68987.stgit@pasha-VirtualBox>
	<f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
	<002101d44bee$9edf9720$dc9ec560$@ru>
	<cccee26e-80fc-605a-43ef-b5e116912720@redhat.com>
	<cb23ae44-1634-d608-fa1e-92511ffe6d9e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Sep 2018 16:59:39 +0100
Message-ID: <CAFEAcA80Sjso7+BRDrMJcxdO_e7FaB9A4Bu28BiEygr5j3wtCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, war2jordan@live.com, Juan Quintela <quintela@redhat.com>, Ciro Santilli <ciro.santilli@gmail.com>, Jason Wang <jasowang@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, Markus Armbruster <armbru@redhat.com>, maria.klimushenkova@ispras.ru, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor R <boost.lists@gmail.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

On 14 September 2018 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 14/09/2018 16:00, John Snow wrote:
>>> Maybe not. We can hardly analyze all peripheral devices code and fix all the calls.
>>> But I think we can improve that patch and at least look through ide core to fix other calls.
>>>
>>> Pavel Dovgalyuk
>>>
>> It just seems odd that if you're working on a replay mechanism that
>> requires you to intercept my QEMU API calls that you're only changing a
>> trim callback.
>
> You need it only here because the block layer is already calling
> replay_bh_schedule_event (actually replay_bh_schedule_oneshot_event
> after patch 22 of this series) on reads and writes.

Do we have documentation describing when a device model needs to care
about record/replay ?

thanks
-- PMM
