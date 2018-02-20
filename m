Received: from eggs.gnu.org ([2001:4830:134:3::10]:35556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoCnb-0002uF-VW
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoCnZ-00069H-DK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:37:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoCnZ-00067w-8q
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:37:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C11CB818532A
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 18:37:36 +0000 (UTC)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-9-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55a10378-b99f-f73c-3162-55dcf023453b@redhat.com>
Date: Tue, 20 Feb 2018 19:37:22 +0100
MIME-Version: 1.0
In-Reply-To: <1519148406-15006-9-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qemu-doc: Make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20/02/2018 18:40, Thomas Huth wrote:
> "-net" is clearly a legacy option. Yet we still use it in almost all
> examples in the qemu documentation, and many other spots in the network
> chapter. We should make it less prominent that users are not lured into
> using it so often anymore. So instead of starting the network chapter with
> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
> everywhere, all the "-net" related documentation is now moved to the end
> of the chapter. And the examples are changed to use the "--device" and
> "--netdev" options instead of "-net nic -net <backend>".

Do we want to change them to "-nic" instead?  The proof is in the
pudding, they say, :) and "-nic" is way easier to learn than "-device
-netdev".

And maybe we *should* go the extra mile and deprecate "-net" altogether.
 The only case where the newer syntax is a bit more uncomfortable is for
"-net nic -net nic -net tap|user", which however does work with "-nic
hubport -nic hubport -netdev tap|user,id=x -netdev hubport,netdev=x".

For now I suggest dropping this patch.

Paolo
