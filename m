Received: from eggs.gnu.org ([2001:4830:134:3::10]:34392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcXi-0000V2-Im
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcXe-0001IX-TU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dzcXe-0001IE-NG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:48:22 -0400
Date: Wed, 4 Oct 2017 13:48:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171004054817.GD24018@lemon>
References: <mailman.5237.1506939080.14747.qemu-devel@gnu.org>
	<13D44E07-31FB-4DCB-AAA7-6EF24670BF14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13D44E07-31FB-4DCB-AAA7-6EF24670BF14@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, 10/02 11:52, Programmingkid wrote:
> 
> > On Oct 2, 2017, at 6:11 AM, qemu-devel-request@gnu.org wrote:
> > 
> > Message: 21
> > Date: Mon, 2 Oct 2017 10:56:27 +0100
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> > To: qemu-devel@nongnu.org
> > Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
> > 	Peter Maydell <peter.maydell@linaro.org>,	Paolo Bonzini
> > 	<pbonzini@redhat.com>
> > Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for
> > 	keycodemapdb GIT submodule
> > Message-ID: <20171002095627.GD27086@redhat.com>
> > Content-Type: text/plain; charset=utf-8
> > 
> > FYI, in case people were wondering, patchew successfully passed all
> > tests. So it looks like 8th time lucky for getting submodules working
> > correctly unless someone can break it again.....
> > 
> >  http://patchew.org/QEMU/20170929101201.21039-1-berrange@redhat.com/
> 
> Using the above link I was able to copy and paste your patches to my computer. The problem was 'git am' kept saying "Patch format detection failed". Using 'git apply' was what I used instead. After running 'make' I saw this error: 

Since you've noticed the link: in the beginning of that page there is also an
easy way to get the patches by one command:

> git fetch https://github.com/patchew-project/qemu patchew/20170929101201.21039-1-berrange@redhat.com

Fam
