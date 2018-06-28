Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYTmH-0003PC-GT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYTmD-0004Xy-ID
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYTmD-0004Xe-DG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:03:45 -0400
References: <20180627172432.11120-1-danielhb413@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2bc7533d-65f3-9b0e-00fd-b78d31b22065@redhat.com>
Date: Thu, 28 Jun 2018 12:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180627172432.11120-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] VPD Block Limits emulation
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 27/06/2018 19:24, Daniel Henrique Barboza wrote:
> v2:
> - series overhauled - first 2 patches are cleanups (split in 2
> for easier review), patch 3 contains the whole logic
> - previous version link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02289.html
> 
> 
> When using SCSI passthrough and running in Linux, QEMU edits the
> reply of the SCSI Inquiry VPD Block Limits message with the value
> of the /sys/bus/<dev>/queue/max_sectors_kb parameter the device
> has in the host. Doing so allows the Linux guest to proper setup
> the device.
> 
> But the Block Limits message is optional, and its absence can cause
> the device to be unusable by the guest. An example can be seen
> at https://bugzilla.redhat.com/show_bug.cgi?id=1566195.
> 
> This series implements an approach to solve it. 

Queued, thanks.

Paolo
