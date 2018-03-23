Received: from eggs.gnu.org ([2001:4830:134:3::10]:40316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezM4G-0004BP-3Z
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezM4C-0008Ay-Ue
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:45:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezM47-000878-L0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:45:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2NCipIu044490
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:45:02 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gvy66et0n-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:45:01 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 12:44:59 -0000
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-21-peterx@redhat.com>
	<1bd08e1d-b6ff-6b39-e053-599bddd1a208@de.ibm.com>
	<20180323122538.GN32362@xz-mi>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 13:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180323122538.GN32362@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <332a9ef5-549a-d329-ec5e-d68609b1fbe1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for
 (qmp & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>



On 03/23/2018 01:25 PM, Peter Xu wrote:
> On Fri, Mar 23, 2018 at 01:10:51PM +0100, Christian Borntraeger wrote:
>> As Max Reitz said, this breaks several qemu iotests. I can reproduce that on s390
>> e.g. with ./check -qcow2 030 in the qemu-iotest.
>>
>> Why was this merged?
> 
> My fault.  Sorry.  I should have done iotests before submission.
> 
> Now I'm trying to fix those iotest issues.
> 
> I'm not extremely familiar with block, so the progress is a bit slow,
> but I'll do it asap (though I'll possibly need some help from the
> block team, since there are some not-easy ones for me).

As this patch also seems to trigger something else for Eric, can we revert this
patch for the time being and re-apply as soon as we have solutions for the issues?

After all a hard hang in the iotest can break CI environments (as you run into timeouts).
