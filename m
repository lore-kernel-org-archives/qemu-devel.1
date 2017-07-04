Received: from eggs.gnu.org ([2001:4830:134:3::10]:50912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSMaw-00066a-9F
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSMat-0003h3-5j
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:06:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSMas-0003gh-Rm
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:06:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64C4cY2091412
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 08:06:13 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j6b4ef-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 08:06:13 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 06:06:12 -0600
References: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 14:06:07 +0200
MIME-Version: 1.0
In-Reply-To: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <273fba7e-10c7-cef3-8d42-da9c8abf80d4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] s390: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.vnet.ibm.com, david@redhat.com

On 07/03/2017 01:48 PM, Viktor Mihajlovski wrote:
> The response for query-cpu-definitions didn't include the
> unavailable-features field, which is used by libvirt to figure
> out whether a certain cpu model is usable on the host.
> 
> The unavailable features are now computed by obtaining the host CPU
> model and comparing it against the known CPU models. The comparison
> takes into account the generation, the GA level and the feature
> bitmaps. In the case of a CPU generation/GA level mismatch
> a feature called "type" is reported to be missing.
> 
> As a result, the output of virsh domcapabilities would change
> from something like
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='unknown'>z10EC-base</model>
>       <model usable='unknown'>z9EC-base</model>
>       <model usable='unknown'>z196.2-base</model>
>       <model usable='unknown'>z900-base</model>
>       <model usable='unknown'>z990</model>
>  ...
> to
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='yes'>z10EC-base</model>
>       <model usable='yes'>z9EC-base</model>
>       <model usable='no'>z196.2-base</model>
>       <model usable='yes'>z900-base</model>
>       <model usable='yes'>z990</model>
>  ...
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Thanks applied.
