Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACECCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FBE21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FBE21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i183p-0005sb-BH
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i182w-0005Lo-Mz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i182v-0003rX-0J
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i182u-0003r1-PL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:47:56 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F31E12E5
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 11:47:55 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id t26so4752632otm.9
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VpJz1R41O0ql3kjRTcTXQuLXhW6if+E8mTdfcTt63TY=;
 b=OIeojC4UlkjJAf/qw1n+XCtQ8a8HF1RQnakTuqkAw8+b2/5jEaeRk/zSd/b/z626Ma
 v+IWmnzD43zM9fZzdYB0v+n7+a2tPQ3PqM21bMHO0gk3p1eXAa0olZZhS6dUCiai9y9O
 Lt4fc6MGQSfigV72UHXmfK2SUBqi4qfBR1R1GGWkpp3OLvV8pKRLIg2GBN1NspAJK9vv
 Xgd5gllGJ69EpSjqZTc4QWqsMOGwc8uMaViRTL2qOBMiWWiJk8oa7hPa36Oc7jnhjeGW
 Dr1qClr0K0RhhBDJWnIIU7Ir+HitVIFZ/H2634OzSoTKKC/oOmg3n3+SmiYOEeoZ9R6A
 i+KA==
X-Gm-Message-State: APjAAAXob1FEonQI1yXSM0No+KMQKl0FXB0oLNMEXQGRIjKJTP4ACepx
 SIhWzHaahoIJ9V8eQIWsg/42F685cv4j6cJJ5Fvrg/wvpMBzmyC8TyliGja0hwwej8wkSo3rznt
 B8Q8kmAcrrJ2WBiPYGwi0tLnZf2Ltbx4=
X-Received: by 2002:a05:6830:1307:: with SMTP id
 p7mr3639898otq.62.1566560874859; 
 Fri, 23 Aug 2019 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy56af+stOAFp8wRFj4o1L0L+Ml70soVoD7GN+3CNO0HhhRThYrNvOuhwIZtUPJO70s3LurRJdPwhfzHl/hgbI=
X-Received: by 2002:a05:6830:1307:: with SMTP id
 p7mr3639878otq.62.1566560874568; 
 Fri, 23 Aug 2019 04:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com>
In-Reply-To: <20190823114157.GG9654@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Aug 2019 15:47:43 +0400
Message-ID: <CAMxuvaxHzspfHNTOpcZxU5=xXUuG-_z2hECX8prZKtK-0aCUKQ@mail.gmail.com>
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

On Fri, Aug 23, 2019 at 3:42 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Aug 23, 2019 at 03:31:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Aug 23, 2019 at 3:21 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > >
> > > On Thu, Aug 08, 2019 at 07:03:23PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi,
> > > >
> > > > With external processes or helpers participating to the VM support,=
 it
> > > > becomes necessary to handle their migration. Various options exist =
to
> > > > transfer their state:
> > > > 1) as the VM memory, RAM or devices (we could say that's how
> > > >    vhost-user devices can be handled today, they are expected to
> > > >    restore from ring state)
> > > > 2) other "vmstate" (as with TPM emulator state blobs)
> > > > 3) left to be handled by management layer
> > > >
> > > > 1) is not practical, since an external processes may legitimatelly
> > > > need arbitrary state date to back a device or a service, or may not
> > > > even have an associated device.
> > > >
> > > > 2) needs ad-hoc code for each helper, but is simple and working
> > > >
> > > > 3) is complicated for management layer, QEMU has the migration timi=
ng
> > > >
> > > > The proposed "dbus-vmstate" object will connect to a given D-Bus
> > > > peer address, and save/load from org.qemu.VMState1 interface.
> > > >
> > > > This way, helpers can have their state migrated with QEMU, without
> > > > implementing another ad-hoc support (such as done for TPM emulation=
)
> > > >
> > > > I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
> > > > can be made to work on various other OSes. There are several
> > > > implementations and good bindings for various languages.
> > > > (the tests/dbus-vmstate-test.c is a good example of how simple
> > > > the implementation of services can be, even in C)
> > > >
> > > > v2:
> > > > - D-Bus is most common and practical through a bus, but it requires=
 a
> > > >   daemon to be running. I argue that the benefits outweight the cos=
t
> > > >   of running an extra daemon in v1 in the context of multi-process
> > > >   qemu, but it is also possible to connect in p2p mode as done in t=
his
> > > >   new version.
> > >
> > > So yesterday Stefanha brought up need for "mgmt apis" on the
> > > virtiofsd helper process & the conclusion is that dbus makes
> > > most sense for this purpose:
> > >
> > >   https://www.redhat.com/archives/virtio-fs/2019-August/msg00339.html
> > >
> > > This use case is a slightly different from vmstate though.
> > >
> > > For vmstate we have two parties - virtiofsd and QEMU talking
> > >
> > > For the "mgmt apis" in virtiofsd, we have arbitrary parties
> > > involved - virtiofsd *and* an admin client tool, and/or
> > > maybe libvirt.
> > >
> > > I think this different scenario means that we do in fact need
> > > to have a bus present, as the p2p model doesn't scale well
> > > to many clients.
> > >
> > > Even if we have 1 dbus-daemon per QEMU instance, we need to cope
> > > with multiple instances of the same helper needing to connect.
> > > So we need to come up with some for identifying services. Normally
> > > DBus only allows 1 peer to own a given well known service name at
> > > any time.  So we can't simply talk to a well-known 'org.qemu.virtiofs=
d'
> > > service name.
> > >
> > > Each service would need to to just rely on exporting objects under
> > > its unique service id  (they look like :1.NNNN for some uniq NNN)
> > >
> > > QEMU still needs to known which connections on the bus are actually
> > > providing vhost-user services, and which are other things (like
> > > libvirt or random mgmt tools)
> > >
> > > So perhaps QEMU should expose a service  'org.qemu.VhostUserManager'
> > > with an object /org/qemu/VhostUSerManager
> > >
> > > Each helper supporting vmstate could register its existance
> > > by invoking a method
> > >
> > >    org.qemu.VhostUserManager.Register(":1.NNNN")
> >
> >
> > There is no need for extra registration if the services are queued.
> > You can then query the queue of org.qemu.VhostUser instances.
> >
> > This is the approach I took in v1 of this series with
> > org.qemu.VMState1 service name.
> >
> > See https://patchew.org/QEMU/20190708072437.3339-1-marcandre.lureau@red=
hat.com/20190708072437.3339-4-marcandre.lureau@redhat.com/
>
> I think that's a pretty gross hack tha is abusing the unique service
> concept, as we clearly don't have unique services anymore.

"well-known" names are not "unique". I think you are restricting what
"well-known" names are and how to use them. The queued owner concept
has always been there.

>
> > Other approaches are common prefix (ex:
> > org.mpris.MediaPlayer2.FooBar), which also allows to identify a
> > particular implementation in a simple way.
>
> This means QEMU still has to iterate over every single client
> on the bus to identify them. If you're doing that, there's
> no point in owning a well known service at all. Just iterate
> over the unique bus names and look for the exported object
> path /org/qemu/VMState

Not exactly, since it wouldn't have to query each connection, but only the =
bus.

>
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

