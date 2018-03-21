Received: from eggs.gnu.org ([2001:4830:134:3::10]:47202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eydoZ-0000F4-LR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eydoW-0000w2-Fi
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eydoW-0000vl-5K
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LDTWgE072915
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:29:59 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gupn7d0nn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:29:58 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 07:29:57 -0600
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 10:29:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
Content-Language: en-US
Message-Id: <4efcdcb9-d226-2d20-91ac-3365a4115c5d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/1] dump.c: allow fd_write_vmcore to
 return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>

Ping


On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
> v3:
> - added set_errg_errno() to all callers of fd_write_vmcore
> - changed patch subject to reflect what it is addressing now
> - link to previous version:
> http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02787.html
>
>
> Yasmin Beatriz (1):
>    dump.c: allow fd_write_vmcore to return errno on failure
>
>   dump.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
