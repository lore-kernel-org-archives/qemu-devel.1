Received: from eggs.gnu.org ([2001:4830:134:3::10]:49912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDv0-00029D-VS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDuz-0000gg-NJ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:14:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMDux-0000eL-6Q
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:14:24 -0500
Received: by mail-oi1-x243.google.com with SMTP id 192-v6so7428483oii.6
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 07:14:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112095815-mutt-send-email-mst@kernel.org>
References: <20181016175236.5840-1-peter.maydell@linaro.org>
	<CAFEAcA_PZ6XDz70tbRJM8dJZQYUg=F23cmmXpc=PZC5=eP17Ew@mail.gmail.com>
	<CAFEAcA8iks-LCd2zqK_6Zvh9Z4rNCO1kjmP3Q5=pdXdxxtXCYg@mail.gmail.com>
	<20181112095815-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 15:14:01 +0000
Message-ID: <CAFEAcA_RD5q_c4gWC__xhgLgnPiddAU3e6TApYkOSWfPHPX=UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/nvdimm: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 12 November 2018 at 15:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Nov 12, 2018 at 02:42:16PM +0000, Peter Maydell wrote:
>> Since nobody responded to my ping of a week ago I propose to just
>> apply this to master...
>>
>> thanks
>> -- PMM
>
> Sorry. My LPC talk proposal suddenly got accepted and
> I was scrambling to get ready.
>
> Please feel free to apply this for now:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks.

> Generally I think we need to rethink our approach to endian-ness. I
> think we want to tag fields with specific endian-ness and use static
> checkers to verify it. That is how Linux does it.
> In particular this will mean no swapping bytes in place.

Yeah, I agree that swapping-in-place is definitely not ideal.
Personally I prefer to avoid having structs that try to match
in-memory binary layouts entirely (ie no packed structs).

> But that's a subject for another day.

Indeed.

-- PMM
