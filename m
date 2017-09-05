Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp43b-0005q7-Ih
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp43W-0003vN-L2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp43W-0003vD-Ef
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:57:38 -0400
Date: Tue, 5 Sep 2017 10:57:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905025733.GE22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/13] qemu.py: fix is_running() return
 before first launch()
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
> is_running() returns None when called before the first time we
> call launch():
> 
>     >>> import qemu
>     >>> vm = qemu.QEMUMachine('qemu-system-x86_64')
>     >>> vm.is_running()
>     >>>
> 
> It should return False instead. This patch fixes that.
> 
> For consistence, this patch removes the parenthesis from the
> second clause as it's not really needed.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
