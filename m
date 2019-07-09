Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52FC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F2620844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCugIptq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknfz-0004oU-QO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35280)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hknf2-0004HM-3r
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hknf0-0007PP-NR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:47:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hknf0-0007OW-Gd
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:47:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id s15so2706561wmj.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9hvGMXw4AlWFRCtb/aDzBZxYJH/lmpxBvG2jOzxnzqc=;
 b=sCugIptqLRKKKM+lu3s+r09pClY9a9GDWYbgNO4LKiKwDjn5AOw1H4hEWi6UqynfHI
 DqY7vFBk7nCkpCfoBrr5VgTxE92Ba8IRG5BYeemDPsBRcZuX7o784GXF5Amt0sODf9hg
 P5jS55sgZ7qlUCTAagFt097guFIIfY1ndy0GDEL8BKZGr90091KW/t+U37AYKlYrqbkH
 fu9iaNnne+FF36wZM0R+nGUF8WNZYU3kxzFFzsUXVJ+ssgRs7ZhOyNKoJQjsl7mw8+75
 w1yDYZZZ9yWqKGB100bvv4w1ybvXfN7/Ju3YPDQiNreEirebdfMnlo7fy4e7OzsTYCPD
 V8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9hvGMXw4AlWFRCtb/aDzBZxYJH/lmpxBvG2jOzxnzqc=;
 b=L6UR9Er+aw8uDCLvtahou2xaV4RvbXXjj2xT8Vkly+A6j8eek4DvMVLkeshkSr5SWO
 002DlErBxXGyZIDZxE6kM97ltagLs0l21naIfnMGA9QY+VrUGqA3yC4QkxU4l2gq/4Xd
 5ycPhwDo9PMpcGT4gW8Dfv8q19o9sAfDPD7/ZfMogbE7gZa6apQAi34YJOCY/G2+t5+N
 UvUGAb6yvnEy6lqxF0ga6WO5t0EUDIhw/+LT3vCXnZmiOE8aFyYisYjpAwXaiH+wYMj6
 wjNV/HdW2yFgDgdnXos4mcBQypaOhHcS7JBGgLBGwxKmo1MsdQ+nRcYK10QZumyadDjG
 tU/g==
X-Gm-Message-State: APjAAAXq9N/PjsCCTzmQ1phUAMavM4Xux2flOcjX4zI42Wos2H6Mrix3
 Up1HCZadY1CwQts8UmXXAhBeHGg/j7rCgylLzrg=
X-Google-Smtp-Source: APXvYqzM72auKzIvkYV0kCirKBksjC+4TYPKmw3xB72/cjHjJ293aroxCpcPJ/9J+lhQidpIUzR/6655T9oRVg8ayNQ=
X-Received: by 2002:a7b:c455:: with SMTP id l21mr22273271wmi.114.1562669264964; 
 Tue, 09 Jul 2019 03:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
 <CAMxuvaxih_D9HLRnRxhNweux3LsOsxCxzYn6VY748sJx0w8KSQ@mail.gmail.com>
 <20190709090153.GD8664@redhat.com>
In-Reply-To: <20190709090153.GD8664@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Jul 2019 14:47:32 +0400
Message-ID: <CAJ+F1CK3=LvyVgv0S4kihWRJXfuj==LvpZyzi3NtFDSzZQsmyw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jul 9, 2019 at 1:02 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Tue, Jul 09, 2019 at 12:26:38PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Jul 8, 2019 at 8:04 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > > > The D-Bus protocol can be made to work peer-to-peer, but the most
> > > > common and practical way is through a bus daemon. This also has the
> > > > advantage of increased debuggability (you can eavesdrop on the bus =
and
> > > > introspect it).
> > >
> > > The downside of using the bus daemon is that we have to spawn a new
> > > instance of dbus-daemon for every QEMU VM that's running on the host,
> > > which is yet more memory overhead for each VM & another process to
> > > manage, and yet another thing to go wrong.
> >
> > dbus-daemon (or dbus-broker) has been optimized to fit on many devices
> > and use cases, it doesn't take much memory (3mb for my session dbus
> > right now).
> >
> > More processes to manage is inevitable. In a near future, we may have
> > 5-10 processes running around qemu. I think dbus-daemon will be one of
> > the easiest to deal with. (as can be seen in the dbus-vmstate test, it
> > is very simple to start a private dbus-daemon)
>
> The increase in processes per-QEMU is a significant concern I have
> around complexity & manageability in general, hence a desire to avoid
> requiring processes unless they have a compelling reason to exist.

