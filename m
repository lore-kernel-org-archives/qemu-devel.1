Received: from eggs.gnu.org ([209.51.188.92]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnPB-0007Ne-2J
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnPA-0004IE-Bc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:11:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqnPA-0004Gw-4N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:11:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so1688373wml.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 15:11:54 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-17-philmd@redhat.com>
	<acf648c9-ce9a-4b9a-8e02-15645f615075@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5634aacb-5c84-e895-a8d7-65dfa92ef385@redhat.com>
Date: Tue, 5 Feb 2019 00:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <acf648c9-ce9a-4b9a-8e02-15645f615075@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/16] RFC hw/net/smc91c111: Convert init
 helper into an inline function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 1/4/19 8:35 PM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> As init helper in "hw/char/pl011.h"
>> ---
>>  hw/net/smc91c111.c         | 17 -----------------
>>  include/hw/net/smc91c111.h | 25 ++++++++++++++++++++++++-
>>  2 files changed, 24 insertions(+), 18 deletions(-)
> 
> Why? If you move code around like this, you should mention the reason in
> the patch description.

Oops this one wasn't supposed to be sent, I planned to drop it before
sending but probably forgot because it was late friday :/
