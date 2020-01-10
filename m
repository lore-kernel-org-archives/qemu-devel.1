Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83361C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEFF20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhk43xYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEFF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprcq-0005NH-Db
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iprW5-0006T1-Sd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iprW3-0003uq-MP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:27:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iprW3-0003qz-Dg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:27:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id w5so4064538wmi.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f5zgAssPzGbE/iDLiAMdTnQwPfYUfeczLmwRmPbjmvI=;
 b=jhk43xYRYEBnQ+gM7eryXvGJUvY+6+vez7xo76JCVDenMNokXCjlQysV4/y4ar+OO8
 ySXwD5FJ533Rz14M5RCEEgSjY9EJcE6439iewgrnGnDZFv2yrbEfIx/iWVl1gSIV8bPD
 V/4zWt+LX/aQtZ8tMqgGveQef1d5WTm78uHaNyuQf6sWcH51ioGxS0UOwXSrPTmg7J4q
 Q82YV7Kj+EF7BAe6eZs2xejbx5mdCT2NMYh05TvafJduS5kw4Mz27mzYF8IDMRrdVdfI
 qQXRaQM9Ub9n/bf6MPy6nyBQnUuxiD30Fn6nQNqJPi+4PR4KJWyBLnmgZdZlWIoR+4tM
 0Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f5zgAssPzGbE/iDLiAMdTnQwPfYUfeczLmwRmPbjmvI=;
 b=H44git9KHL+ZpMppq+g6AR4+zse+THaHVNaLALqDMwQW231OV34eA9FNSkrkxpwntP
 oeQODLSyw49O82aX4ZqGIixqV+O0O0qvxT7g7MGhxG+gkSi+BAoW9hdOk3IT27ELQ1zi
 lGpiWHxfzIlME1E+D6ZrPD73YzxJk0F+5bk9u/YKVIitB8OeOCmd9eyRtvmmCm1XjMiO
 gfuUxzGfE2pMPEhxgG53NZyTs2m9w++GXIy21qoADurFP/rkhq4qukxO2lFrEXuEaI0E
 1KVfNnJn8IsZa6FFg+apTaR/6aELtGjYc1K1Dr0U8ZzJJ8froupL+Wac1MVI7lhfQyD8
 BxFA==
X-Gm-Message-State: APjAAAV/gxQIveLMlN0zojqOQNCtIVzfwStyL5nKiZfcTo1qyHpq1ta5
 exXEE4SFLP8lzM22hmGZyZS7krYibT+Pelu4BTs=
X-Google-Smtp-Source: APXvYqwK7dpSlbxS63u43nurADAeqRtUaVzfSi/tOsDqQtdj15YSYmsnBO7+A/4d5oAyrH9nfDcWMTz+mdxq5Ev1Cu0=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr3659594wmk.42.1578652061919; 
 Fri, 10 Jan 2020 02:27:41 -0800 (PST)
MIME-Version: 1.0
References: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
In-Reply-To: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Jan 2020 14:27:29 +0400
Message-ID: <CAJ+F1CLzR7Q7ei550d+2GhnmcwiGpb2ixem_tr4QUPnsF_KPKg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
To: "V." <mail@winaoe.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 8, 2020 at 5:57 AM V. <mail@winaoe.org> wrote:
>
> Hi List,
>
> For my VM setup I tend to use a lot of VM to VM single network links to d=
o routing, switching and bridging in VM's instead of the host.
> Also stemming from a silly fetish to sometimes use some OpenBSD VMs as fi=
rewall, but that is besides the point here.
> I am using the standard, tested and true method of using a whole bunch  o=
f bridges, having 2 vhost taps each.
> This works and it's fast, but it is a nightmare to manage with all the in=
terfaces on the host.
>
> So, I looked a bit into how I can improve this, basically coming down to =
"How to connect 2 VM's together in a really fast and easy way".
> This however, is not as straightforward as I thought, without going the w=
hole route of OVS/Snabb/any other big feature bloated
> software switch.
> Cause really, all I want is to connect 2 VM's in a fast and easy way. Sho=
uldn't be that hard right?
>
> Anyways, I end up finding tests/vhost-user-bridge.c, which is very nicely=
 doing half of what I wanted.
