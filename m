Received: from eggs.gnu.org ([2001:4830:134:3::10]:59247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evM9Z-0007ra-Mf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evM9V-0002gt-3F
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:02:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evM9U-0002eb-VI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:02:05 -0400
References: <20180309090006.10018-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5782600-6a2f-0548-2d33-a1d70283403a@redhat.com>
Date: Mon, 12 Mar 2018 07:01:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/23] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>"Daniel P. Berrange" <berrange@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> Based-on: <20180306053320.15401-1-peterx@redhat.com>
> 
> The series is based on the following series:
> 
>    [PATCH v2 0/9] chardev: qio related non-default context support
>    (actually patch 9 is based on version 2.1, Dan's version)

I see Dan already submitted a pull request for (some of) your qio work; 
see commit 3ef91576.  Are there any more outstanding qio patches that 
have to land first?

> 
> This series was born from this one:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html
> 
> The idea comes from Markus Armbruster and the discussion we had in the
> thread.  It's not a super ideal solution (I believe Markus had been
> thinking hard to keep everything in order meanwhile trying to satisfy
> the migration requirement), but AFAIU it's currently the best.
> 
> What is OOB?
> ============
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
