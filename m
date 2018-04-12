Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6Uie-00040C-9K
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6Uib-0001Ql-5t
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:24:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6Uia-0001Px-Vw
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:24:21 -0400
Date: Thu, 12 Apr 2018 13:24:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180412052405.GK13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
	<d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
	<20180411093526.GH13887@xz-mi>
	<4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
	<20180411094812.GI13887@xz-mi>
	<a22bd066-79b8-575b-4104-b260b350c356@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a22bd066-79b8-575b-4104-b260b350c356@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Apr 11, 2018 at 08:06:04AM -0500, Eric Blake wrote:
> On 04/11/2018 04:48 AM, Peter Xu wrote:
> 
> > Okay. :) Thanks for confirming.  Then let me repost this patch without
> > touching the qemu-threads.
> > 
> > Btw, do you want me to repost the first patch separately too, or keep
> > the code as is?  I believe it depends on whether you treat that one as
> > a cleanup or not.  Thanks,
> 
> The first patch is no longer necessary for your new approach, but as it
> is a cleanup and you've already written it, it does not hurt to still
> send it as a separate cleanup patch useful in its own right.

Thank you, Eric.  I will repost.

-- 
Peter Xu
