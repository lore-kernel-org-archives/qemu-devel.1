Received: from eggs.gnu.org ([2001:4830:134:3::10]:41411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eb1M0-00029m-1L
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eb1Lw-0005YV-V3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eb1Lw-0005Ws-LT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0F9jViw091439
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:46:50 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgm7ymetv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:46:49 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 02:46:48 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
References: <20171205133508.15061-1-danielhb@linux.vnet.ibm.com>
	<34e2e5fd-ed31-ebcd-e610-10ef62557aca@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 07:46:41 -0200
MIME-Version: 1.0
In-Reply-To: <34e2e5fd-ed31-ebcd-e610-10ef62557aca@linux.vnet.ibm.com>
Content-Language: en-US
Message-Id: <06809f02-dd3a-bbf8-cec1-016367e01e71@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>

Ping

On 01/02/2018 11:04 AM, Daniel Henrique Barboza wrote:
> Hi there,
>
> I saw that new iotests were added upstream and decided to re-sent this=20
> patch, but
> then I noticed that the files being created by this patch (201 and=20
> 201.out) weren't
> created upstream - we have 200 and then 202 and 203.
>
> Is this patch queued somewhere to be added or should I re-send it anywa=
y?
>
>
> Thanks,
>
>
> Daniel
>
>
> On 12/05/2017 11:35 AM, Daniel Henrique Barboza wrote:
>> Changes from v4:
>> - added a 'refcount_bits=3D1' constraint for internal snapshots
>>
>> Changes from v3:
>> - rebased with master - file name changed from 198 to 201
>> - removed Creator/owner information (it can be retrieved with git)
>> - added a migration successful check before executing savevm
>> - removed a trailing double comma in the snapshot name
>>
>> Daniel Henrique Barboza (1):
>> =C2=A0=C2=A0 tests/qemu-iotests: adding savevm/loadvm with postcopy fl=
ag test
>>
>> =C2=A0 tests/qemu-iotests/201=C2=A0=C2=A0=C2=A0=C2=A0 | 120=20
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/201.out |=C2=A0 23 +++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 144 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/201
>> =C2=A0 create mode 100644 tests/qemu-iotests/201.out
>>
>
>
