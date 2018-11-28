Received: from eggs.gnu.org ([2001:4830:134:3::10]:57012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3RA-0004Sx-6U
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3R6-0004v3-Pu
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS3R6-0003gS-CM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 708F3811D3
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:15:12 +0000 (UTC)
References: <20181128153526.10948-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31667b3c-0071-e2b3-63d1-2fdc0c96c98f@redhat.com>
Date: Wed, 28 Nov 2018 11:15:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181128153526.10948-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 11/28/18 9:35 AM, Daniel P. Berrang=C3=A9 wrote:
> Add a README file that tells people this is a jekyll based static
> website, and shows people how to run jekyll for testing purposes.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> NB, we should really mention a license in the README too, but I don't
> see info about what license we consider qemu-web to be covered by...
>=20
>   README      | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>   _config.yml |  2 ++
>   2 files changed, 55 insertions(+)
>   create mode 100644 README
>=20
> diff --git a/README b/README
> new file mode 100644
> index 0000000..d06606a
> --- /dev/null
> +++ b/README
> @@ -0,0 +1,53 @@
> +QEMU Webite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

s/Webite/Website/ (and the corresponding =3D line lengthening)


> +* Install Jekyll and its dependencies
> +
> +   # bundle install --path vendor
> +

$ pwd
/home/eblake
$ bundle install --path vendor
Could not locate Gemfile

What am I missing?

> +Jekyll is now installed into the 'vendor/' directory of the git checko=
ut.

Oh - this step must be run within the top-level directory of the=20
qemu-web.git checkout (which might be obvious for someone reading the=20
README from a fresh qemu-web git checkout, but wasn't for me while=20
reviewing the patch).  So I repeated the command in the right directory,=20
and it appears to work:

$ bundle install --path vendor
Fetching gem metadata from https://rubygems.org/..............
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
Fetching public_suffix 2.0.5
...
Installing jekyll 3.3.0
...
Bundle complete! 9 Gemfile dependencies, 25 gems now installed.
Bundled gems are installed into `./vendor`
...

but I don't know if it is the same version of Jekyll that the=20
documentation wanted ("QEMU requires a specific version of Jekyll which=20
may not match that provided by your OS vendor" doesn't actually say=20
WHICH specific version).

> +Note the 'vendor/' path has been explicitly excluded from the web cont=
ent
> +in _config.yml, so don't try to use a different path within the git
> +checkout.
> +
> +
> +To test the site launch jeykll
> +
> +  # bundle exec jekyll serve

$ bundle exec jekyll serve
Configuration file: /home/eblake/qemu-web/_config.yml
Configuration file: /home/eblake/qemu-web/_config.yml
             Source: /home/eblake/qemu-web
        Destination: /home/eblake/qemu-web/_site
  Incremental build: disabled. Enable with --incremental
       Generating...
              ERROR: YOUR SITE COULD NOT BE BUILT:
                     ------------------------------------
                     Invalid date '<%=3D Time.now.strftime('%Y-%m-%d=20
%H:%M:%S %z') %>': Document=20
'vendor/ruby/2.5.0/gems/jekyll-3.3.0/lib/site_template/_posts/0000-00-00-=
welcome-to-jekyll.markdown.erb'=20
does not have a valid date in the YAML front matter.

Did I do things right?

> +
> +Now simply point a local web browser to http://127.0.0.1:4000 to brows=
e
> +the generated site.
> +
> +Jekyll will usually automatically detect changes to files in the git
> +checkout and regenerate the site. It is thus not normally neccessary

s/neccessary/necessary/

> +to restart jekyll after changing content, unless it shows signs of bei=
ng
> +confused / stale.
> diff --git a/_config.yml b/_config.yml
> index 0a0201c..576b0a5 100644
> --- a/_config.yml
> +++ b/_config.yml
> @@ -37,3 +37,5 @@ gems:
>   exclude:
>     - Gemfile
>     - Gemfile.lock
> +  - vendor/
> +  - README
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
