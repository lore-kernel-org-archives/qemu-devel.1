Received: from eggs.gnu.org ([2001:4830:134:3::10]:53126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08K5-0005SK-Mq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08K1-0003id-J6
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g08K1-0003hx-DF
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:48:57 -0400
References: <20180912160118.21158-1-liq3ea@163.com>
	<20180912160118.21158-2-liq3ea@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ae12445-6a06-859a-5609-7e64825c0b6d@redhat.com>
Date: Wed, 12 Sep 2018 11:48:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180912160118.21158-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] fw_cfg_mem: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org

On 9/12/18 11:01 AM, Li Qiang wrote:
> From: Li Qiang <liq3ea@gmail.com>
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

This commit message doesn't state why. The cover letter does, but that 
doesn't get checked into git. A year from now, if someone lands on this 
commit during a bisect, it would help if the commit message told them 
why you are adding a no-op callback here, instead of trying to fix the 
caller to treat a NULL callback as acceptable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
