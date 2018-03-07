Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaIH-0004Fr-VH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaID-0005v6-2I
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:43:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etaIC-0005ur-Tk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 776108182D0C
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 14:43:44 +0000 (UTC)
References: <20180307142857.28438-1-pbonzini@redhat.com>
	<9a5fd178-cd3d-5128-d1dd-779975b01eb4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <112351a6-eb46-9c85-37eb-b928ac20a91a@redhat.com>
Date: Wed, 7 Mar 2018 15:43:42 +0100
MIME-Version: 1.0
In-Reply-To: <9a5fd178-cd3d-5128-d1dd-779975b01eb4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: update deprecation section to
 use -nic and -netdev hubport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 07/03/2018 15:38, Thomas Huth wrote:
> But please note that we've currently got a BiteSizeTask to replace all
> single-dash options with double dash options here:
> 
> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation

Is anybody actually using VLANs^Wdouble dash options?  I learnt about
them a month ago...

Paolo

> So it would be nicer if you'd directly use double dash options here now.
> (Note that you also got to use @option{--nic xxx} instead of ``--nic xxx''
> in that case)
