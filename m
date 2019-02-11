Received: from eggs.gnu.org ([209.51.188.92]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtIth-0005x1-8k
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtItg-0002VJ-Lx
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:13:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtItg-0002Um-AS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:13:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1BL2bVn119928
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:13:45 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qkenr5bsn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:13:45 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 11 Feb 2019 21:13:44 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
	<0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 11 Feb 2019 16:13:41 -0500
MIME-Version: 1.0
In-Reply-To: <0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 2/11/19 3:09 PM, Liam Merwick wrote:
>
>
> I'd come up the attached change (but that seems like overkill).


I don't think we need tracing for this.
