Received: from eggs.gnu.org ([2001:4830:134:3::10]:52413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3e1H-00066D-8q
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3e1E-00030O-62
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3e1D-0002zs-V6
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:39:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 761C43D94F
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 07:39:14 +0000 (UTC)
References: <1493192675-16104-1-git-send-email-peterx@redhat.com>
	<1493192675-16104-3-git-send-email-peterx@redhat.com>
	<8760hrxtcn.fsf@dusky.pond.sub.org>
	<20170427020931.GD26792@pxdev.xzpeter.org>
	<87h91ajpm2.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1e66477-31ff-92cf-1f7c-9101408b5b98@redhat.com>
Date: Thu, 27 Apr 2017 09:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <87h91ajpm2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ramblock: add new hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 27/04/2017 09:07, Markus Armbruster wrote:
> Example for "makes no sense in QMP": setting the current CPU[1], because
> a QMP monitor doesn't have a current CPU.
> 
> Examples for "is of use only for human users": HMP command "help", the
> integrated pocket calculator[2].

This example is more or less like "info mtree".

In addition, it exposes ram_addr_t which is an internal interface to
QEMU.  Therefore it shouldn't be exposed through QMP.

Paolo

>> But, before that, I would also want to know whether anyone would think
>> this an useful thing even to QMP... If so, I would be glad to provide
>> QMP interface as well.
> Can't say without understanding the use cases.  Perhaps you can start
> with explaining the itch your HMP command scratches.
