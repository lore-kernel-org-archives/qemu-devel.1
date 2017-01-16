Received: from eggs.gnu.org ([2001:4830:134:3::10]:44632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT7gG-0001AV-U1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT7gG-0007O3-9b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:50:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT7gG-0007Nt-3g
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:50:40 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D6E7C057FAD
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 13:50:40 +0000 (UTC)
Date: Mon, 16 Jan 2017 21:50:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116135032.GA4392@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
	<20170116130702.GG14226@lemon.Home>
	<609935a2-9a35-ac2f-f484-a0936d0fd642@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609935a2-9a35-ac2f-f484-a0936d0fd642@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, 01/16 14:32, Paolo Bonzini wrote:
> > Why cannot these be local (static) functions, in block/qed.c?
> 
> Patch 13 uses them elsewhere.  Should I put them in a separate patch?

Thanks, this is fine!

Fam
