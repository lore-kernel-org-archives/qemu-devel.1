Received: from eggs.gnu.org ([209.51.188.92]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1Ya-0001jq-J9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1YX-0002t6-LX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:41:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj1YV-0002rW-E6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:41:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so7266061wmd.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:41:25 -0800 (PST)
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-16-philmd@redhat.com>
	<8a7ef73f-97a4-d270-9836-3936b7be1046@redhat.com>
	<f91cbbae-c3a0-d182-6de9-4ddd0c3892fc@redhat.com>
	<20190114123531.isddusgjtnl47wiv@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <63e2b2bb-c4ba-3d3c-0656-f5e10a8fd3f3@redhat.com>
Date: Mon, 14 Jan 2019 13:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190114123531.isddusgjtnl47wiv@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 15/15] ui/console: Add
 "ui/pixelformat.h" to declare PixelFormat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 1/14/19 1:35 PM, Gerd Hoffmann wrote:
> On Mon, Jan 14, 2019 at 11:24:14AM +0100, Philippe Mathieu-Daudé wrote:
>> On 1/11/19 6:32 PM, Paolo Bonzini wrote:
>>> On 11/01/19 15:08, Philippe Mathieu-Daudé wrote:
>>>> PixelFormat is used by "ui/console.h" and by "ui/qemu-pixman.h".
>>>
>>> ui/console.h already includes ui/qemu-pixman.h, just move it there?
>>
>> That was my first though but then noticed pixman seems a bit
>> different/unrelated. If Gerd is OK I will do it. (I should have written
>> that in the commit).
> 
> console depends on pixman anyway, so that move would be fine.

Good.

> 
> BTW: Should not be that hard to remove PixelFormat altogether, or move
> the bits which are still needed to vnc which is the only user left
> (beside deprecated sdl1 which should go away soon).

I can help there once SDL1 got removed.

Thanks,

Phil.
