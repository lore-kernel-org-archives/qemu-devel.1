Received: from eggs.gnu.org ([2001:4830:134:3::10]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcta-0000Jn-6m
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdctX-0002be-1a
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:11:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdctW-0002ai-Rj
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:11:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4E4A4DD4C
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:11:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-8-git-send-email-armbru@redhat.com>
	<3c9934bf-7df3-6a81-caac-e949ca89ceaf@redhat.com>
Date: Tue, 14 Feb 2017 14:11:43 +0100
In-Reply-To: <3c9934bf-7df3-6a81-caac-e949ca89ceaf@redhat.com> (Paolo
	Bonzini's message of "Tue, 14 Feb 2017 13:33:50 +0100")
Message-ID: <87h93wc3xs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/24] util/cutils: Clean up variable names
 around qemu_strtol()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/02/2017 11:25, Markus Armbruster wrote:
>> * qemu_strtol()'s variable @err is *negative* errno,
>>   check_strtox_error()'s parameter @err is *positive*.  Rename the
>>   latter to @eno.
>
> What about in_errno or libc_errno?  No need to repost of course.

I don't mind.
