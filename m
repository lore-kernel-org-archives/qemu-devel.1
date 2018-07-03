Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faFFj-000614-GX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faFFg-00027H-Fb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:57:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faFFg-000269-Ao
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D18BD40255C9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:57:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180703063626.GT2455@xz-mi>
Date: Tue, 03 Jul 2018 08:57:26 +0200
In-Reply-To: <20180703063626.GT2455@xz-mi> (Peter Xu's message of "Tue, 3 Jul
	2018 14:36:26 +0800")
Message-ID: <87o9fo4xih.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/32] qmp: Fixes and cleanups around OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jul 02, 2018 at 06:21:46PM +0200, Markus Armbruster wrote:
>> We're trying to get the out-of-band execution feature ready.  This
>> series fixes a number of issues, and marks a design flaw FIXME.  More
>> work is needed.
>
> Hi, Markus,
>
> I roughly went over the series (without going into every details), I
> left a few comments but it looks good to me in general (and I noticed
> that Eric has already provided r-bs for most of the patches).
>
> I feel like you want this series to settle fast, so I think I'll just
> hold the oob fixes until your series is merged, then I can work upon.

I'll push the respin to my public repository, so you can more easily
base your work on it while it's being reviewed and merged.

Thanks!
