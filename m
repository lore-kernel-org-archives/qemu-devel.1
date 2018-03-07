Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etaUR-0005ft-Pv
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etaUQ-0002ls-1C
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:56:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etaUP-0002lj-T0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:56:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15EE18182D0C
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 14:56:18 +0000 (UTC)
References: <20180307142857.28438-1-pbonzini@redhat.com>
	<9a5fd178-cd3d-5128-d1dd-779975b01eb4@redhat.com>
	<112351a6-eb46-9c85-37eb-b928ac20a91a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <99559a01-48c8-ca2f-f5d3-b37e1f439230@redhat.com>
Date: Wed, 7 Mar 2018 15:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <112351a6-eb46-9c85-37eb-b928ac20a91a@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>

On 07.03.2018 15:43, Paolo Bonzini wrote:
> On 07/03/2018 15:38, Thomas Huth wrote:
>> But please note that we've currently got a BiteSizeTask to replace all
>> single-dash options with double dash options here:
>>
>> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation
> 
> Is anybody actually using VLANs^Wdouble dash options?  I learnt about
> them a month ago...

I use them accidentally now and then ... but I think the BiteSizeTask
description has a point: We're really very inconsistent between QEMU
itself and the tools like qemu-img... So I think that task is basically
a good idea.

 Thomas
