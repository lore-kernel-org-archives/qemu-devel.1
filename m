Received: from eggs.gnu.org ([2001:4830:134:3::10]:47624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbPVf-0004AY-3X
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbPVb-0005lU-VO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cbPVb-0005lN-MQ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:29:55 -0500
Date: Wed, 8 Feb 2017 10:29:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170208102949.GD3129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170207155956.21573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170207155956.21573-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Tue, Feb 07, 2017 at 04:59:56PM +0100, Paolo Bonzini wrote:
> I have converted all .gz and .bz2 files to .xz on download.qemu.org
> and this patch would change the links in the website.  This would save
> about 5 GB of bandwidth every day (about 20% savings).
> 
> xz should be available for all platforms.  Besides providing better
> compression ratios, decompression of .xz files is about twice as fast
> compared to bzip2.  Compression instead is about 5.5 times slower.

I'm not disagreeing with the proposal, but decompression time is
largely irrelevant, IMHO, as any speed up is lost in the noise
once you consider the time to actually build the QEMU after
unpacking it.

Saving GB's of bandwidth a day for our hosting site is a compelling
benefit, if that has direct impact on project running costs. Shorter
download times are nice, if you have a very slow internet link too,
but for most people they'll again be lost in the noise. As discussed
on IRC, a follow up effort would be to change our releases so we only
include QEMU source and ship pre-built ROMs in a separate tar.xz
which would make downloads massively smaller IIUC.


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _download/source.html   | 4 ++--
>  _includes/releases.html | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/_download/source.html b/_download/source.html
> index 1ac8f4f..d090a5e 100644
> --- a/_download/source.html
> +++ b/_download/source.html
> @@ -15,8 +15,8 @@
>  
>  	{% for release in site.data.releases offset: 0 limit: 1 %}
>  	<p>To download and build QEMU {{release.branch}}.{{release.patch}}:</p>
> -<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2
> -tar xvjf qemu-{{release.branch}}.{{release.patch}}.tar.bz2
> +<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz
> +tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
>  cd qemu-{{release.branch}}.{{release.patch}}
>  ./configure
>  make
> diff --git a/_includes/releases.html b/_includes/releases.html
> index 2caab8d..226c719 100644
> --- a/_includes/releases.html
> +++ b/_includes/releases.html
> @@ -1,9 +1,9 @@
>  <ul>
>  {% for release in site.data.releases offset: 0 limit: 4 %}
>  <li><strong><a
> -  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2">{{release.branch}}.{{release.patch}}</a></strong>
> +  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
>    {{release.date}}<br><a
> -  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.bz2.sig">signature</a> &mdash; <a
> +  href="http://download.qemu-project.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a> &mdash; <a
>    href="http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">changes</a></li>
>  {% endfor %}
>  </ul>
> -- 
> 2.9.3
> 
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
