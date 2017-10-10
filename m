Received: from eggs.gnu.org ([2001:4830:134:3::10]:55573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rci-0000Uk-7T
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rcd-0005Iv-76
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1rcd-0005I8-0L
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E9784A6FB
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:18:46 +0000 (UTC)
References: <20171004114008.14849-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <935e06c7-1be4-60c3-24a6-e8d670dac9a1@redhat.com>
Date: Tue, 10 Oct 2017 12:18:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171004114008.14849-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Reporting of rotation rate for disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>

On 04/10/2017 13:40, Daniel P. Berrange wrote:
> 
> There is no mechanism to report this information to virtio-blk.
> We could perhaps argue that people should use virtio-scsi instead,
> because fixing virtio-blk would require enhancement to both QEMU
> and Linux virtio-blk drivers (and other guest OS drivers too)

I think long-term virtio-blk should only be used for high-performance
scenarios where the guest SCSI layer slows down things sensibly.  So
perhaps virtio-blk should always report itself as non-rotational.

> I'm unclear if there is anything I should have done wrt the
> device migration vmstate when adding this extra field, or if it
> is safe to just expect the mgmt app to set the property correctly
> on src+dst ?

That should be enough, yes.

Paolo
