Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC4Rx-0000Ic-Sa
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC4Ru-0004Fs-0M
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:01:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eC4Rt-0004Fj-Qe
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:01:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7D4E4E4C5
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 14:01:52 +0000 (UTC)
Date: Tue, 7 Nov 2017 15:01:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107150143.182ce22f.cohuck@redhat.com>
In-Reply-To: <1509617407-21191-2-git-send-email-thuth@redhat.com>
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
	<1509617407-21191-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qdev_monitor: Simplify error
 handling in qdev_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, david@redhat.com

On Thu,  2 Nov 2017 11:10:05 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Instead of doing the clean-ups on errors multiple times, introduce
> a jump label at the end of the function that can be used by all
> error paths that need this cleanup.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qdev-monitor.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
