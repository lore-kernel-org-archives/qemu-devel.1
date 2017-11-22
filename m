Received: from eggs.gnu.org ([2001:4830:134:3::10]:35368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHU5z-00070T-Dl
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHU5v-0000NC-Eo
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:25:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eHU5v-0000MU-8q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:25:35 -0500
References: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
Date: Wed, 22 Nov 2017 13:25:25 +0100
MIME-Version: 1.0
In-Reply-To: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, huth@tuxfamily.org, jsnow@redhat.com, sw@weilnetz.de, Yu Ning <yu.ning@intel.com>

On 22.11.2017 09:10, Yu Ning wrote:
> From: Yu Ning <yu.ning@intel.com>
>=20
> Following my announcement of the open source release of HAXM,
> I was asked to write a blog post for normal Windows users to
> advertise the use of "-accel hax":
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02822.html

Thanks a lot, that blog post looks very good to me!
... just the width of the qemu-debian-wheezy-gui-with-haxm.png image
seems to cause some rendering ugliness in my webbrowser, causing the
text to overflow into the right menu:

http://people.redhat.com/~thuth/screenshot-haxm-blog.png

Would it be OK to remove the qemu-debian-wheezy-gui-with-haxm.png from
the blog post?

Alternatively, this seems to fix the rendering problem, too:

diff --git a/assets/css/skel-noscript.css b/assets/css/skel-noscript.css
index e0a141e..f574b9f 100644
--- a/assets/css/skel-noscript.css
+++ b/assets/css/skel-noscript.css
@@ -27,6 +27,7 @@
                        -o-box-sizing: border-box;
                        -ms-box-sizing: border-box;
                        box-sizing: border-box;
+                       max-width:100%;
                }

        /* Rows */

Paolo, does that look OK for you?

 Thomas
