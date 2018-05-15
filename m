Received: from eggs.gnu.org ([2001:4830:134:3::10]:40429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIc7e-0001HT-7U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIc7Z-0003kf-JM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIc7Z-0003kD-FN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:44:13 -0400
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8b8f182-6515-0036-72ed-21596af9b6ee@redhat.com>
Date: Tue, 15 May 2018 10:44:12 -0500
MIME-Version: 1.0
In-Reply-To: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mjc@sifive.com, palmer@sifive.com

On 05/15/2018 06:16 AM, Igor Mammedov wrote:
> cpu_init() was removed since 2.12, so drop define that now isn't used
> nad point to nowhere.

Reads better as:

so drop the define that is now unused

or maybe

so drop the unused define rather than letting it point to nowhere

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
