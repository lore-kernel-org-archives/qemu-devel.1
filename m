Received: from eggs.gnu.org ([2001:4830:134:3::10]:34449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44Hi-0001lN-6O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44He-0000fI-E4
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e44He-0000eT-8E
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4994E883BB
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 12:14:13 +0000 (UTC)
References: <20171016094121.16455-1-david@redhat.com>
	<650c557c-4c1c-181e-75b5-bcb58ddb2746@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59cacd65-007a-2381-31aa-b17a98d8bb0e@redhat.com>
Date: Mon, 16 Oct 2017 14:14:07 +0200
MIME-Version: 1.0
In-Reply-To: <650c557c-4c1c-181e-75b5-bcb58ddb2746@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] kvm: tolerate non-existing slot for
 log_start and log_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 16/10/2017 11:53, David Hildenbrand wrote:
> 
> Looks like adding these assertions was counter productive :)

Or productive.  Bugs happen, and if they are a good occasion to add new
tests to the testsuite or at least a comment to the code, all the better.

Paolo
