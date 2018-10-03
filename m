Received: from eggs.gnu.org ([2001:4830:134:3::10]:33225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eBU-0002Kh-56
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eBP-0001gA-Mj
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:15:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7eBP-0001ev-GD
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:15:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so1033302wro.7
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:15:07 -0700 (PDT)
References: <20181003091344.24496-1-d.csapak@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3531fa12-27e6-62ef-61c7-500857ecc891@redhat.com>
Date: Wed, 3 Oct 2018 12:15:04 +0200
MIME-Version: 1.0
In-Reply-To: <20181003091344.24496-1-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi Dominik,

On 03/10/2018 11:13, Dominik Csapak wrote:
> this patch aims to execute a script when qemu exits
> so that one can do cleanups when using --daemonize without
> having to use the qmp monitor
> 
> for now i have mostly copied the script execution code from
> the launch_script function of net/tap.c as i am not sure
> if it would make sense to refactor that and if it does, where
> to put such a function

I'd rather refactor a 'more of 10 common LOC function'.

Maybe qemu_launch_script() in "qemu/osdep.h"?

Phil.
