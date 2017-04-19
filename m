Received: from eggs.gnu.org ([2001:4830:134:3::10]:42721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0sDR-0005qL-Us
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0sDR-00088Y-5j
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0sDR-000886-08
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C064780467
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:12:23 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-2-pbonzini@redhat.com>
	<25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83bc60d2-c20f-1023-5337-b39b50a7fd6e@redhat.com>
Date: Wed, 19 Apr 2017 18:12:20 +0200
MIME-Version: 1.0
In-Reply-To: <25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 19/04/2017 17:48, Eric Blake wrote:
>>  bool block_job_user_paused(BlockJob *job)
>>  {
> Is it worth using some form of attribute((nonnull)) annotations on
> various functions, to both state our intentions and let compilers help
> us catch obvious places where we are violating our intentions?  That's
> more of a generic question to all of qemu, and doesn't affect your
> particular patch, other than your patch is an instance where the
> annotation would be useful if we wanted to use them.

What kind of bug would the compiler catch?  I suppose Coverity would
catch all of them, and maybe -flto would as well.

Paolo

>> -    return job ? job->user_paused : 0;
>> +    return job->user_paused;
