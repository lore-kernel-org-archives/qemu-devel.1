Received: from eggs.gnu.org ([209.51.188.92]:42070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEU3-0001Oi-NC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtETu-0001eR-Fb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:31:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtETu-0001cf-2a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:30:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5EF26696F
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:24:41 +0000 (UTC)
Date: Mon, 11 Feb 2019 16:24:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211162437.GI27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190211162052.13584-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211162052.13584-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] [qemu-web] Put version numbering details
 in its own doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 11, 2019 at 05:20:52PM +0100, Kashyap Chamarthy wrote:
> Instead of burying the version numbering details under "Download QEMU"
> page, place it in its own document.  And highlight its presence in the
> website footer.

I'm not sure I agree with saying it is "buried" on the download page.

It is pretty clearly visible, and it is relevant information at the
time you are downloading. If anything, moving it off into a separate
page /is/ burying it IMHO, as now its not visible at time of download

> While at it, add a concrete example of the version numbering scheme.
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  _includes/footer.html |  1 +
>  download.html         | 23 -----------------------
>  version-numbering.md  | 26 ++++++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 23 deletions(-)
>  create mode 100644 version-numbering.md
> 
> diff --git a/_includes/footer.html b/_includes/footer.html
> index 1669ef766cc18b0df3e27418038f9bf851b74c8a..0fb85feb564e3b23bc4ab78eb05359264d13bfa5 100644
> --- a/_includes/footer.html
> +++ b/_includes/footer.html
> @@ -17,6 +17,7 @@
>  			<li><a href="https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li>
>  			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
>  			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
> +			<li><a href="/version-numbering">Version numbering</a></li>
>  		</ul>
>  		<ul class="style">
>  			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
> diff --git a/download.html b/download.html
> index 3c2df66ff6757bba1246b5f0873b287fca600f11..e4c8bb5792aa6e6f7038a9fd2bdab3c432daa6ab 100644
> --- a/download.html
> +++ b/download.html
> @@ -40,29 +40,6 @@ permalink: /download/
>  </article>
>  </div>
>  
> -<h2>Version numbering</h2>
> -<div>
> -  <p>
> -  Since version 3.0.0, QEMU uses a time based version numbering scheme:
> -  </p>
> -<dl>
> -<dt>major</dt>
> -<dd>incremented by 1 for the first release of the year</dd>
> -<dt>minor</dt>
> -<dd>reset to 0 with every major increment, otherwise incremented by 1 for each release from git master</dd>
> -<dt>micro</dt>
> -<dd>always 0 for releases from git master, incremented by 1 for each stable branch release</dd>
> -</dl>
> -  <p>
> -    The implication of this is that changes in major version number
> -    <strong>do not</strong> have any bearing on the scope of changes
> -    included in the release. Non-backward compatible changes may be made
> -    in any master branch release, provided they have followed the
> -    <a href="https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features">deprecation policy</a>
> -    which calls for warnings to be emitted for a minimum of two releases
> -    prior to the change.
> -  </p>
> -</div>
>  <script>
>  function animateOnClick(jqThis, slide) {
>     $('.horiz-menu li').removeClass('active');
> diff --git a/version-numbering.md b/version-numbering.md
> new file mode 100644
> index 0000000000000000000000000000000000000000..9ace69128f76d7eb5b71e062ccdcb3ffd768ccc6
> --- /dev/null
> +++ b/version-numbering.md
> @@ -0,0 +1,26 @@
> +---
> +title: QEMU version numbering
> +permalink: /version-numbering/
> +---
> +
> +Since version 3.0.0, QEMU uses a time based version numbering scheme:
> +
> +  - major: incremented by 1 for the first release of the year
> +
> +  - minor: reset to 0 with every major increment, otherwise
> +    incremented by 1 for each release from git master
> +
> +  - micro: always 0 for releases from git master, incremented by 1 for
> +    each stable branch release
> +
> +The implication of this is that changes in major version number *do not*
> +have any bearing on the scope of changes included in the release.
> +Non-backward compatible changes may be made in any master branch
> +release, provided they have followed the [deprecation
> +policy](https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features)
> +which calls for warnings to be emitted for a minimum of two releases
> +prior to the change.
> +
> +Example number scheme: in the year 2019, there will be 4.0.0, 4.1.0 and
> +4.2.0 releases; following that, 5.0.0, 5.1.0, 5.2.0 releases in 2020,
> +and so on.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
