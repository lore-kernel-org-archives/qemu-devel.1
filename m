Received: from eggs.gnu.org ([2001:4830:134:3::10]:55312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOmOt-0004Fr-F8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gOmOn-00084Y-Lv
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:51 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:14889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gOmOm-00082x-Fc
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:45 -0500
Date: Mon, 19 Nov 2018 17:27:41 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181119162741.GA8564@sx9>
References: <20181118203312.5376-1-f4bug@amsat.org> <20181119152952.GA2405@sx9>
	<alpine.LFD.2.21.1811191537140.22162@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811191537140.22162@eddie.linux-mips.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Maciej,

>  Of course you can instead just set the default manually by using 
> `--with-llsc' when configuring GCC or specify `-mllsc' explicitly in 
> CFLAGS with a compiler that has been already built without that set by 
> default.

There are ways to pass such flags to the crossdev command, but I found
that method somewhat fiddly, perhaps because I was just about to learn
crossdev but also because there are multiple compiler stages involved
that sometimes need different options (floating point support and other
things were broken back then too). So patches seemed simpler and more
reliable to me. :)

Fredrik
