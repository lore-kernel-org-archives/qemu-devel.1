Received: from eggs.gnu.org ([2001:4830:134:3::10]:51725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Lja-0008VH-Gk
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3LjU-0001Q4-Ub
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:07:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3LjU-0001Of-Kw
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:07:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QC3o7V031553
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:07:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebxg2p7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:07:43 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 08:07:42 -0400
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
	<20170426110144.GF2098@work-vm>
	<cbf8c55d-9473-9f6f-eb89-779afe7c1fd2@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 14:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <cbf8c55d-9473-9f6f-eb89-779afe7c1fd2@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <cec279c5-9900-ca28-103b-b95c36d9d989@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 04/26/2017 01:45 PM, Christian Borntraeger wrote:

>> Hmm, I have a theory, if the flags field has bit 1 set, i.e. RAM_SAVE_FLAG_COMPRESS
>> then try changing ram_handle_compressed to always do the memset.
> 
> FWIW, changing ram_handle_compressed to always memset makes the problem go away.

It is still running fine now with the "always memset change"
