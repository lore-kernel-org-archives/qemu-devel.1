Received: from eggs.gnu.org ([2001:4830:134:3::10]:37492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBGES-0004W5-Od
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBGEO-00042l-SC
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBGEO-00042b-MJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:52:20 -0400
Date: Thu, 18 May 2017 03:52:17 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1120538601.8977419.1495093937424.JavaMail.zimbra@redhat.com>
In-Reply-To: <0900def5-6049-4338-1eb0-8a0404c6c839@gmail.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
	<9626326d-977f-bf26-851a-59d420f27993@redhat.com>
	<0900def5-6049-4338-1eb0-8a0404c6c839@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] mc146818rtc: fix Windows VM clock
 faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, yunfangtai@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org


> > Looks great.  Thanks for following up quickly on the reviews.
> 
> Paolo, if it is okay to you, could you please consider to merge this
> patchset? ;)

Yes, I've already queued it, but I don't have many patches so I am
delaying the pull request a bit (until at least I have time to test
vhost-user-scsi...).

In the meanwhile, it would be great if you prepared a qtest for the
problem of too many interrupts when the periodic timer is reprogrammed
continuously.

Thanks,

Paolo
