Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7437FC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497DA206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497DA206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO24g-0003j7-9v
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:32:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO1vB-0002cQ-IB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO1vA-000659-8Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hO1vA-00064m-16
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F2777EBB1
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 15:22:19 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6F154FCB;
	Tue,  7 May 2019 15:22:14 +0000 (UTC)
Date: Tue, 7 May 2019 16:22:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nikos Mavrogiannopoulos <nmav@redhat.com>
Message-ID: <20190507152211.GU27205@redhat.com>
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
	<CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 15:22:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 11:59:05AM +0200, Nikos Mavrogiannopoulos wrote:
> In terms of RHEL what is preferred is (1) use a crypto lib, and (2) if
> that's not possible use getrandom(). That is summarized in this
> article:
> 
> https://www.redhat.com/en/blog/understanding-red-hat-enterprise-linux-random-number-generator-interface

For QEMU this would mean re-writing the code to use qcrypto_random_bytes
instead. This internal API is backed by a crypto lib if available,
falling back to /dev/urandom or /dev/random on UNIX, or CryptGenRandom
on Windows. We could add getrandom() support there too.

The main question is whether to implement a new backends/rng-builtin.c
or modify backends/rng-random.c so that it has a NULL filename by
default, which would be taken as meaning use the qcrypto_random_bytes
API.  The latter benefits that all existing VMs which don't have a
filename set would get the new behaviour. The latter has downside
that it is not discoverable from mgmt apps, so they won't know if
they can rely on it or not.

Thus I'd probably tend towards a new backend for discoverability.

> 
> On Thu, May 2, 2019 at 8:02 PM Kashyap Chamarthy <kchamart@redhat.com> wrote:
> >
> > [Reviving this old thread as I don't think we came to a conclusion on
> > this.]
> >
> > On Fri, Sep 21, 2018 at 05:43:23PM +0200, Kashyap Chamarthy wrote:
> > > Hi folks,
> > >
> > > As Markus pointed out in this 'qemu-devel' thread[1],
> > > backends/rng-random.c uses '/dev/random' in TYPE_RNG_RANDOM's
> > > instance_init() method:
> > >
> > >     [...]
> > >     static void rng_random_init(Object *obj)
> > >     {
> > >         RngRandom *s = RNG_RANDOM(obj);
> > >
> > >         object_property_add_str(obj, "filename",
> > >                                 rng_random_get_filename,
> > >                                 rng_random_set_filename,
> > >                                 NULL);
> > >
> > >         s->filename = g_strdup("/dev/random");
> > >         s->fd = -1;
> > >     }
> > >     [...]
> > >
> > > And I've looked at hw/virtio/virtio-rng.c:
> > >
> > >     [...]
> > >     static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
> > >     {
> > >     [...]
> > >
> > >         if (vrng->conf.rng == NULL) {
> > >             vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
> > >     [...]
> > >
> > > From the above, I'm assuming QEMU uses `/dev/random` as the _default_
> > > entropy source for a 'virtio-rng-pci' device.  If my assumption is
> > > correct, any reason why not to change the default entropy source for
> > > 'virtio-rng-pci' devices to `/dev/urandom` (which is the preferred[2]
> > > source of entropy)?
> > >
> > > And I understand (thanks: Eric Blake for correcting my confusion) that
> > > there are two cases to distinguish:
> > >
> > > (a) When QEMU needs a random number, the entropy source it chooses.
> > >     IIUC, the answer is: QEMU defers to GnuTLS by default, which uses
> > >     getrandom(2), which in turn uses '/dev/urandom' as its entropy
> > >     source; if getrandom(2) isn't available, GnuTLS uses `/dev/urandom`
> > >     anyway.  (Thanks: Nikos for clarifying this.)
> > >
> > >     If QEMU is built with GnuTLS _disabled_, which I'm not sure if any
> > >     Linux distribution does, then it uses libgcrypt, which in turn uses
> > >     the undesired and legacy `/dev/random` as the default entropy
> > >     source.
> > >
> > > (b) When QEMU exposes a Virtio RNG device to the guest, that device
> > >     needs a source of entropy, and IIUC, that source needs to be
> > >     "non-blocking" (i.e. `/dev/urandom`).  However, currently QEMU
> > >     defaults to the problematic `/dev/random`.
> > >
> > > I'd like to get some more clarity on case (b).
> > >
> > >
> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
> > >     -- RNG: Any reason QEMU doesn't default to `/dev/urandom`
> > >
> > > [2] http://man7.org/linux/man-pages/man4/urandom.4.html
> > >
> > >
> > > --
> > > /kashyap
> > >
> >
> > --
> > /kashyap
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

