Received: from eggs.gnu.org ([2001:4830:134:3::10]:37038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e08Yy-0007eN-NE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e08Yx-0005d2-UD
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e08Yx-0005bs-OH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4C98C0587FE
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:59:50 +0000 (UTC)
Message-ID: <1507219188.6131.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 05 Oct 2017 17:59:48 +0200
In-Reply-To: <24a93e2e-be18-c6f1-ee6c-18acba5fee53@redhat.com>
References: <20171005153330.19210-1-kraxel@redhat.com>
	<24a93e2e-be18-c6f1-ee6c-18acba5fee53@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] update keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > If you want play with the new qemu-keymap tool you should apply
> > this
> > series on top of daniel's keycodemapdb patch series.
> 
> Let's tell that to patchew:
> 
> Based-on:
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00918.html
> ([PULL 0/6] Ui 20171005 patches)

Well, it's not *that* kind of dependency.  It'll apply and build just
fine on master branch.

But qemu-keymap will generate more complete maps because the evdev to
qkeycode mapping has more entries with Dan's series applied.

Could even be that qemu-keymap will throw an assert() when applied on
master due to missing mappings (didn't test that though).

cheers,
  Gerd
