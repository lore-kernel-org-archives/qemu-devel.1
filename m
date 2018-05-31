Received: from eggs.gnu.org ([2001:4830:134:3::10]:52249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOP0h-0007WY-00
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOP0g-0004UI-7o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:57:03 -0400
References: <20180531004323.4611-1-jsnow@redhat.com>
	<20180531004323.4611-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e394c9c5-e65e-5df5-71b3-5cdf87016be3@redhat.com>
Date: Thu, 31 May 2018 09:56:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180531004323.4611-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] ahci: trim signatures on raise/lower
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 05/30/2018 07:43 PM, John Snow wrote:
> These functions work on the AHCI device, not the individual

s/device/state/ ?

> AHCI devices, so trim the AHCIDevice argument.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   hw/ide/ahci.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
