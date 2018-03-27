Received: from eggs.gnu.org ([2001:4830:134:3::10]:60786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f0koy-0002hu-QC
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f0kou-0000KC-Nd
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:23:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59936
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f0kou-0000JZ-Hr
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:23:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2R9IqUk006491
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 05:23:07 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gyk2h0jdb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 05:23:07 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 27 Mar 2018 10:23:05 +0100
References: <20180327013620.1644387-1-eblake@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Mar 2018 11:23:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180327013620.1644387-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b677f5b5-d81d-ce47-7f2b-9add4aef6edb@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Monitor: OOB related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, marcandre.lureau@redhat.com



On 03/27/2018 03:36 AM, Eric Blake wrote:
> This is patches 2, 3, 7, and 8 (with 7 rewritten) from Peter Xu's
> series.  I've pushed them to git://repo.or.cz/qemu/ericb.git qapi-next

that branch seems to work fine. (no make check or iotest regression on s390)





> (on top of the other pending qapi patches at branch qapi); hopefully
> this will be part of my pull request tomorrow for -rc1.
> 
> Eric Blake (1):
>   tests: Add parameter to qtest_init_without_qmp_handshake
> 
> Peter Xu (3):
>   qmp: cleanup qmp queues properly
>   monitor: new parameter "x-oob"
>   tests: qmp-test: add test for new "x-oob"
> 
>  tests/libqtest.h          |  7 +++-
>  include/monitor/monitor.h |  1 +
>  vl.c                      |  5 +++
>  tests/libqtest.c          | 10 +++--
>  monitor.c                 | 94 ++++++++++++++++++++++++++++++++++++-----------
>  tests/qmp-test.c          | 84 +++++++++++++++++++++++++++++++++++++++++-
>  6 files changed, 173 insertions(+), 28 deletions(-)
> 
