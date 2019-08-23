Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96788C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4CB21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4CB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i17op-0004ls-Jj
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i17n1-0003To-S0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i17mz-0008ML-T2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i17mz-0008Ko-H7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:31:29 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D0444E93D
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 11:31:28 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id y18so4739552oto.21
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 04:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9rFD4iE2c/oCg2BukaoW00omWw2NGXi5wXY3WN5nWhU=;
 b=SS5+mmmboIAdMzeME4K5CP5XlyS+4s/wkjFEjwXC3JzYOXc/h6wUIgElyabjcWScNO
 MvLrta00GSnsGPK5ZzIW8AlZRSwI0EUcbfMK9v8GrOs5Vm+i6YK31P4Se7GY/wWDPhtC
 x47MF33JtoMKVM2uEpUEtsRuSWHTM9fSxcQKJ47Ugl0we3hU11/76qD7p778jEYqSTgt
 QFQ3rOKSJWMpVUSKjO74blyL7+puaM8nLN8n+05hfUJTyaz/MhC9YucoFRrEwtqGAKve
 GID3ZGTXZxgOYBohv/Nrv5feL/kuBQX4pRp9nM1uzURhADHD1VwjQipH7Yv9HWX/9Ldg
 Ky/A==
X-Gm-Message-State: APjAAAWaGj40rbr5cdbn201flRaKVyN0doDYtspTV5XSC9F3awQ1K6+b
 7prvDsNZWNxzuLDGlsF9cL9Boqryay7Jj+7VuKnUGQeOb1xrO6pAl99a3tAqXERVjrM+3gUOHXr
 8tCV4l8s0AJu8jhiLe1hm1G8P/VrbFMs=
X-Received: by 2002:a05:6808:9b6:: with SMTP id
 e22mr2752194oig.6.1566559887825; 
 Fri, 23 Aug 2019 04:31:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCTYvZiXHLASYM12gH6N3F2SXBGg8yxh15Nts+cf28c9GBAas7gf1gw0+UObC3VtT40er29pllnn03kT+w1uQ=
X-Received: by 2002:a05:6808:9b6:: with SMTP id
 e22mr2752172oig.6.1566559887516; 
 Fri, 23 Aug 2019 04:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
In-Reply-To: <20190823112053.GE9654@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Aug 2019 15:31:16 +0400
Message-ID: <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add dbus-vmstate
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
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 23, 2019 at 3:21 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Thu, Aug 08, 2019 at 07:03:23PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > With external processes or helpers participating to the VM support, it
> > becomes necessary to handle their migration. Various options exist to
> > transfer their state:
> > 1) as the VM memory, RAM or devices (we could say that's how
> >    vhost-user devices can be handled today, they are expected to
> >    restore from ring state)
> > 2) other "vmstate" (as with TPM emulator state blobs)
> > 3) left to be handled by management layer
> >
> > 1) is not practical, since an external processes may legitimatelly
> > need arbitrary state date to back a device or a service, or may not
> > even have an associated device.
> >
> > 2) needs ad-hoc code for each helper, but is simple and working
> >
> > 3) is complicated for management layer, QEMU has the migration timing
> >
> > The proposed "dbus-vmstate" object will connect to a given D-Bus
> > peer address, and save/load from org.qemu.VMState1 interface.
> >
> > This way, helpers can have their state migrated with QEMU, without
> > implementing another ad-hoc support (such as done for TPM emulation)
> >
> > I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
> > can be made to work on various other OSes. There are several
> > implementations and good bindings for various languages.
> > (the tests/dbus-vmstate-test.c is a good example of how simple
> > the implementation of services can be, even in C)
> >
> > v2:
> > - D-Bus is most common and practical through a bus, but it requires a
> >   daemon to be running. I argue that the benefits outweight the cost
> >   of running an extra daemon in v1 in the context of multi-process
> >   qemu, but it is also possible to connect in p2p mode as done in this
> >   new version.
>
> So yesterday Stefanha brought up need for "mgmt apis" on the
> virtiofsd helper process & the conclusion is that dbus makes
> most sense for this purpose:
>
>   https://www.redhat.com/archives/virtio-fs/2019-August/msg00339.html
>
> This use case is a slightly different from vmstate though.
>
> For vmstate we have two parties - virtiofsd and QEMU talking
>
> For the "mgmt apis" in virtiofsd, we have arbitrary parties
> involved - virtiofsd *and* an admin client tool, and/or
> maybe libvirt.
>
> I think this different scenario means that we do in fact need
> to have a bus present, as the p2p model doesn't scale well
> to many clients.
>
> Even if we have 1 dbus-daemon per QEMU instance, we need to cope
> with multiple instances of the same helper needing to connect.
> So we need to come up with some for identifying services. Normally
> DBus only allows 1 peer to own a given well known service name at
> any time.  So we can't simply talk to a well-known 'org.qemu.virtiofsd'
> service name.
>
> Each service would need to to just rely on exporting objects under
> its unique service id  (they look like :1.NNNN for some uniq NNN)
>
> QEMU still needs to known which connections on the bus are actually
> providing vhost-user services, and which are other things (like
> libvirt or random mgmt tools)
>
> So perhaps QEMU should expose a service  'org.qemu.VhostUserManager'
> with an object /org/qemu/VhostUSerManager
>
> Each helper supporting vmstate could register its existance
> by invoking a method
>
>    org.qemu.VhostUserManager.Register(":1.NNNN")


There is no need for extra registration if the services are queued.
You can then query the queue of org.qemu.VhostUser instances.

This is the approach I took in v1 of this series with
org.qemu.VMState1 service name.

See https://patchew.org/QEMU/20190708072437.3339-1-marcandre.lureau@redhat.=
com/20190708072437.3339-4-marcandre.lureau@redhat.com/

as well as the libvirt series
https://patchew.org/Libvirt/20190708070747.1962-1-marcandre.lureau@redhat.c=
om/


Other approaches are common prefix (ex:
org.mpris.MediaPlayer2.FooBar), which also allows to identify a
particular implementation in a simple way.

>
> For things we want every vhost user daemon to implement, we can
> define well known objects paths & intefaces to expose at the path.
>
> eg If the helper supports vmstate dump, it should export an object
> at the well known path "/org/qemu/VMState" with methods x, y & z
>
> If the helper supports debug logging it should export an object at
> the well known path "/org/qemu/Logger" with method a, b & c
>
> etc
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

