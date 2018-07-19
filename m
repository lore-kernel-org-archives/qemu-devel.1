Received: from eggs.gnu.org ([2001:4830:134:3::10]:60991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7fi-0008Ak-2c
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7fc-00006z-AV
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:04:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fg7fb-000067-VR
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:04:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78033401EF02
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:04:31 +0000 (UTC)
Date: Thu, 19 Jul 2018 14:04:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180719140426.4a472767.cohuck@redhat.com>
In-Reply-To: <5f6e1882-93ff-717b-5a00-24b36c7df432@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
	<eb90a7b9-5a02-b9f7-c989-f646a272c4f3@redhat.com>
	<87601dztj3.fsf@secure.mitica>
	<2767a97a-006d-46cd-ce16-7cfedc93ef29@redhat.com>
	<20180719134522.5de53f8f.cohuck@redhat.com>
	<5f6e1882-93ff-717b-5a00-24b36c7df432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: quintela@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Thu, 19 Jul 2018 13:58:02 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 19.07.2018 13:45, Cornelia Huck wrote:
> > On Thu, 19 Jul 2018 13:06:59 +0200
> > Thomas Huth <thuth@redhat.com> wrote:

> >> I agree with you that the current situation with virtio-pci. c is bad. I
> >> think we should split it up into individual files instead
> >> (virtio-pci-rng.c etc.).  
> > 
> > We should then do the same thing for virtio-ccw as well.  
> 
> Yes. I can do that if you like.

Sure, feel free to go ahead.
