Received: from eggs.gnu.org ([2001:4830:134:3::10]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHnqu-0006EW-1i
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHnqq-0002zl-Tr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cHnqq-0002xx-Nm
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:26:48 -0500
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
	<20161215211838-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
Date: Fri, 16 Dec 2016 09:26:43 +0100
MIME-Version: 1.0
In-Reply-To: <20161215211838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cole Robinson <crobinso@redhat.com>

On 15.12.2016 20:19, Michael S. Tsirkin wrote:
> On Thu, Dec 15, 2016 at 09:15:27PM +0200, Michael S. Tsirkin wrote:
>> On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>>>>> The problem always reproduces for me:
>>>>>>> - start qemu with -sdl
>>>>>>> - wait for guest to boot
>>>>>>> - click anywhere within guest screen
>>>>>>> - message "press ctrl+alt to exit capture" appears on screen,
>>>>>>>   but pressing that immediately restarts capture again
>>>
>>> [ 2.6 good, 2.7, 2.8 bad ]
>>>
>>>> I'd say SDL is mostly useless with this bug.
>>>>
>>>> Do we fix this or disable SDL altogether?
>>>
>>> Well, it can't be *that* bad, otherwise it would not went unnoticed for
>>> a whole release cycle.
>>
>> That's what I'm saying, maybe no one uses SDL anymore.

It's maybe not as common as the GTK interface, but as far as I know
people still use the SDL interface. For example here:

 https://bugs.launchpad.net/qemu/+bug/922076

... so I would recommend to keep the SDL code in QEMU.

 Thomas