Fair enough, although when the job a bus is done by some other process
(libvirt, qemu or other external process), then I would much rather
have dbus-daemon doing it.

>
> > > QEMU already has a direct UNIX socket connection to the helper
> > > processes in question. I'd much rather we just had another direct
> > > UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> > > The benefit of debugging doesn't feel compelling enough to justify
> > > running an extra daemon for each VM.
> >
> > I wouldn't minor the need for easier debugging. Debugging multiple
> > processes talking to each other is really hard. Having a bus is
> > awesome (if not required) in this case.
> >
> > There are other advantages of using a bus, those come to my mind:
> >
> > - less connections (bus topology)
>
> That applies to general use of DBus, but doesn't really apply to
> the proposed QEMU usage, as every single helper is talking to the
> same QEMU endpoint. So if we have 10 helpers, in p2p mode, we
> get 10 sockets open between the helper & QEMU. In bus mode, we
> get 10 sockets open between the helper & dbus and another socket
> open between dbus & QEMU. The bus is only a win in connections
> if you have a mesh-like connection topology not hub & spoke.

The mesh already exist, as it's not just QEMU that want to talk to the
helpers, but the management layer, and 3rd parties (debug tools,
audit, other management tools etc). There are also cases where helpers
may want to talk to each other. Taking networking as an example, 2
slirp interfaces may want to share the same DHCP, bootp/TFTP,
filter/service provider. Redirection/forwarding may be provided on
demand (chardev-like services). The same is probably true for block
layers, security, GPU/display etc. In this case, the bus topology
makes more sense than hiding it under.

>
> > - configuring/enforcing policies & limits
>
> I don't see that as an advantage. Rather it is addressing the
> decreased security that the bus model exposes. In peer2peer
> mode, the helpers can only talk to QEMU, so can't directly
> interact with each other. In bus mode, the helpers have a
> direct communications path to attack each other over, so we
> absolutely need policy to mitigate this increased risk. It
> would be better to remove that risk at any architectural
> level by not having a bus at all.

You can enforce security/policy at the bus level, in a single place
(including with selinux/apparmor context - although I am not sure how
much that gives you). If each helper process implements its own
protocol, you will probably never have that kind of central
enforcement. And if they exist, libvirt/management layer, qemu &
helpers will have to implement it for each case...

>
> > - on-demand service activation & discoverability
>
> Again useful for dbus in general, but I don't see any clear scenario
> in which this is relevant to QEMU's usage.

Perhaps not to QEMU itself, but helpers could benefit it, see examples
I listed above.

>
> > I also think D-Bus is the IPC of choice for multi-process. It's easier
> > to use than many other IPC due to the various tools and language
> > bindings available. Having a common bus is a good incentive to use a
> > common IPC, instead of a dozen of half-baked protocols.
>
> As I said, I don't have any objection to DBus as a protocol. I think it
> would serve our needs well, most especially because GIO has decent API
> bindings to using it, so we avoid having to depend on another 3rd party
> library for something else.
>
> I think from QEMU's POV, the only real alternative to DBus would be to
> build something on QMP. I prefer DBus, because JSON is a disaster for
> integer type handling, and DBus is more accessible for the helper apps
> which can easily use a DBus API of their choice.

I am glad we can agree on that!

>
> > Nevertheless, I also think we could use D-Bus in peer-to-peer mode,
> > and I did some investigation. The slirp-helper supports it. We could
> > teach dbus-vmstate to eastablish peer-to-peer connections. Instead of
> > receiving a bus address and list of Ids, it could have a list of dbus
> > peer socket path. Both approaches are not incompatible, but I think
> > the bus benefits outweigh the downside of running an extra process.
>
> As above I'm not seeing the compelling benefits of using a bus, so
> think we shoud stick to dbus in p2p mode.

As you can see, there are benefits in having a bus. But if there are
strong concerns about it, I can also work on the p2p mode.

