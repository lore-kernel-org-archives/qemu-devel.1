Received: from eggs.gnu.org ([2001:4830:134:3::10]:37254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT6DS-0000qZ-Hd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT6DP-0007eT-8E
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:53:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT6DP-0007c7-3n
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:53:35 -0400
References: <1528895946-28677-1-git-send-email-eric.auger@redhat.com>
	<ed56ac4b-6e22-c6b1-4cfa-ce3a9a8af35a@redhat.com>
	<8e5da16e-2283-ff87-9426-293e7770e2aa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0140c2fe-1a79-c465-5302-ecff541ebd60@redhat.com>
Date: Wed, 13 Jun 2018 15:53:21 +0200
MIME-Version: 1.0
In-Reply-To: <8e5da16e-2283-ff87-9426-293e7770e2aa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com

On 13/06/2018 15:44, Auger Eric wrote:
>> Queuing this patch.  I'm not sure how I missed this, I have actually
>> tested it with SMMU.
> no problem. Strange also I was the only one facing the issue.

No, I must have blundered it between testing and posting the patches.

>> Do you also need the MemTxAttrs so that the right PCI requestor id is
>> used, or do you get it from somewhere else?
> which call site do you have in mind, sorry?

I'm wondering if the MemoryRegionCache needs to store the MemTxAttrs.
They would be passed to address_space_init_cache.

Paolo
