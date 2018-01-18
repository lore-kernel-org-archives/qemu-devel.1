Received: from eggs.gnu.org ([2001:4830:134:3::10]:57364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecAQn-0002BM-F5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecAQk-000139-7J
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:37 -0500
Received: from smtp.citrix.com ([66.165.176.89]:47367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecAQk-00011Q-1c
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:40:34 -0500
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <047d4fd6-aa7c-4b56-f8d9-3624d2d8d9ec@citrix.com>
Date: Thu, 18 Jan 2018 13:40:30 +0000
MIME-Version: 1.0
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] QIOChannelFile bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 11/01/2017 02:25 PM, Ross Lagerwall wrote:
> Hi,
> 
> Here is a bug fix with the use of QIOChannelFile and 2 bug fixes and an
> improvement to implementation of QIOChannelFile.
> 
> Regards,
> Ross Lagerwall
> 
> Ross Lagerwall (4):
>    migration: Don't leak IO channels
>    io: Fix QIOChannelFile when creating and opening read-write
>    io: Don't call close multiple times in QIOChannelFile
>    io: Add /dev/fdset/ support to QIOChannelFile
> 
>   include/io/channel-file.h    |  2 +-
>   io/channel-file.c            | 11 ++++-------
>   migration/savevm.c           |  2 ++
>   tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
>   4 files changed, 32 insertions(+), 12 deletions(-)
> 

Ping for reviews...

v1:
Got feedback from Daniel P. Berrange and Marc-André Lureau.

v2:
Patch 1: Unreviewed
Patch 2: Unreviewed
Patch 3: Reviewed by Marc-André Lureau
Patch 4: Reviewed by Marc-André Lureau

The patch series still applies cleanly on top of master.

Thanks,
-- 
Ross Lagerwall
