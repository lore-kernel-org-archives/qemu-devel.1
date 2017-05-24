Received: from eggs.gnu.org ([2001:4830:134:3::10]:43862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dDX8n-0005L9-D2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dDX8i-0000QM-EM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dDX8i-0000OO-3b
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:19:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OEE8m5049669
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:19:50 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amxxkk9p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 10:19:50 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 24 May 2017 10:19:49 -0400
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
	<1494921494-33717-3-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 10:19:47 -0400
MIME-Version: 1.0
In-Reply-To: <1494921494-33717-3-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <6a3ab9ec-33bf-74dc-7ae9-575e42112421@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/8] tpm-backend: Move thread handling
 inside TPMBackend
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
> Move thread handling inside TPMBackend, this way backend implementations need
> not to maintain their own thread life cycle, instead they needs to implement
> 'handle_request()' class method that always been called from a thread.
>
> This change made tpm_backend_int.h kind of useless, hence removed it.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
