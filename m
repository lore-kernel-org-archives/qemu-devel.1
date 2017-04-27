Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3eIe-0000YZ-4P
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3eIZ-0003cl-6h
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3eIZ-0003ak-0e
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:57:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814ECC054905
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 07:57:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1493192675-16104-1-git-send-email-peterx@redhat.com>
	<1493192675-16104-3-git-send-email-peterx@redhat.com>
	<8760hrxtcn.fsf@dusky.pond.sub.org>
	<20170427020931.GD26792@pxdev.xzpeter.org>
	<87h91ajpm2.fsf@dusky.pond.sub.org>
	<c1e66477-31ff-92cf-1f7c-9101408b5b98@redhat.com>
Date: Thu, 27 Apr 2017 09:57:04 +0200
In-Reply-To: <c1e66477-31ff-92cf-1f7c-9101408b5b98@redhat.com> (Paolo
	Bonzini's message of "Thu, 27 Apr 2017 09:39:07 +0200")
Message-ID: <87wpa6fflb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/04/2017 09:07, Markus Armbruster wrote:
>> Example for "makes no sense in QMP": setting the current CPU[1], because
>> a QMP monitor doesn't have a current CPU.
>> 
>> Examples for "is of use only for human users": HMP command "help", the
>> integrated pocket calculator[2].
>
> This example is more or less like "info mtree".
>
> In addition, it exposes ram_addr_t which is an internal interface to
> QEMU.  Therefore it shouldn't be exposed through QMP.

Makes sense.  Peter, please explain it in your commit message.
