Received: from eggs.gnu.org ([209.51.188.92]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go8X3-0008Dl-7E
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go8TP-0006Iy-Bh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:05:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go8TP-0006IL-5g
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:05:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so14249635wmd.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:05:19 -0800 (PST)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-3-philmd@redhat.com> <874l9tnmev.fsf@linaro.org>
	<8f1c2854-fb0a-b8cd-14aa-1b30924f11bf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cfa21c5e-5cb5-8996-0712-a6516e50b8aa@redhat.com>
Date: Mon, 28 Jan 2019 16:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <8f1c2854-fb0a-b8cd-14aa-1b30924f11bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>

On 1/28/19 12:03 PM, Paolo Bonzini wrote:
> On 28/01/19 10:47, Alex Bennée wrote:
>>>
>>> [1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
>>>   "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
>>>   the memory devices (/dev/null, /dev/zero, etc) need to permit them."
>> I assume set_nonblock is called on more than just these special devices?
>> Is there anyway to check this on OpenBSD or is it just an anonymous fd
>> at this point?
>>
> 
> Perhaps on OpenBSD we should just assert that we don't get EBADF?

We get ENODEV for "not a memory device":

    19 ENODEV Operation not supported by device.
    An attempt was made to apply an inappropriate function to a device,
    for example, trying to read a write-only device such as a printer.

I'll respin with your suggestion.

Thanks!

Phil.
