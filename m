Received: from eggs.gnu.org ([2001:4830:134:3::10]:35989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqqC-00084z-0X
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqq7-00027L-15
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:47:40 -0400
References: <1498187863-4937-1-git-send-email-li.ping288@zte.com.cn>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e95d7f8f-c3f2-df17-c79f-fa066092ce14@msgid.tls.msk.ru>
Date: Tue, 27 Jun 2017 16:47:30 +0300
MIME-Version: 1.0
In-Reply-To: <1498187863-4937-1-git-send-email-li.ping288@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND] QEMU Guest Agent: Fix memory leak
 of device information set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Ping <li.ping288@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

23.06.2017 06:17, Li Ping wrote:
> The caller of SetupDiGetClassDevs must delete the returned device information
>  set when it is no longer needed by calling SetupDiDestroyDeviceInfoList.

Applied to -trivial, with s/QEMU Guest Agent/qga-win32/ in the Subject.

/mjt
