Received: from eggs.gnu.org ([2001:4830:134:3::10]:39916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmrl-0002Jz-PE
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1enmri-0000WI-OG
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:56:29 -0500
Date: Mon, 19 Feb 2018 15:56:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180219155621.3c146fe9.cohuck@redhat.com>
In-Reply-To: <1518797321-28356-3-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-3-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On Fri, 16 Feb 2018 17:08:38 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

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
>  o Never interrupt vCPUs threads. query-cpus-fast only returns
>    vCPU information maintained by QEMU itself, which should be
>    sufficient for most management software needs
> 
>  o Drop "halted" field as it can not be retrieved in a fast
>    way on most architectures
> 
>  o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>  o Rename some fields for better clarification & proper naming
>    standard
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  cpus.c           | 38 ++++++++++++++++++++++++++++++
>  qapi-schema.json | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
