Received: from eggs.gnu.org ([2001:4830:134:3::10]:55932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoXJ6-00078x-BA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoXJ2-0002Mz-DM
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:31:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eoXJ2-0002MN-9a
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:31:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 927DCEAEB8
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 16:31:39 +0000 (UTC)
References: <1519208316-18812-1-git-send-email-thuth@redhat.com>
	<1519208316-18812-6-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc22fb8d-61db-f977-252b-9527bea8213c@redhat.com>
Date: Wed, 21 Feb 2018 10:31:34 -0600
MIME-Version: 1.0
In-Reply-To: <1519208316-18812-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] net: Remove the deprecated way of
 dumping network packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/21/2018 04:18 AM, Thomas Huth wrote:
> "-net dump" has been marked as deprecated since QEMU v2.10, since it
> only works with the deprecated 'vlan' parameter (or hubs). Network
> dumping should be done with "-object filter-dump" nowadays instead.
> Since nobody complained so far about the deprecation message, let's
> finally get rid of "-net dump" now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
