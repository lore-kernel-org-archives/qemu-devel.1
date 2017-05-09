Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d8AFo-0006QQ-C6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d8AFi-0002At-CE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1d8AFi-00026U-5t
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AABE3D957
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 18:52:52 +0000 (UTC)
Date: Tue, 9 May 2017 14:52:50 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1833628273.9365810.1494355970259.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170509184900.GI2089@work-vm>
References: <20170509184900.GI2089@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] VhostUserRequest # 20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: maxime coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org

HI

----- Original Message -----
> Hi,
>   libvhost-user.h defines:
>    VHOST_USER_INPUT_GET_CONFIG = 20,

That slipped by mistake from my vhost-user-input series WIP, please send a fix.
(luckily, this is only internal header for now)

thanks

> while
>   vhost-user.c defines:
>    VHOST_USER_NET_SET_MTU = 20,
> 
> who wins?
> 
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
