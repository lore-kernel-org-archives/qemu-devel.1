Received: from eggs.gnu.org ([2001:4830:134:3::10]:45371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fg4hG-0004dq-Bl
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fg4hD-0005Pe-9D
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:54:02 -0400
References: <1527751702-15452-1-git-send-email-wangyunjian@huawei.com>
	<cc72837f-70c3-5c2e-55c3-d1fe20380e72@redhat.com>
	<153193157775.25234.15329587771745338735@sif>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6cde2d66-29cc-e8d4-c038-f494f093e7de@redhat.com>
Date: Thu, 19 Jul 2018 16:53:52 +0800
MIME-Version: 1.0
In-Reply-To: <153193157775.25234.15329587771745338735@sif>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] tap: fix memory leak on
 success to create a tap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, wangyunjian <wangyunjian@huawei.com>
Cc: caihe@huawei.com, qemu-stable@nongnu.org



On 2018=E5=B9=B407=E6=9C=8819=E6=97=A5 00:32, Michael Roth wrote:
> Quoting Jason Wang (2018-05-31 04:46:05)
>> On 2018=E5=B9=B405=E6=9C=8831=E6=97=A5 15:28, wangyunjian wrote:
>>> From: Yunjian Wang<wangyunjian@huawei.com>
>>>
>>> The memory leak on success to create a tap device. And the nfds and
>>> nvhosts may not be the same and need to be processed separately.
>>>
>>> Fixes: 07825977 ("tap: fix memory leak on failure to create a multiqu=
eue tap device")
>>> Fixes: 264986e2 ("tap: multiqueue support")
>>>
>>> CC: QEMU Stable<qemu-stable@nongnu.org>
>>> Signed-off-by: Yunjian Wang<wangyunjian@huawei.com>
>>> ---
>>> v2:
>>>    -add commit log and cc qemu-stable with fixes tags
>>> ---
>> Applied.
> It looks like this hasn't made its way to master yet. Is a pull request
> still planned?
>

Fall through cracks unfortuately. It will be included in the next pull=20
request.

Thanks
