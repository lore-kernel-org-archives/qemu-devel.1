Received: from eggs.gnu.org ([2001:4830:134:3::10]:47356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTBU-00024C-Js
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTBP-0005M0-Dh
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTBP-0005Ki-3q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62DE5461D0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 11:43:10 +0000 (UTC)
References: <20181016135027.9856-1-pbonzini@redhat.com>
	<2b1519d7-ef3b-fca6-398d-294bd63f2a54@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <141b5e91-7d7f-9b8f-cd4b-1a3f2a77352e@redhat.com>
Date: Fri, 19 Oct 2018 13:43:07 +0200
MIME-Version: 1.0
In-Reply-To: <2b1519d7-ef3b-fca6-398d-294bd63f2a54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] es1370: more fixes for ADC_FRAMEADR and
 ADC_FRAMECNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 19/10/2018 10:46, Thomas Huth wrote:
>>
> It's in a pull request already, so this is likely too late: But for the
> next time, could you maybe rather use a "/* fall through */" comment
> instead of a goto? That looks less ugly.

Wait, it's not ugly, it's wrong.  The label is placed incorrectly.

Paolo
