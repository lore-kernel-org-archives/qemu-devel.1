Received: from eggs.gnu.org ([209.51.188.92]:39351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDs5-0002Jn-2D
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDqA-0004tQ-Of
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:02:04 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-5-dgilbert@redhat.com>
Date: Thu, 14 Feb 2019 11:01:15 +0100
In-Reply-To: <20190212134758.10514-5-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 12 Feb 2019 13:47:58 +0000")
Message-ID: <87k1i2aduc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] wavcapture: Convert to error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-trivial@nongnu.org

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Kill off a pile of monitor_printf's and cur_mon usage.

You also switch from the two line error format

    <error message>
    Reason: <strerror(errno)>

to the more common

    <error message>: <strerror(errno)>

Suggest to mention that you're changing error messages in the commit
message.

> The only one left in wavcapture.c is the info case.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
