Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdDZ0-0007ZV-6D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdDYw-0007TX-Ht
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:08:54 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:37482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdDYw-0007TO-7x
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:08:50 -0500
Message-Id: <58A1F62902000062000CF41B@prv-mh.provo.novell.com>
Date: Mon, 13 Feb 2017 03:08:41 -0700
From: "Lin Ma" <lma@suse.com>
References: <20170213092709.24711-1-lma@suse.com>
	<20170213093844.GA12387@redhat.com>
In-Reply-To: <20170213093844.GA12387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSN77yaIFJlOiAgW1BBVENIXSB0cmFjZTog?=
 =?utf-8?q?fix_trace-events-all_dependencies_in_Makefile=2Eobjs?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Yeah, I just noticed, Thank you.

>>> "Daniel P. Berrange" <berrange@redhat.com> 2017/2/13 =E6=98=9F=E6=9C=9F=
=E4=B8=80 =E4=B8=8B=E5=8D=88 5:38 >>>
On Mon, Feb 13, 2017 at 05:27:09PM +0800, Lin Ma wrote:
> It causes that file trace-events-all isn't generated during build, make
> install reports 'No such file or directory'. The patch fixes it.
>=20
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  trace/Makefile.objs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/trace/Makefile.objs b/trace/Makefile.objs
> index 7de840a..8e5e85a 100644
> --- a/trace/Makefile.objs
> +++ b/trace/Makefile.objs
> @@ -17,7 +17,7 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)
> =20
>  $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h=
-timestamp
> 	 @cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) =
$(BUILD_DIR)/config-host.mak $(tracetool-y)
> +$(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events=
-all $(BUILD_DIR)/config-host.mak $(tracetool-y)

This dependancy change is not right. The correct fix is here

  https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00959.html


Regards,
Daniel
--=20
|: http://berrange.com	  -o-    http://www.flickr.com/photos/dberrange/ =
:|
|: http://libvirt.org			  -o-   		  =
http://virt-manager.org :|
|: http://entangle-photo.org	   -o-    http://search.cpan.org/~danberr/ =
:|
