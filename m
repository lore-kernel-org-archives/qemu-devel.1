Received: from eggs.gnu.org ([209.51.188.92]:49507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizPt-0006kF-68
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizPr-00062H-F2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizPr-0005tN-6j
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so22120992wrs.8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:24:18 -0800 (PST)
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-16-philmd@redhat.com>
	<8a7ef73f-97a4-d270-9836-3936b7be1046@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f91cbbae-c3a0-d182-6de9-4ddd0c3892fc@redhat.com>
Date: Mon, 14 Jan 2019 11:24:14 +0100
MIME-Version: 1.0
In-Reply-To: <8a7ef73f-97a4-d270-9836-3936b7be1046@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 1/11/19 6:32 PM, Paolo Bonzini wrote:
> On 11/01/19 15:08, Philippe Mathieu-Daudé wrote:
>> PixelFormat is used by "ui/console.h" and by "ui/qemu-pixman.h".
> 
> ui/console.h already includes ui/qemu-pixman.h, just move it there?

That was my first though but then noticed pixman seems a bit
different/unrelated. If Gerd is OK I will do it. (I should have written
that in the commit).

> 
> Paolo
> 
>> Create the new header "ui/pixelformat.h" to declare this structure,
>> and remove the forward declaration from "qemu/typedefs.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> RFC because "ui/console.h" has on license, so I added a default one.
> 
