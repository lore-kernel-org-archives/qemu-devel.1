Received: from eggs.gnu.org ([2001:4830:134:3::10]:50106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWMEu-0004FE-SB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWMEr-0005TS-Nh
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:04:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWMEr-0005Sj-Ea
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:04:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w02D3jKD098195
	for <qemu-devel@nongnu.org>; Tue, 2 Jan 2018 08:04:14 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f86s1r92h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:04:14 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 2 Jan 2018 06:04:13 -0700
References: <20171205133508.15061-1-danielhb@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 2 Jan 2018 11:04:05 -0200
MIME-Version: 1.0
In-Reply-To: <20171205133508.15061-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <34e2e5fd-ed31-ebcd-e610-10ef62557aca@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/1] savevm/loadvm with postcopy flag
 qemu-iotest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

Hi there,

I saw that new iotests were added upstream and decided to re-sent this 
patch, but
then I noticed that the files being created by this patch (201 and 
201.out) weren't
created upstream - we have 200 and then 202 and 203.

Is this patch queued somewhere to be added or should I re-send it anyway?


Thanks,


Daniel


On 12/05/2017 11:35 AM, Daniel Henrique Barboza wrote:
> Changes from v4:
> - added a 'refcount_bits=1' constraint for internal snapshots
>
> Changes from v3:
> - rebased with master - file name changed from 198 to 201
> - removed Creator/owner information (it can be retrieved with git)
> - added a migration successful check before executing savevm
> - removed a trailing double comma in the snapshot name
>
> Daniel Henrique Barboza (1):
>    tests/qemu-iotests: adding savevm/loadvm with postcopy flag test
>
>   tests/qemu-iotests/201     | 120 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/201.out |  23 +++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 144 insertions(+)
>   create mode 100755 tests/qemu-iotests/201
>   create mode 100644 tests/qemu-iotests/201.out
>
