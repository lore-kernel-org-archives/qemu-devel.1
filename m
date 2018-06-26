Received: from eggs.gnu.org ([2001:4830:134:3::10]:59278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXje9-00089b-WB
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXje9-0003R2-9Z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:48:22 -0400
References: <20180625164239.13794-1-kwolf@redhat.com>
	<87h8lqkkrp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
Date: Tue, 26 Jun 2018 10:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <87h8lqkkrp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com

On 26/06/2018 10:35, Markus Armbruster wrote:
> We also want to deprecate usb-storage, but
> I guess we're still not ready for that (it's a complicated story).
> 
> To deprecate -drive without also deprecating usb-storage, we need to
> preserve features.

Patch looks good to me too, but indeed why can't we deprecate
usb-storage in favor of usb-bot + scsi-disk?

Thanks,

Paolo
