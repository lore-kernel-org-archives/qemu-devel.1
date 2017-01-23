Received: from eggs.gnu.org ([2001:4830:134:3::10]:59818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cValm-00054a-IK
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cValj-0004dA-Da
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:18:34 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cValj-0004ZP-7A
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:18:31 -0500
Received: by mail-wm0-x243.google.com with SMTP id d140so24939577wmd.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:18:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
	<20170123054052.GA1679@amit-lp.rh>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ef4f8ad-d492-0276-3c30-e51fe3445a08@redhat.com>
Date: Mon, 23 Jan 2017 10:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170123054052.GA1679@amit-lp.rh>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Change name of live migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com



On 23/01/2017 06:40, Amit Shah wrote:
> On (Sun) 22 Jan 2017 [12:47:51], Pankaj Gupta wrote:
>> Change the name of live migration thread from 'migration' 
>> to 'qemu_vm_migration' to identify it clearly. 'migration'
>> is a generic word and kernel also has  tasks for process
>> migration with the name 'migration/cpu#'.
> 
> Makes sense.
> 
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

It's a bit ugly that no other thread name has qemu in it, and the limit
is 15 characters---which is more than "qemu_vm_migration"'s length.  So
maybe "live_migration" or "migrate" would be better.

Spaces vs. underscores are also inconsistent.  A patch to fix that would
be helpful!

Paolo
