Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cij9d-0008Cu-Kz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cij9Y-0004o6-NM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cij9Y-0004nx-H0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:53:24 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8583F8FAD1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:53:23 +0000 (UTC)
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-6-git-send-email-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0494ff7b-b586-c011-3afa-bb20b33fb34b@redhat.com>
Date: Tue, 28 Feb 2017 15:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-6-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] enable -g command line switch for all
 archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 21.02.2017 23:14, Gerd Hoffmann wrote:
> Virtual display adapters will learn to use graphic_* variables
> (which are set by the -g switch), so enable this for all archs.
> 
> RfC:  Maybe restrict to PCI-capable archs?
>       Or would that be pretty much anything anyway?

I think there could also be systems without PCI, but with graphics card,
so limiting it to PCI-capable systems seems also wrong to me.

 Thomas
