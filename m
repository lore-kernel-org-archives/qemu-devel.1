Received: from eggs.gnu.org ([2001:4830:134:3::10]:35181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew4cO-0001kw-Ho
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew4cL-0001yT-BP
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:30:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ew4cL-0001yF-7S
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:30:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09843D430C
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:30:39 +0000 (UTC)
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<152098654112.42.12932252584766342295@71c20359a636>
	<20180314033531.GL11787@xz-mi>
	<b4176553-befd-3404-25a0-c48ee70c13b4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fe6e4b1-6a9a-39c5-0f4c-4df09583f875@redhat.com>
Date: Wed, 14 Mar 2018 06:30:33 -0500
MIME-Version: 1.0
In-Reply-To: <b4176553-befd-3404-25a0-c48ee70c13b4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/69] Misc patches for QEMU soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

On 03/14/2018 05:12 AM, Paolo Bonzini wrote:

>>> Checking PATCH 16/69: chardev: tcp: postpone async connection setup...
>>> Checking PATCH 17/69: chardev: tcp: let TLS run on chardev context...
>>
>> It seems that Dan's last patch is still missing in the pull
>> request:
>>
>> http://patchwork.ozlabs.org/patch/883155/
> 
> Yes, this is a pull request I prepared last Monday and forgot to send.
> I'll send that out separately, it's a bugfix so it can be submitted
> after soft freeze.

Or, since my pre-freeze QAPI pull request needs a v2, I can include it 
there, if I have an ACK or R-b by Paolo.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
