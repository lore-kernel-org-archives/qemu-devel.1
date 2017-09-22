Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvSN3-0008Bx-6V
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 14:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvSN0-00029d-AH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 14:08:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-1-f4bug@amsat.org>
	<a6bedac0-0e58-8709-f549-a602914c9077@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <400dde93-d110-ee49-b2a0-76ea633b4abe@amsat.org>
Date: Fri, 22 Sep 2017 15:08:03 -0300
MIME-Version: 1.0
In-Reply-To: <a6bedac0-0e58-8709-f549-a602914c9077@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 23/34] hw/dma/i8257: rename
 DMA_init() to i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "Eduardo Otubo\"" <otubo@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 09/22/2017 02:43 PM, Hervé Poussineau wrote:
> Le 22/09/2017 à 18:01, Philippe Mathieu-Daudé a écrit :
[...]
>> +void i8257_dma_init(ISABus *bus, int high_page_enable);
>> +
> 
> As you're changing the DMA_init prototype, can you add an Error **errp 
> parameter, and pass &error_abort in each caller?
> 
> See http://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00262.html 
> for more details

If Eduardo doesn't have a patch ready I can do it.
