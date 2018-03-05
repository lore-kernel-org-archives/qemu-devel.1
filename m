Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvMX-0004pF-9v
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvMU-0008Bu-5F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:01:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-3-f4bug@amsat.org>
	<20180305185754.GE17368@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d64466e4-57af-ffb7-fb1f-837885e532dd@amsat.org>
Date: Mon, 5 Mar 2018 16:01:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180305185754.GE17368@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH v2 02/30] hw: include
 "qemu/cunits.h" and clean unused "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@mips.com>, Marek Vasut <marex@denx.de>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Chris Wulff <crwulff@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Paul Burton <paul.burton@mips.com>, "open list:New World" <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>

On 03/05/2018 03:57 PM, Daniel P. Berrangé wrote:
> On Mon, Mar 05, 2018 at 08:27:04AM -0300, Philippe Mathieu-Daudé wrote:
>> These files were including "qemu/cutils.h" to use the byte-based size
>> definitions, now available in "qemu/cunits.h".
> 
> I know I'm "complaining" about bike-shed colour here....
> 
> Feels like just calling it units.h is sufficient - all our .h code is
> C code so don't need reminding of it by filename, particularly since
> we're avoiding system header clash by using the qemu/ prefix on #includes.

I like your suggestion :)

> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Regardless of whether you rename it or not though,
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

> 
> 
> Regards,
> Daniel
> 
