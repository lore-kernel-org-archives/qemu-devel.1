Received: from eggs.gnu.org ([2001:4830:134:3::10]:57573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcBMe-0000Ch-Bp
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcBMb-0006fH-5x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dcBMa-0006eY-VU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:08:05 -0400
Date: Mon, 31 Jul 2017 11:07:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170731140749.GZ20793@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170731085110.1050-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/7] qemu.py: use poll() instead of
 'returncode'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Mon, Jul 31, 2017 at 10:51:04AM +0200, Amador Pahim wrote:
> The 'returncode' Popen attribute is not guaranteed to be updated. It
> actually depends on a call to either poll(), wait() or communicate().
> 
> On the other hand, poll() will: "Check if child process has terminated.
> Set and return returncode attribute."
> 
> Let's use the poll() to check whether the process is running and also
> to get the updated process exit code, when the process is finished.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This breaks the current version of shutdown().  Assuming that
patch 6/7 will fix that (I didn't review patch 6/7 yet), this
needs to be moved to the end of the series.

-- 
Eduardo
