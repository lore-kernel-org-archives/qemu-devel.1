Received: from eggs.gnu.org ([2001:4830:134:3::10]:50072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPwR-0006hp-I8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPwQ-0002oh-NY
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:02:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-6-f4bug@amsat.org>
	<20170515041258.GA11105@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9dcb2dae-8320-31d0-29c1-34eefe5be2b0@amsat.org>
Date: Mon, 15 May 2017 21:02:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170515041258.GA11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/6] target/ppc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Hi David,

On 05/15/2017 01:12 AM, David Gibson wrote:
> On Fri, May 12, 2017 at 08:38:42PM -0300, Philippe Mathieu-Daudé wrote:
>> Patch created mechanically using Coccinelle script via:
>>
>>     $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
> Do you want me to merge this via my ppc tree, or is the whole set
> going in via some other path?

Thank for the review!

As you wish, I think it makes sens this serie goes altogether via 
Richard's tree, once I finish correcting few details.

Regards,

Phil.
