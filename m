Received: from eggs.gnu.org ([209.51.188.92]:58266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0rBJ-0004mw-U7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0rBG-00060I-5O
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:15:13 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:17749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0rBF-0005m3-TS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:15:10 -0500
Date: Mon, 4 Mar 2019 18:15:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903041944.46482.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903041811400.22678@zero.eik.bme.hu>
References: <201903041944.46482.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

Hello,

On Mon, 4 Mar 2019, Andrew Randrianasulu wrote:
> I think I found some sources for pmon:
>
> http://www.anheng.com.cn/loongson/pmon/updates.lemote.com/files/upload/lm/firmware/pmon/source/pmon-priv.tar.gz
>
> slooowly downloading (20507323 (20M))
>
> and then in upper dir
>
> http://www.anheng.com.cn/loongson/pmon/
>
> 	toolchain-pmon.tar.bz2	2010-08-31 09:27 	36M

Thanks, I know about these, I've pointed to them in my previous patches: 
http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02477.html
but I don't have time nor interest to try to compile it for MIPS and 
recreate the binary now. If you're interested and give it a try feel free 
to do so, then reply to Alexandar's thread about this pmon binary if you 
managed to build it or find something that could help. (Currently to test 
the binary beyond serial output, to get display you need to apply my 
ati-vga patch from the list that's not yet on master.)

Regards,
BALATON Zoltan
