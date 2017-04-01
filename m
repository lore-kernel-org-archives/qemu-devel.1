Received: from eggs.gnu.org ([2001:4830:134:3::10]:44983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cuFxh-0007BW-An
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 06:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cuFxe-0008Lm-46
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 06:08:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cuFxd-0008Le-Ts
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 06:08:46 -0400
Received: by mail-wm0-x243.google.com with SMTP id x75so3148978wma.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 03:08:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170331164322.24020-1-stefanha@redhat.com>
	<4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
	<20170331173101.GL30620@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7f6cb59-ec92-a331-8dbb-126c9f23f1eb@redhat.com>
Date: Sat, 1 Apr 2017 12:08:35 +0200
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Frediano Ziglio <fziglio@redhat.com>



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

Turn out that it may actually be a glib bug.  Your patch would enable
Frediano's optimizations so it's worth applying anyway.

https://bugzilla.gnome.org/show_bug.cgi?id=761102

Paolo
