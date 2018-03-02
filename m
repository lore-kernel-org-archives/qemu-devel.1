Received: from eggs.gnu.org ([2001:4830:134:3::10]:59998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eroSM-0001JL-Bw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eroSH-0002rJ-Be
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:26:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eroSH-0002qj-7U
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:26:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C5748A3DD
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 17:26:37 +0000 (UTC)
References: <20180302155110.5481-1-pbonzini@redhat.com>
	<20180302155110.5481-3-pbonzini@redhat.com>
	<500dde88-99bb-7f24-a98a-2fd76d1335c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e934f39-83e0-a4c1-0738-dcf285ffa45b@redhat.com>
Date: Fri, 2 Mar 2018 18:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <500dde88-99bb-7f24-a98a-2fd76d1335c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] q35: change default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

On 02/03/2018 18:24, Thomas Huth wrote:
> On 02.03.2018 16:51, Paolo Bonzini wrote:
>> The e1000 NIC is getting old and is not a very good default for a
>> PCIe machine type.  Change it to e1000e, which should be supported
>> by a good number of guests.
> 
> Basically a good idea, but you can only do that for new machine types
> (pc-q35-2.12 and later), otherwise migration from an older version will
> fail if the user tries to migrate with the default model.

Yeah, I was just throwing out the idea.

Paolo
