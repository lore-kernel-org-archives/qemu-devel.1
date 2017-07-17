Received: from eggs.gnu.org ([2001:4830:134:3::10]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX2Zp-0004YH-UW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX2Zm-0004jB-12
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX2Zl-0004hf-Rg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D04894E4D6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:44:24 +0000 (UTC)
References: <20170712072305.29233-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4fb5a60b-8f4e-81ec-020e-3d3ba3690418@redhat.com>
Date: Mon, 17 Jul 2017 11:44:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170712072305.29233-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] keymaps: fr-ca: add missing keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 12.07.2017 09:23, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  pc-bios/keymaps/fr-ca | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> index b645208e42..030f56a78e 100644
> --- a/pc-bios/keymaps/fr-ca
> +++ b/pc-bios/keymaps/fr-ca
> @@ -48,3 +48,5 @@ parenleft 0xa shift
>  parenright 0xb shift
>  underscore 0xc shift
>  plus 0xd shift
> +minus 0xc
> +equal 0xd
> 

Is that the fix for https://bugs.launchpad.net/qemu/+bug/533613 ?

 Thomas
