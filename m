Received: from eggs.gnu.org ([208.118.235.92]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecjo9-0007X3-Te
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 22:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecjnK-0002Zw-7s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 22:27:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51574
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ecjnJ-0002Xd-TE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 22:26:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0K3OPhP111774
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 22:26:12 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkstcxsqq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 22:26:12 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 20:26:11 -0700
References: <0919c2ab-1a62-f96c-1847-d6f95d3326f3@linux.vnet.ibm.com>
	<20180120020557.GA20269@flamenco>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 22:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180120020557.GA20269@flamenco>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <affc653a-f8cc-2645-e402-6bb355a2e393@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] Double-free due to e5dc1a6c6c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 01/19/2018 09:05 PM, Emilio G. Cota wrote:
> On Fri, Jan 19, 2018 at 17:55:27 -0500, Stefan Berger wrote:
>> I get double-free memory errors when QEMU terminates due to commit
>> e5dc1a6c6c.
>>
>> The way to reproduce the error is to 1st do a 'system_reset' in the monitor
>> and then get into the grub console and do a 'halt' there.
> Can you please check whether this is fixed by the patch below?
> Was posted yesterday on the list, should be on master soon.
>
>    https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04298.html

Yes, fixes it for me.

    Stefan

>
> Thanks,
>
> 		Emilio
>
