Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A7C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DAB2084E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 20:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXJjHjYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DAB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyi1r-0005x3-Ho
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 15:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iyi12-0005VV-IN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iyi0z-0004OE-Qr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:08:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iyi0z-0004KO-KR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 15:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580760492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itNJ2vbXgB49w4/XxyK+3vKsI/eyq6euWVzpiyx1hX8=;
 b=BXJjHjYbhSGsAoAdkC2ywv2KNKwTzR2nrmymULJIhRfQVULwL97VQpUNbWBzDlWNn8D8j2
 l+shhuJUSkOjEICltgNybeyMDrCnan+uISr8aaWQ+U2hnICOQcAOpQ9px7L9soLv4ero1J
 0+9WEVGnipgFzv1QNM+xpL/FBEpWucQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-orVj1DLYNlGigtZDpaKTPQ-1; Mon, 03 Feb 2020 15:08:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B8D88010CC;
 Mon,  3 Feb 2020 20:08:05 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.43.2.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD75719C69;
 Mon,  3 Feb 2020 20:07:54 +0000 (UTC)
Message-ID: <bc3e33efe9f4fe2447a964a86318856430e44d1a.camel@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
From: Andrea Bolognani <abologna@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Date: Mon, 03 Feb 2020 21:07:53 +0100
In-Reply-To: <878sloi0fp.fsf@dusky.pond.sub.org>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org> <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org> <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box> <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box> <878sloi0fp.fsf@dusky.pond.sub.org>
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: orVj1DLYNlGigtZDpaKTPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="=-i+8g+Z5gyEsJbqC6JgG9"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-i+8g+Z5gyEsJbqC6JgG9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-01-31 at 07:50 +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Much of this threads plays with the though that maybe we don't need any
> > compatibility and make the radical conclusion that we don't need any
> > human-friendly interface at all. Keeping full compatibility is the other
> > extreme.
> > 
> > There might be some middle ground where we break compatibility where the
> > old way can't easily be maintained with the new infrastructure, but
> > don't give up on the idea of being used by humans.
> 
> I'm not sure the connection between maintaining compatibility and
> supporting human use is as strong as you seem to imply.
> 
> As far as I can tell, the "maybe we don't need any compatibility"
> discussion is about the CLI.  I'd rephrase it as "maybe we need a
> machine-friendly CLI on par with QMP more than we need compatibility to
> the current CLI".
> 
> "We don't need any human-friendly interface at all" comes in not because
> machine-friendly necessarily precludes human-friendly, but only if we're
> unwilling (unable?) to do the extra work for it.
> 
> Compare the monitor:
> 
> * QMP is primarily for machines.  We promise stability: no incompatible
>   changes without clear communicaton of intent and a grace period.  We
>   provide machine clients tools to deal with the interface evolution,
>   e.g. query-qmp-schema.
> 
> * HMP is exclusively for humans.  It may change at any time.
> 
> For the CLI, we don't have such a separation, and our offerings for
> dealing with interface evolution are wholly inadequate.  We *need* to do
> better for machines.
> 
> Now, the monitor also informs us about the cost of providing a
> completely separate interface for humans.
> 
> Elsewhere in this thread, we discussed layering (a replacement for) HMP
> on top of QMP cleanly, possibly in a separate process, possibly written
> in a high-level language like Python.
> 
> HMP predates QMP.  We reworked it so the HMP commands are implemented on
> top of the QMP commands, or at least on top of common helpers.  But this
> is not quite the same as layering HMP on top of QMP.
> 
> If we decide to radically break the CLI so we can start over, we get to
> decide whether and how to do a human-friendly CLI, in particular how it
> relates to the machine-friendly CLI.

Does a machine-friendly CLI need to exist at all? Once you decide
that throwing away the current one is acceptable, you might as well
reduce the maintainance burden by requiring that software only
communicates with QEMU via QMP.

Does a human-friendly CLI need to be part of QEMU? We have built so
much amazing infrastructure on top of QEMU, and as of today none of
that work is benefiting people who run it directly.


