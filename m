Received: from eggs.gnu.org ([2001:4830:134:3::10]:51679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuEZE-0002qN-RD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuEZ9-00014S-Sb
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuEZ9-00014J-Lj
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:16:11 -0400
Date: Mon, 27 Aug 2018 12:16:09 +0200
From: "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
References: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: toggle for lock keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Aug 23, 2018 at 01:23:20AM +0000, Ryan El Kochta wrote:
> This patch introduces three new options on the input-linux commandline:
> 
> (a) ignore_caps_lock=[on|off]
> (b) ignore_num_lock=[on|off]
> (c) ignore_scroll_lock=[on|off]
> 
> If enabled, the key will be disabled and not forwarded to the guest.
> There are two main reasons for this:
> 
> (a) Without keyboard LEDs, it can be difficult to tell whether it is
> enabled or not
> (b) Preparation for another patch which will allow changing the keys
> used to toggle the input device's grab. If you set the key to
> KEY_SCROLLLOCK for example, it can be frustrating disabling scroll lock
> in the guest, as it will require pressing the key more than twice.

Hmm.  You have the same issue on the host, right?

For the guest we can easily filter out the key events.
For the host we can't.  This is the reason I picked a
key combination which has no side effects to switch
between host and guest.  And for the same reason I don't
think it is useful to allow the user to specify arbitrary
key combinations.

Which combination do you want use instead of leftshift + rightshift?

cheers,
  Gerd
