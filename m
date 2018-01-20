Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eciYU-0008Q0-EX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 21:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eciXf-0005sP-FY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 21:06:50 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eciXf-0005qH-09
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 21:05:59 -0500
Date: Fri, 19 Jan 2018 21:05:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180120020557.GA20269@flamenco>
References: <0919c2ab-1a62-f96c-1847-d6f95d3326f3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0919c2ab-1a62-f96c-1847-d6f95d3326f3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] Double-free due to e5dc1a6c6c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jan 19, 2018 at 17:55:27 -0500, Stefan Berger wrote:
> I get double-free memory errors when QEMU terminates due to commit
> e5dc1a6c6c.
> 
> The way to reproduce the error is to 1st do a 'system_reset' in the monitor
> and then get into the grub console and do a 'halt' there.

Can you please check whether this is fixed by the patch below?
Was posted yesterday on the list, should be on master soon.

  https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04298.html

Thanks,

		Emilio
