Received: from eggs.gnu.org ([2001:4830:134:3::10]:50302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKt0F-0008Vl-Vy
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKt0F-0008OD-88
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:05:32 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
References: <20170613172006.19685-1-mreitz@redhat.com>
Date: Tue, 13 Jun 2017 23:05:18 +0200
Message-ID: <w51efunwqcx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block: Fix gcc 7 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Tue 13 Jun 2017 07:20:04 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
> blkdebug and blkverify use snprintf() to generate a filename; however,
> that may not fit into the target buffer (BDS.exact_filename). If so,
> they generate a truncated and thus pretty much unusable filename. In
> this case it's better to just not generate a filename at all (until we
> have better infrastructure which is not bound by a static buffer size).
>
> Also, gcc 7 warns about these snprintf() instances and these patches fix
> these warnings. There is another one in hw/usb/bus.c which is not
> addressed by this series.
>
> Max Reitz (2):
>   blkdebug: Catch bs->exact_filename overflow
>   blkverify: Catch bs->exact_filename overflow

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
