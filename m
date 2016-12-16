Received: from eggs.gnu.org ([2001:4830:134:3::10]:43126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1cHoiJ-0004Vz-La
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1cHoiI-00070M-NZ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:22:03 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1cHoiI-0006xG-IY
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:22:02 -0500
Received: by mail-io0-x244.google.com with SMTP id p13so11298957ioi.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 01:22:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161216090024.GA4434@noname.redhat.com>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
	<20161215211838-mutt-send-email-mst@kernel.org>
	<d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
	<20161216090024.GA4434@noname.redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 16 Dec 2016 10:21:59 +0100
Message-ID: <CABLmASHHFAWqSHFnc9uDGj6ZJKxP8495dCpKqLj4Kf2e=EOgrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cole Robinson <crobinso@redhat.com>

On Fri, Dec 16, 2016 at 10:00 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 16.12.2016 um 09:26 hat Thomas Huth geschrieben:
>> On 15.12.2016 20:19, Michael S. Tsirkin wrote:
>> > On Thu, Dec 15, 2016 at 09:15:27PM +0200, Michael S. Tsirkin wrote:
>> >> On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
>> >>>> Do we fix this or disable SDL altogether?
>> >>>
>> >>> Well, it can't be *that* bad, otherwise it would not went unnoticed for
>> >>> a whole release cycle.
>> >>
>> >> That's what I'm saying, maybe no one uses SDL anymore.
>>
>> It's maybe not as common as the GTK interface, but as far as I know
>> people still use the SDL interface. For example here:
>>
>>  https://bugs.launchpad.net/qemu/+bug/922076
>>
>> ... so I would recommend to keep the SDL code in QEMU.
>
> When I actualy use qemu rather than just doing a quick test, I generally
> prefer SDL, too, because the GTK frontend still grabs some keys like F10
> for itself instead of passing them to the guest. And using HMP for
> something as simple as that - no, thanks.
>
> Kevin
>

I'd like to also point to the recent status report by Stefan Weil
concerning UI support in Windows builds:
http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg01383.html

At least for PPC Mac OS/OSX guests only the SDL1.2 UI is somewhat
usable, GTK2/3, SDL2 and VNC are all problematic.

Best,
Howard
