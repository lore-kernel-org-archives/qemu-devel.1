Received: from eggs.gnu.org ([2001:4830:134:3::10]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d33OQ-000470-Ov
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d33ON-0000Lj-KP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:32:46 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1d33ON-0000L8-9Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:32:43 -0400
References: <20170301093748.28033-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <260f8cca-719e-dc31-12cf-507e01270c53@vivier.eu>
Date: Tue, 25 Apr 2017 18:32:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170301093748.28033-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: fix eventfd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Ping?

Laurent

Le 01/03/2017 à 10:37, Laurent Vivier a écrit :
> This patch series byte-swap the uint64_t data stream
> of a file-descriptor opened with eventfd().
> 
> It allows to pass more LTP test cases:
> 
> eventfd01    1  TPASS  :  counter value matches required
> eventfd01    2  TPASS  :  read failed with EAGAIN as expected
> eventfd01    3  TPASS  :  counter value matches required
> eventfd01    4  TPASS  :  write failed with EAGAIN as expected
> eventfd01    5  TPASS  :  read failed with EINVAL as expected
> eventfd01    6  TPASS  :  write failed with EINVAL as expected
> eventfd01    7  TPASS  :  write failed with EINVAL as expected
> eventfd01    8  TPASS  :  fd is set in readfds
> eventfd01    9  TPASS  :  fd is not set in readfds
> eventfd01   10  TPASS  :  fd is set in writefds
> eventfd01   11  TPASS  :  fd is not set in writefds
> eventfd01    1  TPASS  :  counter value matches required
> eventfd01    2  TPASS  :  read failed with EAGAIN as expected
> eventfd01    3  TPASS  :  counter value matches required
> eventfd01    4  TPASS  :  write failed with EAGAIN as expected
> eventfd01    5  TPASS  :  read failed with EINVAL as expected
> eventfd01    6  TPASS  :  write failed with EINVAL as expected
> eventfd01    7  TPASS  :  write failed with EINVAL as expected
> eventfd01    8  TPASS  :  fd is set in readfds
> eventfd01    9  TPASS  :  fd is not set in readfds
> eventfd01   10  TPASS  :  fd is set in writefds
> eventfd01   11  TPASS  :  fd is not set in writefds
> eventfd01   12  TPASS  :  counter value write from child successful
> eventfd01   13  TCONF  :  eventfd01.c:642: eventfd support is not available in AIO subsystem
> eventfd01   14  TCONF  :  eventfd01.c:647: eventfd support is not available in AIO subsystem
> eventfd01   15  TCONF  :  eventfd01.c:652: eventfd support is not available in AIO subsystem
> 
> Laurent Vivier (2):
>   linux-user: call fd_trans_target_to_host_data() for write()
>   linux-user: fix eventfd
> 
>  linux-user/syscall.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
