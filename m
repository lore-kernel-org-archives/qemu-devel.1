Received: from eggs.gnu.org ([2001:4830:134:3::10]:43100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBM5t-0006WN-Bv
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBM5o-0005Y2-9E
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:40:13 -0500
References: <20171103202624.5956-1-laurent@vivier.eu>
	<20171103202624.5956-3-laurent@vivier.eu>
	<20171104212011.GK29237@lianli.shorne-pla.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1356a4f9-86a2-7b18-a67b-93dc6dadec4f@vivier.eu>
Date: Sun, 5 Nov 2017 15:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171104212011.GK29237@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] openrisc: fix float32 and float64
 helper definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org

Le 04/11/2017 à 22:20, Stafford Horne a écrit :
> Hello,
> 
> On Fri, Nov 03, 2017 at 09:26:22PM +0100, Laurent Vivier wrote:
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> There is no commit body here, do we need one?  I can see in your cover letter
> its mentioned this was revealed after enabling "USE_SOFTFLOAT_STRUCT_TYPES".
> 
> However, I'm just being curious why is this an issue?  In softfloat I assume we
> pack our own floats so having the type that goes into a uint32 register wouldnt
> make much difference right?

It's not an issue. It's for consistency. We can store a float32 in an
uint32_t, but it's better to store float32 in float32 type.

And as said in include/fpu/softfloat.h:

"Use structures for soft-float types.  This prevents accidentally mixing
 them with native int/float types."

Thanks,
Laurent
