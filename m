Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0Qa-0001jL-Sp
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0QW-0006jy-T7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db0QW-0006iU-N8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:15:16 -0400
Date: Fri, 28 Jul 2017 09:15:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728081504.GB31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
	<20170727145448.GV2555@redhat.com>
	<6FD43B48-E475-422A-A7F9-38B5589D051B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6FD43B48-E475-422A-A7F9-38B5589D051B@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Thu, Jul 27, 2017 at 10:36:02PM -0400, Programmingkid wrote:
> 
> > On Jul 27, 2017, at 10:54 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> > 
> > On Thu, Jul 27, 2017 at 10:51:33AM -0400, Programmingkid wrote:
> >> There are now keyboards that have 19 function keys. This patch extends
> >> QEMU so these function keys can be used. 
> >> 
> >> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> >> ---
> >> qapi-schema.json  | 6 +++++-
> >> ui/input-keymap.c | 4 ++++
> >> 2 files changed, 9 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/qapi-schema.json b/qapi-schema.json
> >> index 9c6c3e1..a051820 100644
> >> --- a/qapi-schema.json
> >> +++ b/qapi-schema.json
> >> @@ -4842,6 +4842,10 @@
> >> # @hiragana: since 2.9
> >> # @henkan: since 2.9
> >> # @yen: since 2.9
> >> +# @f16: since 2.10
> >> +# @f17: since 2.10
> >> +# @f18: since 2.10
> >> +# @f19: since 2.10
> >> #
> >> # Since: 1.3.0
> >> #
> >> @@ -4864,7 +4868,7 @@
> >>             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
> >>             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
> >>             'ro', 'hiragana', 'henkan', 'yen',
> >> -            'kp_comma', 'kp_equals', 'power' ] }
> >> +            'kp_comma', 'kp_equals', 'power', 'f16', 'f17', 'f18', 'f19'] }
> > 
> > Linux and AT set 1 go all the way to F24, and OS-X goes to F20, so don't
> > arbitrarily stop short at F19
> 
> I think I will future-proof this patch by going all the way to F30.

No, don't do that - we only want QKeyCodes that have a corresponding
mapping in the Linux key names, so F24 is the max we should have.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
