Received: from eggs.gnu.org ([209.51.188.92]:34289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go5Ce-0006Qk-1u
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go5Cc-00075G-Ml
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:35:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go5Cc-0006z2-Ft
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:35:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so17651098wrp.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:35:37 -0800 (PST)
References: <20190127015113.1599-1-samuel.thibault@ens-lyon.org>
	<20190127015509.ngofhbiduuwwbf7r@function>
	<CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
	<b71e3a2b-61d6-2a2d-3c17-f9c832b4cad4@redhat.com>
	<CAFEAcA8arejWDEYd1zZhFR+ANyOeJ8KsJvVR==pE55dDZoO5Bw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <babfc88f-c109-6325-e27b-1122d0e4bbc4@redhat.com>
Date: Mon, 28 Jan 2019 12:35:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8arejWDEYd1zZhFR+ANyOeJ8KsJvVR==pE55dDZoO5Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Replace QEMU_BUILD_BUG_ON with own
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1/28/19 12:25 PM, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 11:22, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 1/27/19 12:37 PM, Marc-André Lureau wrote:
>>> Did you try using G_STATIC_ASSERT* instead?
>> [...]
>>
>> Is there a same plan for QEMU codebase?
> 
> Our version uses _Static_assert where possible, which I think
> will give better error messages than the glib version. There are
> also some corner cases where the glib macros don't work:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07090.html
> 
> Broadly, our implementation works and so I don't see much need
> to mess with it, outside of the special case of slirp that's
> trying to cut its ties with QEMU.

OK!

Thanks,

Phil.
