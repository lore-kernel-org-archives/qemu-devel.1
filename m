Received: from eggs.gnu.org ([2001:4830:134:3::10]:40347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1eC1be-0007Dj-CD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1eC1bZ-00041x-En
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:59:46 -0500
Date: Tue, 7 Nov 2017 19:59:37 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171107105937.GM29237@lianli.shorne-pla.net>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<20171103202624.5956-3-laurent@vivier.eu>
	<20171104212011.GK29237@lianli.shorne-pla.net>
	<1356a4f9-86a2-7b18-a67b-93dc6dadec4f@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1356a4f9-86a2-7b18-a67b-93dc6dadec4f@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org

On Sun, Nov 05, 2017 at 03:39:48PM +0100, Laurent Vivier wrote:
> Le 04/11/2017 à 22:20, Stafford Horne a écrit :
> > Hello,
> > 
> > On Fri, Nov 03, 2017 at 09:26:22PM +0100, Laurent Vivier wrote:
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > 
> > There is no commit body here, do we need one?  I can see in your cover letter
> > its mentioned this was revealed after enabling "USE_SOFTFLOAT_STRUCT_TYPES".
> > 
> > However, I'm just being curious why is this an issue?  In softfloat I assume we
> > pack our own floats so having the type that goes into a uint32 register wouldnt
> > make much difference right?
> 
> It's not an issue. It's for consistency. We can store a float32 in an
> uint32_t, but it's better to store float32 in float32 type.

OK, thank you.

> And as said in include/fpu/softfloat.h:
> 
> "Use structures for soft-float types.  This prevents accidentally mixing
>  them with native int/float types."

Thanks, I have not tested this but I trust it should not be an issue.

Acked-by: Stafford Horne <shorne@gmail.com>

-Stafford
