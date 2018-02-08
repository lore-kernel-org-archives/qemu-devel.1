Received: from eggs.gnu.org ([2001:4830:134:3::10]:55805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejt41-0001aD-Dg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejt3y-00025e-BW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:45:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejt3y-00025M-7H
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:44:58 -0500
References: <1518108236-20081-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86184864-0d03-c059-f1bd-3b02a6125925@redhat.com>
Date: Thu, 8 Feb 2018 14:44:50 -0600
MIME-Version: 1.0
In-Reply-To: <1518108236-20081-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 02/08/2018 10:43 AM, Viktor Mihajlovski wrote:
> Presently s390x is the only architecture not exposing specific
> CPU information via QMP query-cpus. Upstream discussion has shown
> that it could make sense to report the architecture specific CPU
> state, e.g. to detect that a CPU has been stopped.
> 
> With this change the output of query-cpus will look like this on
> s390:
> 
>     [
>       {"arch": "s390", "current": true,
>        "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>        "qom_path": "/machine/unattached/device[0]",
>        "halted": false, "thread_id": 63115},
>       {"arch": "s390", "current": false,
>        "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,


So the addition here is the "cpu-state" member.

QAPI changes are fine; I didn't look at the corresponding code, though, 
so you may add the weaker:

Acked-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
