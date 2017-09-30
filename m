Received: from eggs.gnu.org ([2001:4830:134:3::10]:50362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuoweizhang@yahoo.com>) id 1dyK0u-0004KW-27
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuoweizhang@yahoo.com>) id 1dyK0p-0000Fk-7c
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:49:12 -0400
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:42012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhuoweizhang@yahoo.com>)
	id 1dyK0p-0000EZ-1J
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 11:49:07 -0400
Date: Sat, 30 Sep 2017 15:49:01 +0000 (UTC)
From: Zhuowei zhang <zhuoweizhang@yahoo.com>
Reply-To: Zhuowei zhang <zhuoweizhang@yahoo.com>
Message-ID: <2080649258.295593.1506786541765@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2080649258.295593.1506786541765.ref@mail.yahoo.com>
Subject: Re: [Qemu-devel] [PATCH v2] syscall: fix special case of write(fd,
 NULL, 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: zhuoweizhang@yahoo.com, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Cc: riku.voipio@iki.fi
List-ID: <qemu-devel.nongnu.org>


--------------------------------------------
On Sat, 9/30/17, Laurent Vivier <laurent@vivier.eu> wrote:
 
 > Could you change the NR_read too, for consistency?
 
The NR_read case for length 0 doesn't check if the buffer is NULL, unlike this patch, and I'm not sure if switching that to make a real read() syscall with a NULL buffer even if the original buffer is non-null would break anything.

Thanks
Zhuowei
