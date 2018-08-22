Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fsbMQ-00036z-I9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fsbML-0004t3-VQ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:12:18 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:34174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1fsbML-0004sf-NR
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:12:13 -0400
Date: Thu, 23 Aug 2018 01:12:09 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20180822220928.jcl7df2kbrcgk7c6@MacBook-Pro-Roman.local>
References: <20180822103835.26129-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180822103835.26129-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char-pty: remove unnecessary #ifdef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 22, 2018 at 12:38:35PM +0200, Paolo Bonzini wrote:
> For some reason __APPLE__ was not checked in pty code.  However, the #ifdef
> is redundant: this file is already compiled only if CONFIG_POSIX, same as
> util/qemu-openpty.c which it uses.
> 

Thanks Paolo!

FWIW, qemu_openpty_raw and qemu_pipe are declared for all operating
systems except _WIN32 in qemu-common.h. For sake of symmetry, should the
declarations be available only for CONFIG_POSIX?

--
Roman
