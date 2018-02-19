Received: from eggs.gnu.org ([2001:4830:134:3::10]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enlVb-0004lx-3v
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enlVX-0001k3-6B
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:29:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1enlVX-0001jv-0A
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6F6B40363B6
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 13:29:14 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <544057ea-8e87-3aea-e2e0-8225212a7d9b@redhat.com>
Date: Mon, 19 Feb 2018 07:29:09 -0600
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8] Improvements and clean-ups related
 to -net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/19/2018 03:15 AM, Thomas Huth wrote:

> The last patch finally makes "-net" less prominent in our qemu docs,
> e.g. by replacing the examples that contain "-net" with "-netdev".

Minor request: while doing this, can we update the documentation to 
mention "--netdev" and "--n" everywhere we touch things?  See this for 
rationale:
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
