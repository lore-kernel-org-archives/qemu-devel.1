Received: from eggs.gnu.org ([2001:4830:134:3::10]:39720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddG0u-00012U-0X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddG0p-0002Ku-Cq
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ddG0p-0002KC-5Z
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B87ADC04B927
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 13:18:01 +0000 (UTC)
References: <fe7e4ab1254ac9eb1c6480f1920ed8d2548b4f6c.1501765516.git.jcody@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f0bd45fa-cdc1-f089-1056-749af04948d5@redhat.com>
Date: Thu, 3 Aug 2017 15:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <fe7e4ab1254ac9eb1c6480f1920ed8d2548b4f6c.1501765516.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-web: use https:// to access some
 external assets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03.08.2017 15:07, Jeff Cody wrote:
> Now that we are using SSL, most (all?) web browsers will by default
> block loading mixed content.  There are two assets that need to be
> changed (Google fonts, and jquery).
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  _includes/assets.html | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/_includes/assets.html b/_includes/assets.html
> index 3a526a4..826a50f 100644
> --- a/_includes/assets.html
> +++ b/_includes/assets.html
> @@ -2,7 +2,7 @@
>  	<meta name="description" content="" />
>  	<meta name="keywords" content="" />
>  	<meta name="viewport" content="width=device-width">
> -	<link href='http://fonts.googleapis.com/css?family=Roboto+Mono:300,400%7cRoboto:300,400,500' rel='stylesheet' type='text/css'>
> +	<link href='https://fonts.googleapis.com/css?family=Roboto+Mono:300,400%7cRoboto:300,400,500' rel='stylesheet' type='text/css'>
>  
>  	<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicons/apple-touch-icon.png">
>  	<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicons/favicon-32x32.png">
> @@ -19,7 +19,7 @@
>  	<link rel="stylesheet" href="/assets/css/style-mobile.css" media="(max-width:699px)"/>
>  	<link rel="stylesheet" href="/assets/css/style-desktop.css" media="(min-width:700px)" />
>  	<link rel="alternate" title="QEMU Blog (Atom feed)" href="/feed.xml" type="application/atom+xml" />
> -	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
> +	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
>  	{% if page.colorbox %}
>  	<script src="/assets/js/jquery.colorbox.js"></script>
>  	<link rel="stylesheet" href="/assets/css/colorbox.css" />
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
