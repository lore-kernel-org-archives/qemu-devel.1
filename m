Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA680CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F88721734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F88721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTgE-00055j-Ia
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQTf0-0003xT-Ex
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQTew-0001me-K3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:56:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQTew-0001gr-DD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:55:58 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQTeu-0003Hy-UX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:55:57 +0000
Received: by mail-vs1-f71.google.com with SMTP id w21so1560606vsi.8
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 02:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Owt7tMp4UgTFNSQkENxByl86Umc7YO2OJ6X5tdLI/2c=;
 b=ECC2+C7u34YKtCAomY2T3OyxUNPztkdFesm0EiH3h4aNSZiA2nUe+uvHaJi4mCiBrO
 hbROT6ro1Dy69YbvhVtRvIyt+S3k09inOtxcWe3TAhm+MaUpQ47ZmoEJ2VhUOF5OVVDD
 0xKbZ/FDfYxmBaCgxcxAHWw5jiEA/SGe2m7gjQI+q/OWe0GAsWGp8N5YrEAxLMk/ikId
 xF6+k4FtLbeXocEGl7Mx9AnYytoJadUMFPQuDu9IDq9I37T3KzindVr5C2MTDfgtOMoA
 2FXtoz55gmCq2UkiYsk9JLVzRdISUngM9A8N0Fybf6GOlY6Sz2VKM6EUMwfheQJzB/8i
 vllQ==
X-Gm-Message-State: APjAAAXWideF2AZi4zIzavgHmJqebtLYQrxqrKFa3+Qjl9QD6eacdwIs
 TS3ik5q34rD/q6Kq0gCDxh7mg1feEi8xEvwkPPZmOl2xbX3UB1RLRQ5K7Q3O9FbfsWPquJ2gGWS
 ZKzydIRTen/FOIarR2xUB3hraPbfltFxq3CSpRqzdkB0CtWI1
X-Received: by 2002:ab0:7144:: with SMTP id k4mr2722717uao.91.1572602155916;
 Fri, 01 Nov 2019 02:55:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyP8vpk/EqAnhOGgyYJwLq6RiQr3uUzAGbIczJ4NnZ9vhonKAkeNIXaUTHdEtWJ4bRsomM8VoMHkebYWxYnciM=
X-Received: by 2002:ab0:7144:: with SMTP id k4mr2722702uao.91.1572602155476;
 Fri, 01 Nov 2019 02:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
 <20191101093403.GE11296@redhat.com>
In-Reply-To: <20191101093403.GE11296@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 1 Nov 2019 10:55:29 +0100
Message-ID: <CAATJJ0JrJS108ehZ8VkcYvgeNXEqev8C5vf2a+31J1eJdZ92uA@mail.gmail.com>
Subject: Re: Best practices to handle shared objects through qemu upgrades?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 91.189.89.112
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 1, 2019 at 10:34 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Nov 01, 2019 at 08:14:08AM +0100, Christian Ehrhardt wrote:
> > Hi everyone,
> > we've got a bug report recently - on handling qemu .so's through
> > upgrades - that got me wondering how to best handle it.
> > After checking with Paolo yesterday that there is no obvious solution
> > that I missed we agreed this should be brought up on the list for
> > wider discussion.
> > Maybe there already is a good best practise out there, or if it
> > doesn't exist we might want to agree upon one going forward.
> > Let me outline the case and the ideas brought up so far.
> >
> > Case
> > - You have qemu representing a Guest
> > - Due to other constraints e.g. PT you can't live migrate (which would
> > be preferred)
> > - You haven't used a specific shared object yet - lets say RBD storage
> > driver as example
> > - Qemu gets an update, packaging replaces the .so files on disk
> > - The Qemu process and the .so files on disk now have a mismatch in $bu=
ildid
> > - If you hotplug an RBD device it will fail to load the (now new) .so
>
> What happens when it fails to load ?  Does the user get a graceful
> error message or does QEMU abort ? I'd hope the former.
>

It is fortunately a graceful error message, here an example:

$ virsh attach-device lateload curldisk.xml
Reported issue happens on attach:
root@b:~# virsh attach-device lateload cdrom-curl.xml
error: Failed to attach device from cdrom-curl.xml
error: internal error: unable to execute QEMU command 'device_add':
Property 'virtio-blk-device.drive' can't find value
'drive-virtio-disk2'

