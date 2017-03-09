Received: from eggs.gnu.org ([2001:4830:134:3::10]:44546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clwuj-0005PG-DV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clwug-0008Qw-9S
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:11:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clwug-0008Qn-3u
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:11:22 -0500
Date: Thu, 9 Mar 2017 12:11:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309121117.GD2480@work-vm>
References: <20170308105409.18183-1-dgilbert@redhat.com>
	<CAFEAcA9=1c36hkJWycFWUCs5=XOATmadc=xZun7txKgJtk0NPg@mail.gmail.com>
	<20170309112635.GA2480@work-vm>
	<ad69abd5-9f15-499a-7aa5-9644d6dda337@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad69abd5-9f15-499a-7aa5-9644d6dda337@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 09/03/2017 12:26, Dr. David Alan Gilbert wrote:
> >  * @name: Region name, becomes part of RAMBlock name used in migration stream
> >  *        must be unique within any device
> 
> Just a note, the uniqueness constraint also applies for RAM regions only.

Yes, I'm only adding this comment to the ram/ram like functions now.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
