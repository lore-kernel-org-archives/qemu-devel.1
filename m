Received: from eggs.gnu.org ([209.51.188.92]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gmMwZ-0006Si-Rr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gmMwY-0002Py-Sk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:07 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gmMwY-0002Pb-HL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:08:06 -0500
Date: Wed, 23 Jan 2019 13:08:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190123180804.GA1040@flamenco>
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <251451940.431966.1548259107629@mail.yahoo.com>
Subject: Re: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Jan 23, 2019 at 15:58:27 +0000, Lucien Anti-Spam via Qemu-devel wrote:
> Hi folks,
> I noticed that with 3.x release that the GDB options (-S -s) for certain CPU results in very weird stepping.Usually stops afer a few steps, whilst the stub continues responding the PC doesnt update, however, I have only deeply looked at the m68k.
> In the case of the m68K the SR gets the trace bit set (T=10b), and the PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchanged.But it seems the INSN handling has changed greatly for the m68k.
> Does anyone have any ideas what happened?

Can you please bisect to find at which point things start misbehaving?

Thanks,

		Emilio
