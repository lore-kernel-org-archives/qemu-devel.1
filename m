Received: from eggs.gnu.org ([2001:4830:134:3::10]:38445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDObY-00068d-1P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDObT-00007G-Ap
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gDObS-000057-Mj
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B31C390C78
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:49:45 +0000 (UTC)
Date: Fri, 19 Oct 2018 08:49:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181019064944.wcann4ysqcg65z5t@sirius.home.kraxel.org>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-26-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-26-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 25/38] ui/keymaps: Fix handling of
 erroneous include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 17, 2018 at 10:26:49AM +0200, Markus Armbruster wrote:
> While errors in the keyboard layout named with -k are fatal, errors in
> included files are reported, but otherwise ignored:
> 
>     $ cat worst
>     include bad
>     include worse
>     $ ls -l bad worse
>     ls: cannot access 'bad': No such file or directory
>     ls: cannot access 'worse': No such file or directory
>     $ qemu-system-x86_64 -nodefaults -S -monitor stdio -display vnc=:0 -k bad
>     QEMU 3.0.50 monitor - type 'help' for more information
>     (qemu) Could not read keymap file: 'bad'
>     $ qemu-system-x86_64 -nodefaults -S -monitor stdio -display vnc=:0 -k worst
>     QEMU 3.0.50 monitor - type 'help' for more information
>     (qemu) Could not read keymap file: 'bad'
>     Could not read keymap file: 'worse'
> 
> Fix that.
> 
> Note that parse_keyboard_layout() allocates the keymap, except when
> it's parsing an include file.  To keep error handling simple, move the
> memory management to its caller init_keyboard_layout().
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
