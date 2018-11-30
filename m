Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gSocl-0007lP-Ty
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gSocg-0001yV-SI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:38:51 -0500
References: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
	<16fc13de-778b-430e-d734-bbc802d25ba8@redhat.com>
	<8f24cfdf-061b-75e8-9d89-e2b0b5196115@vivier.eu>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <94576180-9b50-f913-a22a-385114282879@msgid.tls.msk.ru>
Date: Fri, 30 Nov 2018 22:38:34 +0300
MIME-Version: 1.0
In-Reply-To: <8f24cfdf-061b-75e8-9d89-e2b0b5196115@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] util: vfio-helpers: use ARRAY_SIZE in
 qemu_vfio_init_pci()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

30.11.2018 15:58, Laurent Vivier wrote:

>>> -    for (i = 0; i < 6; i++) {
>>> +    for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {

> I'm wondering if adding a #define to define the size of the array and
> then using it with the for() loop wouldn't be better?

On the other side, it doesn't really matter, one way or another..
It's so.. trivial.. ;)

/mjt
