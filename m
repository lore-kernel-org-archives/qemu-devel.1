Received: from eggs.gnu.org ([209.51.188.92]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4vd-0003uk-CT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4vX-0000XP-Ur
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:18:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go4vX-0000Wg-PN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:18:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so17561721wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:18:07 -0800 (PST)
References: <20190127015113.1599-1-samuel.thibault@ens-lyon.org>
	<20190127015509.ngofhbiduuwwbf7r@function>
	<CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b71e3a2b-61d6-2a2d-3c17-f9c832b4cad4@redhat.com>
Date: Mon, 28 Jan 2019 12:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Marc-André,

On 1/27/19 12:37 PM, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jan 27, 2019 at 5:55 AM Samuel Thibault <samuel.thibault@gnu.org> wrote:
>>
>> (Which I'll fold as appropriate within Marc-André's patch series)
> 
> Did you try using G_STATIC_ASSERT* instead?
[...]

Is there a same plan for QEMU codebase?