> After some doubling of the vhosts and eliminating udp, I came up with a V=
host User Cross Cable. (patch in next post).
> It just opens 2 vhost sockets instead of 1 and does the forwarding betwee=
n them.
> A terrible hack and slash of vhost-user-bridge.c, probably now with bugs =
causing the dead of many puppies and the end of humanity,
> but it works!
>
> However... I now am left with some questions, which I hope some of you ca=
n answer.
>
> 1.
> I looked, googled, read and tried things, but it is likely that I am an c=
omplete and utter moron and my google-fu has just been awful...
> Very likely... But is there really no other way then I have found to just=
 link up 2 QEMU's in a fast non-bridge way? (No, not sockets.)
> Not that OVS and the likes are not fine software, but do we really need t=
he whole DPDK to do this?

By "not sockets", you mean the data path should use shared memory?
Then, I don't think there are other way.

>
> 2.
> In the unlikely chance that I'm not an idiot, then I guess now we have a =
nice simple cross cable.
> However, I am still a complete vhost/virtio idiot who has no clue how it =
works and just randomly brute-forced code into submission.
> Maybe not entirely true, but I would still appreciate it very much if som=
eone with more knowledge into vhost to have a quick look at
> how things are done in cc.
>
> Specifically this monstrosity in TX (speed_killer is a 1MB buffer and kil=
ls any speed):
>   ret =3D iov_from_buf(sg, num, 0, speed_killer,
>                      iov_to_buf(out_sg, out_num, 0, speed_killer,
>                                 MIN(iov_size(out_sg, out_num), sizeof spe=
ed_killer)
>                                )
>                     );
>
>   vs. the commented:
>   //ret =3D iov_copy(sg, num, out_sg, out_num, 0,
>   //               MIN(iov_size(sg, num), iov_size(out_sg, out_num)));
>
> The first is obviously a quick fix to get things working, however, in my =
meager understanding, should the 2nd one not work?
> Maybe I'm messing up my vectors here, or I am messing up my understanding=
 of iov_copy, but shouldn't the 2nd form be the way to zero
> copy?


As you noted, the data must be copied from source to dest memory.
iov_copy() doesn't actually do that, I don't think we have a iov
function for that.

>
> 3.
> Now if Cross Cable is actually a new and (after a code-rewrite of 10) a v=
iable way to connect 2 QEMU's together, could I actually
> suggest a better way?
> I am thinking of a '-netdev vhost-user-slave' option to connect (as clien=
t or server) to a master QEMU running '-netdev vhost-user'.
> This way there is no need for any external program at all, the master can=
 have it's memory unshared and everything would just work
> and be fast.
> Also the whole thing can fall back to normal virtio if memory is not shar=
ed and it would even work in pure usermode without any
> context switch.
>
> Building a patch for this idea I could maybe get around to, don't clearly=
 have an idea how much work this would be but I've done
> crazier things.
> But is this is something that someone might be able to whip up in an hour=
 or two? Someone who actually does have a clue about vhost
> and virtio maybe? ;-)

I believe https://wiki.qemu.org/Features/VirtioVhostUser is what you
are after. It's still being discussed and non-trivial, but not very
active lately afaik.

>
> 4.
> Hacking together cc from bridge I noticed the use of container_of() to ge=
t from vudev to state in the vu callbacks.
> Would it be an idea to add a context pointer to the callbacks (possibly g=
otten from VuDevIface)?
> And I know. First post and I have the forwardness to even suggest an API =
change! I know!
> But it makes things a bit simpler to avoid globals and it makes sense to =
have some context in a callback to know what's going on,
> right? ;-)

Well, the callbacks are called with the VuDev, so container_of() is
quite fine since you can embed the device in your own structure. I
don't see a compelling reason to change that.

> 5.
> Last one, promise.
> I'm very much in the church of "less software =3D=3D less bugs =3D=3D les=
s security problems".
> Running cc or a vhost-user-slave means QEMU has fast networking in usermo=
de without the need for anything else then AF_UNIX + shared
> mem.
> So might it be possible to weed out any modern fancy stuff like the Inter=
net Protocol, TCP, taps, bridges, ethernet and tokenring
> from a kernel and run QEMU on that?
> The idea here is a kernel with storage, a serial console, AF_UNIX and vfi=
o-pci, only running QEMU.
> Would this be feasible? Or does QEMU need a kernel which at least has a g=
rasp of understanding of what AF_INET and ethernet is?
> (Does a modern kernel even still support tokenring? No idea, Probably doe=
s.)

