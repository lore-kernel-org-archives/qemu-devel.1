Received: from eggs.gnu.org ([2001:4830:134:3::10]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dDXDZ-0008TH-Bh
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dDXDU-0000Ty-6u
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42115
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dDXDT-0000T7-TT
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:24:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OEOa7W034281
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:24:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2an22kwaf5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:24:46 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 24 May 2017 08:24:45 -0600
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
	<1494921494-33717-4-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 10:24:40 -0400
MIME-Version: 1.0
In-Reply-To: <1494921494-33717-4-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <71929ed1-ca7a-36c7-ff0d-cf61ff3bab88@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/8] tpm-backend: Initialize and free
 data members in it's own methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 05/16/2017 03:58 AM, Amarnath Valluri wrote:
> Initialize and free TPMBackend data members in it's own instance_init() and
> instance_finalize methods.
>
> Took the opportunity to remove unneeded destroy() method from TpmDriverOps
> interface as TPMBackend is a Qemu Object, we can use object_unref() inplace of
> tpm_backend_destroy() to free the backend object, hence removed destroy() from
> TPMDriverOps interface.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
