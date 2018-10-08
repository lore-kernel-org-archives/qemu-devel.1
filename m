Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9W5Y-0000yJ-Nz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9VrZ-0005Bi-OU
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:46:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9VrW-0005AY-43
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:46:19 -0400
Date: Mon, 8 Oct 2018 09:46:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008134616.GA25450@flamenco>
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-7-cota@braap.org>
	<197b7649-0bc7-4a9a-021b-a308a1755cf1@amsat.org>
	<20181008014834.GA21299@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008014834.GA21299@flamenco>
Subject: Re: [Qemu-devel] [RFC 6/6] cputlb: dynamically resize TLBs based on
 use rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

On Sun, Oct 07, 2018 at 21:48:34 -0400, Emilio G. Cota wrote:
> - 70/40% use rate for growing/shrinking the TLB does not
>   seem a great choice, if one wants to avoid a pathological
>   case that can induce constant resizing. Imagine we got
>   exactly 70% use rate, and all TLB misses were compulsory
>   (i.e. a direct-mapped TLB would have not prevented a
            ^^^
>   single miss). We'd then double the TLB size:

I meant fully associative.

		E.
