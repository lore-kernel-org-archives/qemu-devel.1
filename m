Received: from eggs.gnu.org ([2001:4830:134:3::10]:52958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG9q-0005JZ-Py
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG9n-0005T1-N5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:10 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG9n-0005Sh-GJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:48:07 -0500
Received: by mail-wm0-f44.google.com with SMTP id x4-v6so421007wmc.0
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 06:48:07 -0800 (PST)
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
	<1516279431-30424-5-git-send-email-pbonzini@redhat.com>
	<76f78388-fb2a-4e39-29a1-338da45b0c32@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <760cf253-96ea-2244-c7de-7e123ceb92eb@redhat.com>
Date: Thu, 1 Feb 2018 09:48:03 -0500
MIME-Version: 1.0
In-Reply-To: <76f78388-fb2a-4e39-29a1-338da45b0c32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] qed: make
 bdrv_qed_do_open a coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 18/01/2018 15:19, Eric Blake wrote:
> On 01/18/2018 06:43 AM, Paolo Bonzini wrote:
>> It is called from qcow2_invalidate_cache in coroutine context (incoming
> Why is a qcow2 function calling qed code?  Definitely a copy-paste bug,
> but I'm not sure of the right fix.

This reference was of course meant to be qed_invalidate_cache.

Thanks,

Paolo

>> migration runs in a coroutine), so it's cleaner if metadata is always
>> loaded from a coroutine.
