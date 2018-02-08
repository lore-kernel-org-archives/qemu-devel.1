Received: from eggs.gnu.org ([2001:4830:134:3::10]:46505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejpfj-0006pb-KJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejpfe-0005Oz-Gw
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:07:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53606
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejpfe-0005Or-B6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:07:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18H4YLZ103559
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 12:07:37 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0stpthqs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:07:37 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 17:07:34 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
References: <1518108236-20081-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 18:07:31 +0100
MIME-Version: 1.0
In-Reply-To: <1518108236-20081-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <aadd8575-6bcb-d851-2d54-3143b9bf70df@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, armbru@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, dgilbert@redhat.com, Alexander Graf <agraf@suse.de>

On 08.02.2018 17:43, Viktor Mihajlovski wrote:
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
> ---
> 
> v1 -> v2:
>  - qapi-schema.json: fixed style issues, typos, improved enum naming
>  - hmp.c: added missing newline (printing cpu state)
> 
>  cpus.c                     |  6 ++++++
>  hmp.c                      |  4 ++++
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  qapi-schema.json           | 28 +++++++++++++++++++++++++++-
>  target/s390x/cpu.c         | 24 ++++++++++++------------
>  target/s390x/cpu.h         |  7 ++-----
>  target/s390x/kvm.c         |  8 ++++----
>  target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>  8 files changed, 75 insertions(+), 42 deletions(-)
> 

sorry, forgot to cc the maintainers
[...]

-- 
Regards,
 Viktor Mihajlovski
