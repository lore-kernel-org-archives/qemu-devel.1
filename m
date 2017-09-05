Received: from eggs.gnu.org ([2001:4830:134:3::10]:56382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4D2-0004sA-Vl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4Cy-0002uG-F1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4Cy-0002u3-8u
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:07:24 -0400
Date: Tue, 5 Sep 2017 11:07:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905030719.GL22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-10-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-10-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/13] qemu.py: always cleanup on
 shutdown()
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
> Currently we only cleanup on shutdown() if the VM is running.
> 
> To make sure we will always cleanup, this patch makes the cleanup to
> always happen in shutdown, regardless the VM running state.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
