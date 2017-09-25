Received: from eggs.gnu.org ([2001:4830:134:3::10]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwRzM-0001f6-SO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwRzL-0005Hu-UR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:55:52 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwRzL-0005HX-N4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:55:51 -0400
Received: by mail-wm0-x242.google.com with SMTP id x17so6973372wmd.5
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:55:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4bb66a11-110a-562a-8e3d-8d1c7088c2bc@vivier.eu>
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-7-carenas@gmail.com>
	<4bb66a11-110a-562a-8e3d-8d1c7088c2bc@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Mon, 25 Sep 2017 04:55:50 -0700
Message-ID: <CAPUEsphYh==_xYm-m5VuSQcyY977e0NOJiZoMDM8t=S4YRBdKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 6/6] linux-user: update default socket.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, riku.voipio@iki.fi

On Fri, Sep 22, 2017 at 10:04 AM, Laurent Vivier <laurent@vivier.eu> wrote:

> And you should move powerpc bits to linux-user/ppc/sockbits.


PPC is IMHO a special case, since it is kept together with the generic
header in the linux kernel (except for a similar exception to those few
values that differ) as you can see in :


http://elixir.free-electrons.com/linux/latest/source/arch/powerpc/include/uapi/asm/socket.h

breaking it up into his own file will probably only make it more difficult
to maintain

Carlo
