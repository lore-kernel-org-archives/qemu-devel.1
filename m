Received: from eggs.gnu.org ([2001:4830:134:3::10]:54663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYZD-0004Jc-Ff
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYZ9-0000SR-Jt
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34834
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYZ9-0000SG-DX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27Cp9wL114711
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:53:06 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjf8eb7c6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:53:06 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:53:04 -0700
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180306144818.GJ31045@stefanha-x1.localdomain>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 07:53:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180306144818.GJ31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5b45670d-2e0f-6ff0-ac9a-100cd979a3b8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Convert the TPM code to use tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 03/06/2018 09:48 AM, Stefan Hajnoczi wrote:
> On Sun, Mar 04, 2018 at 04:56:22PM -0500, Stefan Berger wrote:
>> This series of patches converts the TPM code to use tracing rather
>> than the #define DEBUG_XYZ type of debugging.
>>
>> Regards,
>>     Stefan
>>
>> Stefan Berger (5):
>>    tpm: convert tpm_crb.c to use trace-events
>>    tpm: convert tpm_passthrough.c to use trace-events
>>    tpm: convert tpm_util.c to use trace-events
>>    tpm: convert tpm_emulator.c to use trace-events
>>    tpm: convert tpm_tis.c to use trace-events
>>
>>   Makefile.objs            |  1 +
>>   hw/tpm/tpm_crb.c         | 17 +++------
>>   hw/tpm/tpm_emulator.c    | 45 +++++++++++-----------
>>   hw/tpm/tpm_passthrough.c | 13 ++-----
>>   hw/tpm/tpm_tis.c         | 98 ++++++++++++++++++++++--------------------------
>>   hw/tpm/tpm_util.c        | 29 ++++++--------
>>   hw/tpm/trace-events      | 46 +++++++++++++++++++++++
>>   7 files changed, 135 insertions(+), 114 deletions(-)
>>   create mode 100644 hw/tpm/trace-events
>>
>> -- 
>> 2.5.5
>>
>>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks all!


     Stefan