Sounds like it is possible.

> Finally, an example and some numbers.
>
> Compiling and starting the cross cable:
> ./configure
> make tests/vhost-user-cc
> tests/vhost-user-cc -l /tmp/left.sock -r /tmp/right.sock
>
> (Note, the cross cable will quit if one of the vm's quits, but the VM's w=
ill reconnect when cc starts again.)
>
> 2 VM's, host1 and host2, Linux guests, run like this:
>
> host1:
> /qemu/bin/qemu-system-x86_64 \
>   -accel kvm -nodefaults -k en-us -vnc none -machine q35 -cpu host -smp 8=
,cores=3D8 -m 2G -vga std \
>   -object memory-backend-file,id=3Dmemory,mem-path=3D/hugetlbfs,share=3Do=
n,size=3D2G \
>   -numa node,memdev=3Dmemory \
>   -drive if=3Dnone,cache=3Dnone,format=3Draw,aio=3Dnative,file=3D/dev/lvm=
/host1,id=3Dsda \
>   -device virtio-scsi-pci,id=3Dscsi0 -device scsi-hd,drive=3Dsda,bus=3Dsc=
si0.0 \
>   -nic tap,vhost=3Don,helper=3D/usr/libexec/qemu-bridge-helper,id=3Deth0,=
model=3Dvirtio-net-pci,mac=3D52:54:00:aa:aa:aa,br=3Dbr0 \
>   -chardev socket,id=3Dleft,path=3D/tmp/left.sock,reconnect=3D1 \
>   -nic vhost-user,chardev=3Dleft,id=3Deth1,model=3Dvirtio-net-pci,mac=3D5=
2:54:00:bb:bb:bb
>
> host2:
> /qemu/bin/qemu-system-x86_64 \
>   -accel kvm -nodefaults -k en-us -vnc none -machine q35 -cpu host -smp 8=
,cores=3D8 -m 2G -vga std \
>   -object memory-backend-file,id=3Dmemory,mem-path=3D/hugetlbfs,share=3Do=
n,size=3D2G \
>   -numa node,memdev=3Dmemory \
>   -drive if=3Dnone,cache=3Dnone,format=3Draw,aio=3Dnative,file=3D/dev/lvm=
/host2,id=3Dsda \
>   -device virtio-scsi-pci,id=3Dscsi0 -device scsi-hd,drive=3Dsda,bus=3Dsc=
si0.0 \
>   -nic tap,vhost=3Don,helper=3D/usr/libexec/qemu-bridge-helper,id=3Deth0,=
model=3Dvirtio-net-pci,mac=3D52:54:00:cc:cc:cc,br=3Dbr0 \
>   -chardev socket,id=3Dright,path=3D/tmp/right.sock,reconnect=3D1 \
>   -nic vhost-user,chardev=3Dright,id=3Deth1,model=3Dvirtio-net-pci,mac=3D=
52:54:00:dd:dd:dd
>
>
> First, speed via eth0 (bridged tap with vhost, host2 runs './iperf3 -s'):
>   root@host1:~/iperf-3.1.3/src# ./iperf3 -c 192.168.0.2 -i 1 -t 10
>   ...
>   [  4]   0.00-10.00  sec  10.7 GBytes  9.22 Gbits/sec                  r=
eceiver
>
> Second, speed via eth1 (Vhost Cross Cable):
>   root@host1:~/iperf-3.1.3/src# ./iperf3 -c 192.168.1.2 -i 1 -t 10
>   ...
>   [  4]   0.00-10.00  sec  2.05 GBytes  1.76 Gbits/sec                  r=
eceiver
>
> So, a factor of 6 slowdown against bridge. Not too bad, considering the b=
ad iovec mem-copying I do.
> Lots of room for improvement though, but at least for me it's also 5 time=
s faster as socket.
>

And what performance do you get with -netdev socket ?

--
Marc-Andr=C3=A9 Lureau

