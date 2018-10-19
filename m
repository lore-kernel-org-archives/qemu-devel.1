Received: from eggs.gnu.org ([2001:4830:134:3::10]:34841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTiu-0006LK-CT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTip-0004yu-BB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:48 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDTin-0004hS-8J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:43 -0400
References: <20181019121623.29148-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c2855fc2-5f37-6dc7-d869-c1f1e2a96f9d@vivier.eu>
Date: Fri, 19 Oct 2018 14:17:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181019121623.29148-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [2 0/3] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 19/10/2018 à 14:16, Laurent Vivier a écrit :
> The following changes since commit 1b7490446bf41f54130c2d495dd4c8768c8e1ce3:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-10-19 11:20:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
> 
> for you to fetch changes up to a133367ec1b689410f1e7427921e33bb1b569bd7:
> 
>   linux-user: Implement special usbfs ioctls. (2018-10-19 14:05:10 +0200)
> 
> ----------------------------------------------------------------
> A series to enable ioctl usbfs in linux-user
> 
> ----------------------------------------------------------------
> 
> Cortland Tölva (3):
>   linux-user: Check for Linux USBFS in configure
>   linux-user: Define ordinary usbfs ioctls.
>   linux-user: Implement special usbfs ioctls.
> 
>  configure                  |  12 ++-
>  linux-user/ioctls.h        |  46 ++++++++++
>  linux-user/syscall.c       | 180 +++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  28 ++++++
>  linux-user/syscall_types.h |  68 ++++++++++++++
>  5 files changed, 333 insertions(+), 1 deletion(-)
> 

oops, I'm going to resend with the good subject prefix.

Thanks,
Laurent
