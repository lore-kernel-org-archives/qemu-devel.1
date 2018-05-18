Received: from eggs.gnu.org ([2001:4830:134:3::10]:38785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJloD-0000NN-21
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJlo9-0001jq-Ox
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:17:01 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:49262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fJlo9-0001jJ-I9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 16:16:57 -0400
Date: Fri, 18 May 2018 21:16:48 +0100
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20180518211648.5d849941@octopus>
In-Reply-To: <49dbe9f7-0558-12d4-363a-fe13099f86bd@denx.de>
References: <cover.1526671191.git.julian@codesourcery.com>
	<8f1a519f9faa6ea16df5040c45bb2d5d7dfb8d50.1526671191.git.julian@codesourcery.com>
	<49dbe9f7-0558-12d4-363a-fe13099f86bd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Add generic Nios II board.
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

On Fri, 18 May 2018 21:50:55 +0200
Marek Vasut <marex@denx.de> wrote:

> On 05/18/2018 09:23 PM, Julian Brown wrote:
> > This patch adds support for a generic MMU-less Nios II board that
> > can be used e.g. for bare-metal compiler testing.  Nios II booting
> > is also tweaked so that bare-metal binaries start executing in RAM
> > starting at 0x00000000, rather than an alias at 0xc0000000, which
> > allows features such as unwinding to work when binaries are linked
> > to start at the beginning of the address space.
> >   
> So why dont you just use the 10m50 GHRD for this , why do you need
> custom board ?

I think because we wanted a board with no MMU, since our startup code
doesn't support that. Maybe Andrew can confirm/deny?

Thanks,

Julian
