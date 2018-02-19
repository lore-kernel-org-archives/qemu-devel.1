Received: from eggs.gnu.org ([2001:4830:134:3::10]:48705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enoiJ-0003WT-8g
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enoiF-0003Yr-6A
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:54:51 -0500
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28622fb4-6e72-c7f8-93a5-871f0dccac82@redhat.com>
Date: Mon, 19 Feb 2018 10:54:29 -0600
MIME-Version: 1.0
In-Reply-To: <1518797321-28356-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 2/5] qmp: add query-cpus-fast
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

On 02/16/2018 10:08 AM, Viktor Mihajlovski wrote:
> From: Luiz Capitulino <lcapitulino@redhat.com>
> 
> The query-cpus command has an extremely serious side effect:
> it always interrupts all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>   o Never interrupt vCPUs threads. query-cpus-fast only returns
>     vCPU information maintained by QEMU itself, which should be
>     sufficient for most management software needs
> 
>   o Drop "halted" field as it can not be retrieved in a fast
>     way on most architectures
> 
>   o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>   o Rename some fields for better clarification & proper naming
>     standard
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>   cpus.c           | 38 ++++++++++++++++++++++++++++++
>   qapi-schema.json | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
