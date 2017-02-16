Received: from eggs.gnu.org ([2001:4830:134:3::10]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1ceNwq-0003k1-5O
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1ceNwl-0004fd-TV
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:26:20 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1ceNwl-0004eW-Li
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:26:15 -0500
Received: by mail-lf0-f52.google.com with SMTP id z134so9766883lff.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:26:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: dillaman@redhat.com
In-Reply-To: <887093105.8854266.1487258021988.JavaMail.zimbra@oxygem.tv>
References: <20170216084318.11122-1-jazeltq@gmail.com>
	<20170216090002.12511-1-jazeltq@gmail.com>
	<D7075812-8210-4092-8ED4-BB6FAC4E612C@gmail.com>
	<CAKZcxgfA6YvAOZfngyf0QC5iF1WwGK86DcXPJPwBOr_XFfzMuA@mail.gmail.com>
	<887093105.8854266.1487258021988.JavaMail.zimbra@oxygem.tv>
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 16 Feb 2017 10:26:13 -0500
Message-ID: <CA+aFP1BuRC73WuWo=cS1XRAM=K+in6ac8WFPU26LVN+zdHWq=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v5] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: jazeltq <jazeltq@gmail.com>, Tiger Hu <hufh2004@gmail.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

On Thu, Feb 16, 2017 at 10:13 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
> Hi, I would like to bench it with small 4k read/write.
>
> On the ceph side,do we need this PR ? :
> https://github.com/ceph/ceph/pull/13447

Yes, that is the correct PR for the client-side librbd changes. You
should be able to test it against Hammer/Jewel-release clusters.

-- 
Jason
