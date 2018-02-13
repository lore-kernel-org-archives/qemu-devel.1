Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elYZz-0003bc-IR
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elYZy-0000qa-M4
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:16:55 -0500
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212130301.1714d393@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5b46d287-cc8a-4d84-cbb4-d6d45e60135b@redhat.com>
Date: Tue, 13 Feb 2018 12:16:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180212130301.1714d393@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] qmp: expose s390-specific
 CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: agraf@suse.de, berrange@redhat.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, rth@twiddle.net

On 12.02.2018 19:03, Luiz Capitulino wrote:
> On Mon, 12 Feb 2018 13:14:30 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> Presently s390x is the only architecture not exposing specific
>> CPU information via QMP query-cpus. Upstream discussion has shown
>> that it could make sense to report the architecture specific CPU
>> state, e.g. to detect that a CPU has been stopped.
>>
>> With this change the output of query-cpus will look like this on
>> s390:
>>
>>    [
>>      {"arch": "s390", "current": true,
>>       "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
>>       "qom_path": "/machine/unattached/device[0]",
>>       "halted": false, "thread_id": 63115},
>>      {"arch": "s390", "current": false,
>>       "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
>>       "qom_path": "/machine/unattached/device[1]",
>>       "halted": true, "thread_id": 63116}
>>    ]
> 
> We're adding the same information to query-cpus-fast. Why do we
> need to duplicate this into query-cpus? Do you plan to keep using
> query-cpus? If yes, why?

Wonder if we could simply pass a flag to query-cpus "fast=true", that
makes it behave differently. (either not indicate the critical values or
simply provide dummy values - e.g. simply halted=false)

> 
> Libvirt for one, should move away from it. We don't want to run
> into the risk of having the same issue we had with x86 in other
> archs.
> 
>>


-- 

Thanks,

David / dhildenb
