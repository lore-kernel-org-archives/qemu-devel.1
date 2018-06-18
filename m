Received: from eggs.gnu.org ([2001:4830:134:3::10]:44430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUqkk-000649-LK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUqkh-0006Lw-GW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fUqkh-0006L9-Bl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:47:11 -0400
Date: Mon, 18 Jun 2018 10:47:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180618094707.GA3589@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <e43421dc-b008-42aa-a195-350ffb35e3f2@vc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e43421dc-b008-42aa-a195-350ffb35e3f2@vc.local>
Subject: Re: [Qemu-devel] [PATCH] Replaced git:// to https:// - resolved
 receiving sources behind some routers and HW-firewalls Fixed URLs to actual
 - replaced git.qemu-project.com to git.qemu.org Slightly fixed
 u-boot-sam460ex URL (added .git)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iliya Dyachenko <gandalfthewhite@mail.ru>
Cc: qemu-devel@nongnu.org

You need to trim the subject line so it is about 70 characters or less
and then have a blank line

On Mon, Jun 18, 2018 at 12:32:01PM +0300, Iliya Dyachenko wrote:
> Signed-off-by: Iliya Dyachenko <gandalfthewhite@mail.ru>
> ---
>  .gitmodules | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index 49e9c2e3f4..e6bc732d16 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -1,48 +1,48 @@
>  [submodule "roms/vgabios"]
>  	path = roms/vgabios
> -	url = git://git.qemu-project.org/vgabios.git/
> +	url = https://git.qemu.org/git/vgabios.git

[snip]

This is highly desirable, however, we cannot do it right now.

The git.qemu.org server is still using the dumb git http protocol, so it
would be a performance regression over git://

We need the server config fixing to use the smart http protocol.

Essentially this just involves configuring apache to add

  <Directory /usr/libexec/git-core>
    Allow from all
  </Directory>

  SetEnv GIT_PROJECT_ROOT /data/git

  ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
    /usr/libexec/git-core/git-http-backend/$1
  ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
    /usr/libexec/git-core/git-http-backend/$1



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