In the qemu output log we can see:
Failed to initialize module: /usr/lib/x86_64-linux-gnu/qemu/block-curl.so
Note: only modules from the same build can be loaded.



> >
> > On almost any other service than "qemu representing a VM" the answer
> > is "restart it", some even re-exec in place to keep things up and
> > running.
> >
> > Ideas so far:
> > a) Modules are checked by build-id, so keep them in a per build-id dir =
on disk
> >   - qemu could be made looking preferred in -$buildid dir first
> >   - do not remove the packages with .so's on upgrades
> >   - needs a not-too-complex way to detect which buildids running qemu p=
rocesses
> >     have for packaging to be able to "autoclean later"
> >   - Needs some dependency juggling for Distro packaging but IMHO can be=
 made
> >     to work if above simple "probing buildid of running qemu" would exi=
st
>
> So this needs a bunch of special QEMU hacks in package mgmt tools
> to prevent the package upgrade & cleanup later. This does not look
> like a viable strategy to me.
>
> >
> > b) Preload the modules before upgrade
> >   - One could load the .so files before upgrade
> >   - The open file reference will keep the content around even with the
> > on disk file gone
> >   - lacking a 'load-module' command that would require fake hotplugs
> > which seems wrong
> >   - Required additional upgrade pre-planning
> >   - kills most benefits of modular code without an actual need for it
> > being loaded
>
> Well there's two benefits to modular approach
>
>  - Allow a single build to be selectively installed on a host or containe=
r
>    image, such that the install disk footprint is reduced
>  - Allow a faster startup such that huge RBD libraries dont slow down
>    startup of VMs not using RBD disks.
>
> Preloading the modules before upgrade doesn't have to the second benefit.
> We just have to make sure the pre loading doesn't impact the VM startup
> performance.

I haven't looked at it that way yet and somewhat neglected former
suggestions of such a command.
I thought there might be concerns about "amount of loaded code", but
it shouldn't be "active" unless we really have a device of that kind
right?
You are right, it seems it won't "loose much" by loading all of them late.

> IOW, register a SIGUSR2 handler which preloads all modules it finds on
> disk. Have a pre-uninstall option on the .so package that sends SIGUSR2
> to all QEMU processes. The challenge of course is that signals are
> async.

If there would be something simple as log line people could check on
that to ensure the async loading is done.
Not perfectly synchronous, but maybe useful if a new QMP is considered
too heavy.

> You might suggest a QMP command, but only 1 process can have the
> QMP monitor open at any time and that's libvirt. Adding a second QMP
> monitor instance is possible but kind of gross for this purpose.

This (hopefully) already is a corner case.
I think admins would be ok with `virsh qemu-monitor-command` or such.
No need for a second QMP monitor IMHO.

> Another option would be to pre-load the modules during startup, but
> do it asynchronously, so that its not blocking overall VM startup.
> eg just before starting the mainloop, spawn a background thread to
> load all remaining modules.
>
> This will potentially degrade performance of the guest CPUs a bit,
> but avoids the latency spike from being synchronous in the startup
> path.

As above, I think it could be ok to load them even later than main
loop as long as there is e.g. a reliable entry people can check.
But this comes close to a QMP "are things loaded" command and in this
case the synchronous "load-all-you-find" command seems to make more
sense.

>
> > c) go back to non modular build
> >   - No :-)
> >
> > d) anything else out there?
>
> e) Don't do upgrades on a host with running VMs :-)
>
>    Upgrades can break the running VM even ignoring this particular
>    QEMU module scenario.

Which is true and I think clear in general - I'd even assume it is a
general guidance for almost all admins.
But we all know that things never end up so perfect, which is why I
directly started with the example case of a guest that can neither
migrate away nor be restarted.

> f) Simply document that if you upgrade with running VMs that some
>    features like hotplug of RBD will become unavailable. Users can
>    then avoid upgrades if that matters to them.

That is similar like your above approach.
It is absolutely valid and a good best practise policy, but the
question is how could we help out people that are locked in and still
want to avoid that.

Your suggestion of a sync "load-all-modules" command could be a way
out for people where policies are not, lets see what other people
think of it.

> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

