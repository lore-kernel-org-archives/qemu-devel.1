Received: from eggs.gnu.org ([2001:4830:134:3::10]:47443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIksr-00028R-AN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 21:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIkso-00065x-6L
	for qemu-devel@nongnu.org; Tue, 15 May 2018 21:05:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44976
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fIkso-00064n-0R
	for qemu-devel@nongnu.org; Tue, 15 May 2018 21:05:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4G14YbR046152
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 21:05:33 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j05mnc1sj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 21:05:32 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 15 May 2018 21:05:32 -0400
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<7bd9074b-04ca-49f6-096b-808d36e4e8b0@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Wed, 16 May 2018 09:05:25 +0800
MIME-Version: 1.0
In-Reply-To: <7bd9074b-04ca-49f6-096b-808d36e4e8b0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <10b8b3ae-eeb4-1f05-86bb-65bd4458cbfe@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, fiuczy@linux.ibm.com, jtomko@redhat.com, borntraeger@de.ibm.com, jferlan@redhat.com



=E5=9C=A8 2018/5/15 =E4=B8=8B=E5=8D=8811:25, Eric Blake =E5=86=99=E9=81=93=
:
> On 05/15/2018 06:33 AM, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>> compiled. This would make libvirt set the corresponding capability and
>> then trigger the guest startup fails. So this patch excludes the code
>
> s/trigger the guest startup fails/trigger failure during guest startup/
>
>> regarding seccomp staff if CONFIG_SECCOMP is undefined.
>
> s/staff/command line options/
>
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>> =C2=A0 vl.c | 13 ++++++++-----
>> =C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)
>>
>
> A maintainer can touch up the commit message, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
Thanks for your comments! Have updated commit msg.
