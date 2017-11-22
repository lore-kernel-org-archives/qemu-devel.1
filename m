Received: from eggs.gnu.org ([2001:4830:134:3::10]:45171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHWEg-0006lk-Fd
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHWEc-0003Hu-JA
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:42:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHWEc-0003Hh-D4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:42:42 -0500
References: <1511338200-20417-1-git-send-email-yu.ning@linux.intel.com>
	<18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <961e87c5-9840-65fb-ee19-da3b58a8354d@redhat.com>
Date: Wed, 22 Nov 2017 15:42:33 +0100
MIME-Version: 1.0
In-Reply-To: <18c1591d-a46a-cd22-fd1c-d87780829622@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, Yu Ning <yu.ning@linux.intel.com>
Cc: qemu-devel@nongnu.org, huth@tuxfamily.org, jsnow@redhat.com, sw@weilnetz.de, Yu Ning <yu.ning@intel.com>

On 22/11/2017 13:25, Thomas Huth wrote:
> diff --git a/assets/css/skel-noscript.css b/assets/css/skel-noscript.css
> index e0a141e..f574b9f 100644
> --- a/assets/css/skel-noscript.css
> +++ b/assets/css/skel-noscript.css
> @@ -27,6 +27,7 @@
>                         -o-box-sizing: border-box;
>                         -ms-box-sizing: border-box;
>                         box-sizing: border-box;
> +                       max-width:100%;
>                 }
> 
>         /* Rows */
> 
> Paolo, does that look OK for you?

That is black magic and I'm a bit afraid to touch it.

Does this also work for you?

diff --git a/assets/css/style.css b/assets/css/style.css
index 2d4fe0c..d482fe9 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -200,6 +200,10 @@

 	/* Images */

+		img {
+			max-width: 100%;
+		}
+
 		.image
 		{
 			display: inline-block;


Thanks,

Paolo
