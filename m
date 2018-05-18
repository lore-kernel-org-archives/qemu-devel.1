Received: from eggs.gnu.org ([2001:4830:134:3::10]:40360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZP0-0007Fc-8Q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZOw-0000VO-C4
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:02:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJZOw-0000Us-7Q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA96781FE164
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:02:04 +0000 (UTC)
Date: Fri, 18 May 2018 09:02:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518070203.lve7dobl2gnuqk7n@sirius.home.kraxel.org>
References: <cb05bb1909daa6ba62145c0194aafa05a14ed3d1.1526569138.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb05bb1909daa6ba62145c0194aafa05a14ed3d1.1526569138.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] console: Avoid segfault in screendump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

>  
>      graphic_hw_update(con);
>      surface = qemu_console_surface(con);
> +    if (!surface) {
> +        error_setg(errp, "no surface");
> +        return;
> +    }
> +

Added to ui queue.

thanks,
  Gerd
