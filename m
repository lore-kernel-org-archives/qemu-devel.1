Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYTaT-0000rY-8r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYTaS-00081t-9Z
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:19:21 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:33267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYTaS-00080b-4X
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:19:20 -0500
Received: by mail-ot0-x229.google.com with SMTP id x15so8709883ote.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 01:19:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB246318923F67429D5A584364D4130@MWHPR02MB2463.namprd02.prod.outlook.com>
References: <MWHPR02MB246318923F67429D5A584364D4130@MWHPR02MB2463.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 09:18:58 +0000
Message-ID: <CAFEAcA9jJvrD_57jbbAuAyXWquXRsfbM7yHejyvB8hGuX3qgvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Auto-install guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: microsoft gaofei <wangziheng@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 8 January 2018 at 01:22, microsoft gaofei <wangziheng@outlook.com> wrote:
> https://www.virtualbox.org/ticket/5810
>
> VirtualBox has a new feature to auto-install guest OSes.
> Could you develop such a feature to improve QEMU ?

I think this sort of feature is something we'd prefer to
see in the "management layer" software (like libvirt) that
sits on top of and controls QEMU instances, rather than
a feature in QEMU itself.

thanks
-- PMM