As a proof of concept, I have spent a couple of hours writing the
attached shell script, which I hope will illustrate my point.

Usage is extremely simple: just do something like

  $ ./virt-run debian-10-openstack-amd64.qcow2

and after a few seconds the guest display will appear on your screen.

Behind the scenes, it uses a number of existing high-level tools:

  * virt-inspector, to figure out what guest OS is installed in the
    image;

  * virt-install, to produce a domain XML tailored to that specific
    guest OS and to create the corresponding libvirt domain;

  * virt-viewer, to provide the UI.

All these tools use libvirt under the hood, and additionally
virt-install uses libosinfo to obtain information about the guest
OS, such as whether or not it supports Virtio devices and how much
memory it needs to run smoothly.


The result is that, if you run

  $ qemu-system-x86_64 -hda debian-10-openstack-amd64.qcow2

you will get

  * a single CPU emulated with TCG;

  * 128 MiB of memory;

  * emulated I/O devices;

whereas the script will give you

  * 2 CPUs accelerated with KVM;

  * 1 GiB of memory;

  * Virtio devices for pretty much everything, including a
    virtio-rng device that will for example speed up the first boot
    significantly if SSH keys need to be (re)created.

Unsurprisingly, performance is different: when QEMU is invoked
directly, the login prompt for this specific image shows up after
~40 seconds, whereas when we use the script it only takes ~13 seconds
to get there. And the command line is just as simple, if not more so!

All of the above was obtained by hastily cobbling together existing
tools with <100 lines of shell scripting. Imagine how much better it
could be if we actually put some serious work in!


With my argument hopefully demonstrated: I think an architecture akin
to the one Dan has outlined earlier[1] would be a great direction to
take. QEMU can continue to focus on its core competency, that is,
virtual hardware, and leave most of the user interaction up to the
software interacting with its JSON-based API.


Obviously QEMU developers, for their own use, could still benefit
from having access to a user interface that doesn't require either
rigging up libvirt support or messing with JSON directly, and such
an interface could even look very similarly to the current CLI, but
it could simply not be made user-facing and thus not subject to any
compatibility concerns.


