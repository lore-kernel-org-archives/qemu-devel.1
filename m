Received: from eggs.gnu.org ([2001:4830:134:3::10]:55738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cxbpE-0001BA-Il
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cxbpD-0006QP-Lb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cxbpD-0006Q1-GA
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D433C05974D
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 16:05:54 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-6-pbonzini@redhat.com>
	<48253fa9-d5eb-f750-6dfc-e478bfd85277@redhat.com>
	<a9195765-0f0b-7aac-a403-9dc4ebd376f4@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <271d6d98-55f6-3a32-f8c1-b60a901e21ff@redhat.com>
Date: Mon, 10 Apr 2017 12:05:53 -0400
MIME-Version: 1.0
In-Reply-To: <a9195765-0f0b-7aac-a403-9dc4ebd376f4@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 04/08/2017 05:52 AM, Paolo Bonzini wrote:
> 
> 
> On 08/04/2017 08:03, John Snow wrote:
>> Looks clean, though it may be useful to do a few more things;
>>
>> - Demarcate what you think is the monitor API in this file
> 
> It's already there:
> 
> +/*
> + * API for block job drivers and the block layer.
> + */
> +
> 
> where everything before is for the monitor.
> 

I meant explicitly, with a comment at the top explaining the demarcation.

>> - Organize blockjob.h to match to serve as a useful reference.
> 
> Hmm, yes.
> 
> Paolo
> 
