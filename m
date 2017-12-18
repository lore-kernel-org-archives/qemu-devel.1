Received: from eggs.gnu.org ([2001:4830:134:3::10]:47499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQu5V-0002Hz-Mb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQu5Q-0001YU-SE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:00:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eQu5Q-0001YH-Lk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D2595F7B7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:59:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
Message-ID: <c70ea44b-8eb8-2336-7263-77967056265d@redhat.com>
Date: Mon, 18 Dec 2017 12:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <1509617407-21191-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 0/2] Check for the availability
 of a hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, david@redhat.com

On 02.11.2017 11:10, Thomas Huth wrote:
> First patch is a small clean up to the error handling code in
> qdev_device_add(), and the second patch adds a proper check for
> the availability of a hotplug controller to prevent the possibility
> of a crash with device_del.
> 
> The crash can currently be triggered for example like this:
> 
> $ s390x-softmmu/qemu-system-s390x -M none -nographic 
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add qemu-s390x-cpu,id=x
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> v3:
>  - Invert the logic of the second error check in the first patch
>    as suggested by Igor
>  - Updated the patch description of the second patch with the current
>    way to crash QEMU
> 
> v2:
>  - Do the check for the availability of the hotplug controller earlier
>    in qdev_device_add
>  - Use common new err_dev_del handler in case of failure
> 
> Thomas Huth (2):
>   qdev_monitor: Simplify error handling in qdev_device_add()
>   qdev: Check for the availability of a hotplug controller before adding
>     a device
> 
>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         | 21 +++++++++++++--------
>  3 files changed, 34 insertions(+), 16 deletions(-)

Ping!

Paolo or Eduardo, could one of you please pick up the two patches?

 Thanks,
  Thomas
