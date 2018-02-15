Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKud-0005Pq-B4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKuc-0003wv-Gp
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:53:27 -0500
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518690027-31318-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<3b41b0f0-09cf-9e43-bfa4-617335d76584@redhat.com>
	<50053a43-4905-9609-9be3-8418f1978465@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cded2e23-fa97-0a11-c30c-9c6b79088fcf@redhat.com>
Date: Thu, 15 Feb 2018 08:53:23 -0600
MIME-Version: 1.0
In-Reply-To: <50053a43-4905-9609-9be3-8418f1978465@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/15/2018 08:40 AM, Viktor Mihajlovski wrote:
> On 15.02.2018 15:19, Eric Blake wrote:
>> On 02/15/2018 04:20 AM, Viktor Mihajlovski wrote:
>>> From: Luiz Capitulino <lcapitulino@redhat.com>
>>>
>>> The query-cpus command has an extremely serious side effect:
>>> it always interrupts all running vCPUs so that they can run
>>> ioctl calls. This can cause a huge performance degradation for
>>> some workloads. And most of the information retrieved by the
>>> ioctl calls are not even used by query-cpus.
>>>
>>> This commit introduces a replacement for query-cpus called

>> You know, we have no back-compat guarantees on HMP.=C2=A0 We could mak=
e 'info
>> cpu' just ALWAYS call query-cpus-fast, with no HMP counterpart for the
>> slower query-cpus, and without needing a deprecation period.=C2=A0 But=
 I'll
>> leave that up to David if that makes more sense.
> Ditching info cpus_fast would make me happy as well, because it would
> cause less headache on the libvirt side of things.

Why is libvirt using HMP in the first place?  Libvirt should always be=20
using the QMP command, when one exists.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
