Received: from eggs.gnu.org ([2001:4830:134:3::10]:47786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eupjq-00025L-7t
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eupjm-0000ww-SA
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:25:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eupjm-0000v3-N3
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:25:22 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-11-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <037ab20b-0abc-0622-3d68-1093bc0ec8be@redhat.com>
Date: Sat, 10 Mar 2018 19:25:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-11-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 10/23] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> There were no QMP capabilities defined.  Define the first "oob" as
> capability to allow out-of-band messages.

Reads better as "Define the first capability, "oob", to allow..."

> 
> After this patch, we will allow QMP clients to enable QMP capabilities
> when sending the first "qmp_capabilities" command.  Originally we are
> starting QMP session with no arguments like:
> 
>    { "execute": "qmp_capabilities" }
> 
> Now we can enable some QMP capabilities using (take OOB as example,
> which is the only one capability that we support):
> 
>    { "execute": "qmp_capabilities",
>      "argument": { "enable": [ "oob" ] } }

s/argument/arguments/

> 
> When the "argument" key is not provided, no capability is enabled.

again.  Also when "arguments":{} is provided with an empty dict, or even 
with "arguments":{"enable":[]} an empty enable array.  But no need to 
mention them here.

> 
> For capability "oob", the monitor needs to be run on dedicated IO

s/on/on a/

> thread, otherwise the command will fail.  For example, trying to enable
> OOB on a MUXed typed QMP monitor will fail.
> 
> One thing to mention is that, QMP capabilities are per-monitor, and also

s/that,/that/

> when the connection is closed due to some reason, the capabilities will
> be reset.
> 
> Also, touch up qmp-test.c to test the new bits.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c        | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   qapi/misc.json   | 32 ++++++++++++++++++++---
>   tests/qmp-test.c | 10 +++++++-
>   3 files changed, 110 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
