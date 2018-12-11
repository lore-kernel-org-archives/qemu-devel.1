Received: from eggs.gnu.org ([2001:4830:134:3::10]:33533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkkw-0007my-71
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkks-0003de-3p
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:19:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWkkr-0003bd-TN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:19:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so2882527wmf.5
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:19:29 -0800 (PST)
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0b0703c-cd51-6e03-77bc-8973b0490486@redhat.com>
Date: Tue, 11 Dec 2018 17:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, armbru@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com
Cc: qemu-devel@nongnu.org

On 11/21/18 6:10 AM, Li Qiang wrote:
> And also do some code cleanup.
> A lot of thanks to Markus's review and advice.
> 
> v2: fix some small issue per Markus's review.
> 
> Li Qiang (3):
>   fw_cfg: fix -boot bootsplash error checking
>   fw_cfg: fix -boot reboot-timeout error checking
>   fw_cfg: make qemu_extra_params_fw locally
> 
>  hw/nvram/fw_cfg.c       | 63 +++++++++++++++++++++----------------------------
>  include/sysemu/sysemu.h |  1 -
>  vl.c                    |  4 ++--
>  3 files changed, 29 insertions(+), 39 deletions(-)
> 

Thanks, I've queued this series for when 4.0 opens up.

Regards,

Phil.
