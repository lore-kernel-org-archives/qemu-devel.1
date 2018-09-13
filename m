Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0NYE-0001gf-Qx
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0NY9-0004sd-1v
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0NY8-0004qe-QP
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:04:32 -0400
Date: Thu, 13 Sep 2018 11:04:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180913090429.lphnvev7fleup2lx@sirius.home.kraxel.org>
References: <45OPfGmaK-Sz9ZGzbGSmlE0AgSRiVp3mCkNrkJC2k6s4c9wOOcegenAJ6muFQwlGl1gBTMordKEgVU2tv9dThhXMDKaJPSZ6tNTMclo_n1E=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45OPfGmaK-Sz9ZGzbGSmlE0AgSRiVp3mCkNrkJC2k6s4c9wOOcegenAJ6muFQwlGl1gBTMordKEgVU2tv9dThhXMDKaJPSZ6tNTMclo_n1E=@protonmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: customizable grab toggle keys
 v3
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

On Mon, Sep 03, 2018 at 04:32:10PM +0000, Ryan El Kochta wrote:
> This patch adds a new option to the input-linux object:
> 
> grab_toggle=key-key-key

"grab-toggle" (no underscore) please.

I'm still not convinced we need that much flexibility.
I would go for a fixed list of combinations.

Suggestion: add a enum to qapi (see QKeyCode in qapi/ui.json for an
example), that way you'll get a bunch of helper code and lookup tables
generated.  Simplifies the option parsing, you can use
object_property_add_enum() then.

> I have also attached the patch contained in the body of this email
> since my mail client does not seem to behave well with patches.
> If this is a problem, please let me know.

Using 'git send-email' is the best way to send out patch mails.

Must be set up once, but when done it is less work for both sending and
receiving side.

cheers,
  Gerd
