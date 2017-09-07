Received: from eggs.gnu.org ([2001:4830:134:3::10]:58352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dprxO-00010v-4m
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dprxK-0007rL-1o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dprxJ-0007ql-Ru
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBB1C883B6
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:14:32 +0000 (UTC)
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<20170907081131.GB4461@dhcp-200-186.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7eb83905-41cd-fa32-226c-0849d42bed04@redhat.com>
Date: Thu, 7 Sep 2017 10:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170907081131.GB4461@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

On 07.09.2017 10:11, Kevin Wolf wrote:
[...]
> But the real reason why I'm replying: Should we add changing the default
> to "kvm:tcg" to the list of planned 3.0 changes? I am part of the group
> that intentionally uses TCG occasionally, but I think the majority of
> users wants to use KVM (or whatever the fastest option is on their
> system) whenever it is available.

If you consider how often people are getting this wrong (they want to
use KVM but end up with TCG in the first try), I think that's a good idea.

Maybe we should start a Wiki page where we collect ideas for QEMU 3.0?

 Thomas
