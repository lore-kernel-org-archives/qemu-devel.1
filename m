Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diyJr-0002bS-FC
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diyJn-0005lr-65
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diyJm-0005j5-QZ
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:37:15 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e4024b0-ec9d-151a-28b0-01c50471570b@redhat.com>
Date: Sat, 19 Aug 2017 09:37:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170818222313.13391-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, f4bug@amsat.org

On 19.08.2017 00:23, Eric Blake wrote:
> We already have several files that knowingly require assert()
> to work.  While we do NOT want to encourage the use of
> 'assert(side-effects)' (that is a bad practice that prevents
> copy-and-paste of code to other projects that CAN disable
> assertions; plus it costs unnecessary reviewer mental cycles
> to remember our project policy on crippling asserts), we DO
> want to send a message that anyone that disables assertions
> has to tweak code in order to compile, making it obvious that
> we are not going to support their efforts.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> First mentioned as an idea here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html
> but I'm titling this RFC as I'm not 100% convinced we want to make
> it a project-wide, rather than a per-file decision.

I think we should make this project-wide. Otherwise we will have the
discussion again and again whether it is ok to compile with NDEBUG or not.

Reviewed-by: Thomas Huth <thuth@redhat.com>
