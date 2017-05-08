Received: from eggs.gnu.org ([2001:4830:134:3::10]:38873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7lbx-0007pw-5d
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7lbw-0002Z2-3B
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:34:13 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7lbv-0002Yy-Tc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:34:12 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so10263409qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 09:34:11 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
In-Reply-To: <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
	<CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
	<0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
From: Carl Karsten <carl@personnelware.com>
Date: Mon, 8 May 2017 11:33:40 -0500
Message-ID: <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Mon, May 8, 2017 at 11:29 AM, Eric Blake <eblake@redhat.com> wrote:

> On 05/08/2017 10:56 AM, Carl Karsten wrote:
>
> >>>>> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses
> -drive
> >>>>> file=disk.cow -drive file=boot.img
> >>>>> WARNING: Image format was not specified for 'boot.img' and probing
> >>>> guessed
> >>>>> raw.
> >>>>>          Automatically detecting the format is dangerous for raw
> >> images,
> >>>>> write operations on block 0 will be restricted.
> >>>>>          Specify the 'raw' format explicitly to remove the
> >> restrictions.
>
> >  "write operations on block 0 will be restricted."
> >
> > Is there a way to explicitly enable that?
>
> Yes. Pass format=raw at the right place (in other words, instead of
> getting the 'raw' format driver by default, explicitly mentioning that
> you KNOW you want the 'raw' format driver is enough to shut up the
> warning).
>

according to the warning: "Specify the 'raw' format explicitly to remove
the restrictions."

I want the restriction.

format=raw, (write operations on block 0)=restricted



>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>


-- 
Carl K
