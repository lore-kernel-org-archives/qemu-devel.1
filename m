Received: from eggs.gnu.org ([2001:4830:134:3::10]:56797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4Di-0005Tu-G5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4Dd-0003O7-Vu
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:08:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4Dd-0003N2-Q5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:08:05 -0400
Date: Tue, 5 Sep 2017 11:07:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905030759.GM22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-11-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-11-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 10/13] qemu.py: use poll() instead of
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
> The 'returncode' Popen attribute is not guaranteed to be updated. It
> actually depends on a call to either poll(), wait() or communicate().
> 
> On the other hand, poll() will: "Check if child process has terminated.
> Set and return returncode attribute."
> 
> Let's use the poll() to check whether the process is running and to get
> the updated process exit code, when the process is finished.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
