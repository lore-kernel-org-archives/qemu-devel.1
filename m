Received: from eggs.gnu.org ([2001:4830:134:3::10]:41161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT4lG-00008y-DT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT4lD-0001YV-79
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:20:26 -0400
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-2-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4b86190-1f16-758b-448f-b3766327d635@redhat.com>
Date: Wed, 13 Jun 2018 07:20:20 -0500
MIME-Version: 1.0
In-Reply-To: <1528866321-23886-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] Replace '-machine accel=xyz' with
 '-accel xyz'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, zhang.zhanghailiang@huawei.com

On 06/13/2018 12:05 AM, Thomas Huth wrote:
> We've got a separate option to configure the accelerator nowadays.
> Use it in the source and examples to demonstrate that this is the
> preferred way of setting this option now.

Is it worth bike-shedding the preferred spelling as '--accel xyz', to 
match 
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation?

It's more important to use double-dash for options shared between 
binaries, but qemu-nbd and qemu-img don't use --accel, so that makes the 
argument slightly weaker for the doubled form here.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
