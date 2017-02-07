Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Doug.Gilmore@imgtec.com>) id 1cbEGW-0008Uy-QX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Doug.Gilmore@imgtec.com>) id 1cbEGT-0007XE-N7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:29:36 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:65091)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Doug.Gilmore@imgtec.com>) id 1cbEGT-0007WQ-Gn
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:29:33 -0500
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
	by Forcepoint Email with ESMTPS id C5ACA3BCA2918
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 22:29:24 +0000 (GMT)
References: <20170204143245.15974-1-famz@redhat.com>
	<20170207151455.GH8583@stefanha-x1.localdomain>
From: Doug Gilmore <Doug.Gilmore@imgtec.com>
Message-ID: <982135c3-51c5-d6d4-d3f1-328ec766a07e@imgtec.com>
Date: Tue, 7 Feb 2017 14:25:31 -0800
MIME-Version: 1.0
In-Reply-To: <20170207151455.GH8583@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 02/07/2017 07:14 AM, Stefan Hajnoczi wrote:
> On Sat, Feb 04, 2017 at 10:32:45PM +0800, Fam Zheng wrote:
>> We install this file to data dir but since 0ab8ed18 it's no longer
>> required by any objects during "make". List it explicitly as a depended
>> target of install and fix the broken "make install" command.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing
> 
> Stefan
> 
Are there plans to commit this change?

AFAICS, ToT builds are broken without this change.

Thanks,

Doug
