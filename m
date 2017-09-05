Received: from eggs.gnu.org ([2001:4830:134:3::10]:51424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp451-00074A-9i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp44w-0004SK-OF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp44w-0004Rg-Ht
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:59:06 -0400
Date: Tue, 5 Sep 2017 10:59:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905025901.GF22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-3-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-3-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 02/13] qemu.py: avoid writing to
 stdout/stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
> This module should not write directly to stdout/stderr. Instead, it
> should either raise exceptions or just log the messages and let the
> callers handle them and decide what to do. For example, scripts could
> choose to send the log messages stderr or/and write them to a file if
> verbose or debugging mode is enabled.
> 
> This patch replaces the writes to stderr by an exception in the
> send_fd_scm() when _socket_scm_helper is not set or not present. In the
> same method, the subprocess Popen will now redirect the stdout/stderr to
> logging.debug instead of writing to system stderr. As consequence, since
> the Popen.communicate() is now used (in order to get the stdout), the
> further call to wait() became redundant and was replaced by
> Popen.returncode.
> 
> The shutdown() message on negative exit code will now be logged
> to logging.warn instead of written to system stderr.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
