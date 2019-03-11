Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3BQ9-000448-OS
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3BLx-0004Xi-VW
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:11:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h3BLx-0004WG-OK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF3723083394
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 03:11:48 +0000 (UTC)
Date: Mon, 11 Mar 2019 11:11:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190311031144.GE16479@xz-x1>
References: <20190308101210.28038-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308101210.28038-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: Update the bandwidth
 during postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Fri, Mar 08, 2019 at 10:12:10AM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The recently added max-postcopy-bandwidth parameter is only read
> at the transition from precopy->postcopy where as the older
> max-bandwidth parameter updates the migration bandwidth when changed
> even if the migration is already running.
> 
> Fix this discrepency so that:
>   a) You can change the bandwidth during postcopy by setting
>      max-postcopy-bandwidth
> 
>   b) Changing max-bandwidth during postcopy has no effect
>      (it currently changes the postcopy bandwidth which isn't
>      expected).
> 
> Fixes: 7e555c6c
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1686321
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Now in qapi/migration.json it's not mentioning precopy in the
max-bandwidth entry which seems to work even for postcopy but it'll
not:

# @max-bandwidth: to set maximum speed for migration. maximum speed in
#                 bytes per second. (Since 2.8)

Should we consider to touch that up too to match everything?

-- 
Peter Xu
