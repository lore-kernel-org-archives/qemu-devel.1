Received: from eggs.gnu.org ([2001:4830:134:3::10]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e45ST-000773-TB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e45SO-0002s7-Vk
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:29:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e45SO-0002rJ-MK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:29:24 -0400
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
	<b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
	<CAFEAcA8nyWgNDA23Cne8dpOMKXmZ98A0kR8K_MSkYt8bF3pZCg@mail.gmail.com>
	<c9e56a17-3c75-cfcf-7709-ee27efc291af@vivier.eu>
	<20171016130616.GF1918@kos.to>
	<4d8c3811-62a9-2391-e962-736c333d45c6@vivier.eu>
	<CAFEAcA8z17CSarERraA2+QsakzPx-RioJNX=+e7_8pf_MUqVnA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3ec5701f-3515-2682-4884-484eb0f1503d@vivier.eu>
Date: Mon, 16 Oct 2017 15:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8z17CSarERraA2+QsakzPx-RioJNX=+e7_8pf_MUqVnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, pgndev <pgnet.dev@gmail.com>

Le 16/10/2017 à 15:26, Peter Maydell a écrit :
> On 16 October 2017 at 14:09, Laurent Vivier <laurent@vivier.eu> wrote:
>> For this part, yes, but I think for the other comment, STRUCT(mtget,
>> ...) needs to be updated.
> 
> Looking more closely I don't think it is as simple as just
> adjusting the STRUCT() definition. For a basic type that can
> be different on host and guest, I think we'd need to handle
> it the way we do the TYPE_OLDDEVT, with special support
> in the thunk code for figuring out how large it is and so on.
> That seems like a lot of work for a magtape ioctl that I
> suspect nobody's using and which we can't test...

I agree.

> Applying this patch as-is would at least fix the ioctl
> for everything except MIPS and SPARC hosts and guests.

Yes, so I think it can be applied as-is.

Thanks,
Laurent
