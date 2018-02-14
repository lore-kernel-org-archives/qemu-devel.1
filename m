Received: from eggs.gnu.org ([2001:4830:134:3::10]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eltOu-0003di-E6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eltOo-00009c-Jl
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:30:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eltOo-00006v-BO
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:30:46 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1E9UYMP098053
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:30:45 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4eqe0dw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 04:30:44 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 14 Feb 2018 09:30:40 -0000
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-2-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Feb 2018 10:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <1518542328-25741-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <133f597f-283e-9b86-34df-7a2ada5faa6c@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv2 1/3] qmp: expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com



On 02/13/2018 06:18 PM, Viktor Mihajlovski wrote:
> Presently s390x is the only architecture not exposing specific
> CPU information via QMP query-cpus. Upstream discussion has shown
> that it could make sense to report the architecture specific CPU
> state, e.g. to detect that a CPU has been stopped.
> 
> With this change the output of query-cpus will look like this on
> s390:
> 
>    [
>      {"arch": "s390", "current": true,
>       "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>       "qom_path": "/machine/unattached/device[0]",
>       "halted": false, "thread_id": 63115},
>      {"arch": "s390", "current": false,
>       "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>       "qom_path": "/machine/unattached/device[1]",
>       "halted": true, "thread_id": 63116}
>    ]
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Acked-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
