Received: from eggs.gnu.org ([2001:4830:134:3::10]:60451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvjn-0005n7-TF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvjm-0008GO-VY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:02:43 -0400
Date: Tue, 25 Jul 2017 10:02:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725090221.GH26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <7fb8c9ff25d183cf7c0f729a90ee4f59c0632d64.1497602554.git.maozy.fnst@cn.fujitsu.com>
	<38f43362-e3a3-44ab-9c29-d04b4c825085@redhat.com>
	<ee87c1b8-d34d-566e-b7cf-3c5700d76352@cn.fujitsu.com>
	<87pocpxcnc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pocpxcnc.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] util: remove the obsolete
 non-blocking connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, mreitz@redhat.com, Cao jin <caoj.fnst@cn.fujitsu.com>, kraxel@redhat.com, pbonzini@redhat.com, famz@redhat.com, sheepdog@lists.wpkg.org

On Tue, Jul 25, 2017 at 08:18:31AM +0200, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
> 
> > On 07/25/2017 06:07 AM, John Snow wrote:
> >> This was posted over a month ago with two R-Bs, did it get merged or dropped?
> >>
> >> --js
> >
> > Not yet, I hope that it will.
> 
> get_maintainers.pl blames Daniel, Gerd and Paolo :)

Yeah, I totally forgot that I was listed as a maintainer of the
util/qemu-sockets.c file when I reviewed this & assumed Gerd/Paolo
would take it.

I'll put it on my merge queue right now, but unfortunately I can't
justify sending this during freeze as it isn't a bugfix, so it'll
have to wait until 2.11 opens.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
