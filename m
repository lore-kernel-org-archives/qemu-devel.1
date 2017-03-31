Received: from eggs.gnu.org ([2001:4830:134:3::10]:45285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cu0P4-0005QI-TI
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cu0P4-0000co-1A
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cu0P3-0000cJ-SN
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE99DC0528DF
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 17:32:00 +0000 (UTC)
References: <20170331164322.24020-1-stefanha@redhat.com>
	<4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
	<20170331173101.GL30620@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <692126d8-68ad-d546-1adb-32e041976683@redhat.com>
Date: Fri, 31 Mar 2017 19:31:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170331173101.GL30620@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Frediano Ziglio <fziglio@redhat.com>



On 31/03/2017 19:31, Richard W.M. Jones wrote:
> On Fri, Mar 31, 2017 at 06:53:56PM +0200, Paolo Bonzini wrote:
>> glib is expecting QEMU to use g_main_context_acquire around accesses to 
>> GMainContext.  However QEMU is not doing that, instead it is taking its 
>> own mutex.  So we should add g_main_context_acquire and
>> g_main_context_release in the two implementations of 
>> os_host_main_loop_wait; these should undo the effect of Frediano's 
>> glib patch.
> 
> Based on this paragraph, I'm testing the attached patch, and it does
> also appear to solve the hanging serial port problem.

Great, can you do more testing and/or send the patch formally as a
toplevel message?

Thanks,

Paolo
