Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJlql-0001MX-EL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJlqi-0002kJ-9q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:19:39 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:49522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fJlqi-0002jr-2U
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:19:36 -0400
Date: Fri, 18 May 2018 21:19:28 +0100
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20180518211928.488214aa@octopus>
In-Reply-To: <805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de>
References: <cover.1526671191.git.julian@codesourcery.com>
	<845fc301f4a7725c239708c58876e3ae4d858fd9.1526671191.git.julian@codesourcery.com>
	<805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: qemu-devel@nongnu.org, Sandra Loosemore <sandra@codesourcery.com>, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

On Fri, 18 May 2018 21:52:04 +0200
Marek Vasut <marex@denx.de> wrote:

> On 05/18/2018 09:23 PM, Julian Brown wrote:
> > This patch (by Sandra Loosemore, mildly rebased) adds support for
> > semihosting for Nios II bare-metal emulation.
> > 
> > Signed-off-by: Julian Brown <julian@codesourcery.com>
> > Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>  
> 
> Is there some documentation for this stuff ? It looks interesting, but
> how can I try it here ?

There's no documentation AFAIK apart from that the entry points are
the same as m68k, semihosting is invoked with "break 1", and r4/r5 are
used for passing arguments. I'm not actually sure how you can try this
stuff without our startup code or other infrastructure (that I'm pretty
sure we can't divulge). Sandra, any ideas?

Thanks,

Julian