[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg06034.html
-- 
Andrea Bolognani / Red Hat / Virtualization

--=-i+8g+Z5gyEsJbqC6JgG9
Content-Type: application/x-shellscript; name="virt-run"
Content-Disposition: attachment; filename="virt-run"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpkaWUoKSB7CiAgICBlY2hvICIkQCIgPiYyCiAgICBleGl0IDEKfQoKY2hlY2tf
Y29tbWFuZCgpIHsKICAgIHRlc3QgLXggIiQod2hpY2ggIiQxIiAyPi9kZXYvbnVsbCkiCn0KCmRl
dGVjdF9vcygpIHsKICAgIGZ1bGw9JCh2aXJ0LWluc3BlY3RvciAtYSAiJDEiKQoKICAgIG9zaW5m
bz0kKGVjaG8gIiRmdWxsIiB8IHZpcnQtaW5zcGVjdG9yIC0teHBhdGggJy8vb3NpbmZvL3RleHQo
KScpCiAgICBpZiB0ZXN0ICIkb3NpbmZvIjsgdGhlbgogICAgICAgIGVjaG8gIiRvc2luZm8iCiAg
ICAgICAgcmV0dXJuCiAgICBmaQoKICAgICMgSWYgZGV0ZWN0aW9uIGZhaWxlZCwgZmFsbCBiYWNr
IHRvIHNvbWV0aGluZyB3ZSBjYW4gcmVhc29uYWJseSBleHBlY3QKICAgICMgdG8gd29yayBmb3Ig
bW9zdCBpbWFnZXMsIGFsdGhvdWdoIGxpa2VseSB3aXRoIHJlZHVjZWQgcGVyZm9ybWFuY2UKICAg
IGVjaG8gJ3dpbnhwJwp9CgpnZW5lcmF0ZV9uYW1lKCkgewogICAgdW5pcXVlPSQoZGQgaWY9L2Rl
di91cmFuZG9tIGJzPTggY291bnQ9MSAyPi9kZXYvbnVsbCB8IGJhc2U2NCB8IHNlZCAncy9bXmEt
ekEtWjAtOV0vL2cnKQogICAgYmFzZT0kKGJhc2VuYW1lICIkMSIgfCB0ciAnIC4tJyBfKQoKICAg
IGVjaG8gIiR7YmFzZX1fJHVuaXF1ZSIKfQoKbWFpbigpIHsKICAgIHRlc3QgIiQxIiB8fCBkaWUg
IlVzYWdlOiAkMCBJTUFHRSBbVklSVF9JTlNUQUxMX09QVElPTi4uLl0iCgogICAgIyBUaGUgZmly
c3QgYXJndW1lbnQgaXMgdGhlIHBhdGggdG8gdGhlIGRpc2sgaW1hZ2UKICAgIGltYWdlPSQxCgog
ICAgIyBFdmVyeXRoaW5nIHRoYXQgY29tZXMgYWZ0ZXIgdGhhdCB3aWxsIGJlIHBhc3NlZCB2ZXJi
YXRpbSB0bwogICAgIyB2aXJ0LWluc3RhbGwuIFVzZWZ1bCB0byBmaXggbWlzdGFrZXMgaW4gZ3Vl
c3QgT1MgZGV0ZWN0aW9uLCBvdmVycmlkZQogICAgIyB0aGUgZGVmYXVsdCBhbW91bnQgb2YgbWVt
b3J5IGFuZCBzbyBvbgogICAgc2hpZnQKICAgIHZpcnRfaW5zdGFsbF9vcHRpb25zPSIkQCIKCiAg
ICAjIE1ha2Ugc3VyZSBhbGwgY29tbWFuZHMgd2UgbmVlZCBhcmUgcHJlc2VudAogICAgZm9yIGNv
bW1hbmQgaW4gdmlydC1pbnNwZWN0b3IgdmlydC1pbnN0YWxsIHZpcnQtdmlld2VyIHZpcnNoOyBk
bwogICAgICAgIGNoZWNrX2NvbW1hbmQgIiRjb21tYW5kIiB8fCBkaWUgIiRjb21tYW5kIG5vdCBm
b3VuZCIKICAgIGRvbmUKCiAgICBlY2hvICdEZXRlY3RpbmcgZ3Vlc3QgT1MsIHBsZWFzZSB3YWl0
Li4uJwogICAgb3NfdmFyaWFudD0kKGRldGVjdF9vcyAiJGltYWdlIikKICAgIG5hbWU9JChnZW5l
cmF0ZV9uYW1lICIkaW1hZ2UiKQoKICAgIGVjaG8KICAgIGVjaG8gJz09PT09JwogICAgZWNobyAi
SW1hZ2UgaXM6ICRpbWFnZSIKICAgIGVjaG8gIkd1ZXN0IE9TIGlzOiAkb3NfdmFyaWFudCIKICAg
IGVjaG8gIlZNIG5hbWUgaXM6ICRuYW1lIgogICAgZWNobyAnPT09PT0nCiAgICBlY2hvCgogICAg
ZWNobyAnUnVubmluZyBWTS4uLicKICAgIHNldCAteAogICAgdmlydC1pbnN0YWxsIFwKICAgICAg
ICAtLWltcG9ydCBcCiAgICAgICAgLS1uYW1lICIkbmFtZSIgXAogICAgICAgIC0tZGlzayAiJGlt
YWdlIiBcCiAgICAgICAgLS1vcy12YXJpYW50ICIkb3NfdmFyaWFudCIgXAogICAgICAgICR2aXJ0
X2luc3RhbGxfb3B0aW9ucwogICAgc2V0ICt4CgogICAgZWNobyAnQ2xlYW5pbmcgdXAuLi4nCiAg
ICB2aXJzaCB1bmRlZmluZSAiJG5hbWUiCiAgICB2aXJzaCBkZXN0cm95ICIkbmFtZSIKfQoKbWFp
biAiJEAiCg==
--=-i+8g+Z5gyEsJbqC6JgG9--


