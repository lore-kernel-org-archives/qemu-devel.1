Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMrYZ-0006yq-D3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMrYW-0003es-8I
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMrYW-0003eK-0v
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:52 -0500
Date: Wed, 14 Nov 2018 09:33:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114093342.GD19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <7b5279e8946325b7f3c22a4a51ab02777202ce77.1541573846.git.artem.k.pisarenko@gmail.com>
	<20181112153149.GS3602@redhat.com>
	<CANzW0msdqMMDizfpfFoMrmUQtnA_+d7rxO3-S7kSLPoq9KLAHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANzW0msdqMMDizfpfFoMrmUQtnA_+d7rxO3-S7kSLPoq9KLAHA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] netdev: fix socket backend implementation
 and docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Nov 13, 2018 at 04:13:04PM +0600, Artem Pisarenko wrote:
> > Incidentally this method should not even be part of this header
> > files.  qemu/sockets.h is for code that lives in util/qemu-sockets.c
> >
> > The parse_host_port declaration and impl should better live in
> > net/util.{c,h}, so I'd recommend moving that as the first patch
> > in a series.
> 
> Ok.
> 
> > This is really not a desirable thing todo. While you are changing
> > one area of code, but you've got a number of independent bugs
> > or improvements you are making. These should be done as a patch
> > series, one distinct fix/change per patch. Refactoring should
> > especially always be done separately from any functional changes
> > to reviewers can clearly see no accidental behaviour changes are
> > introduced by the refactoring.
> 
> I understand that and I done it intentionally for this specific patch.
> These changes are really very and very related to each other (not only
> because they mostly live in one source file).
> Yes, few specific changes are easily may be represented by separate
> patches, but it also means that it doesn't bring much convinience for
> review. Converting this to patch series just introduce more complexity and
> effort (mostly for me, but for reviewers too enough). Not also it requires
> 95% of effort already spent, but for single reviewer understanding of
> validity of each separate patch will be mostly invalidated by following
> patch. Furthermore, if some patch will require rework, then it also most
> probably will require rework whole chain of next dependent patches, thus
> invalidating their 'reviewed' status if any. I beleive this patch is worth
> of exception from principles you mentioned. Whole net/socket.c requires
> revision - separating changes wil not simplify it. Just consider it as one
> large fix of something hardly broken and given new fresh look and view.

I still rather disagree with this. Looking at the list of bullet
points of things you have changed and the code I still believe
this patch is better split up. It is too hard to identify which
parts of the code change correspond to which bullet point in the
commit message, making it hard to see that the patch actually
achieves what it claims to. The fact that the current code is a
big mess & needs broader revision in fact makes it more important
that the patches are done incrementally to maximise clarity.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
