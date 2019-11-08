Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF82C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8556520869
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDdSSR57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8556520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2Wa-0003HJ-Jz
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iT2Vu-0002q7-UD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iT2Vr-00037q-If
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:33:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iT2Vr-00037Q-Cz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573212790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHETSQ950wkWja+qUNXFzQL/4kxS3PBw+B6QaLDaHrE=;
 b=FDdSSR57ghEBYz7jzLveQMcCUjTuc059ELrZJgw3KsFh80eGBqDxuaqSnhNjns4BG4MIOw
 lpc3Fo6kJFRtKv1TWsM16wD5SPrnCsFjfxxheuRUHsNinQ6NkHLgG9J0BvvQFT/oMqg4MM
 SeodLOV4fQlb2K8VDRfnmsVo2FB3g+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-fxXt_MQ-PdmIDgvJ6TOm1w-1; Fri, 08 Nov 2019 06:33:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F131005500;
 Fri,  8 Nov 2019 11:33:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31D14600CA;
 Fri,  8 Nov 2019 11:32:51 +0000 (UTC)
Date: Fri, 8 Nov 2019 11:32:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191108113248.GJ182396@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
 <20191107093059-mutt-send-email-mst@kernel.org>
 <20191108111741.GD402228@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191108111741.GD402228@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fxXt_MQ-PdmIDgvJ6TOm1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 kanth.ghatraju@oracle.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 rth@twiddle.net, kwolf@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 12:17:41PM +0100, Stefan Hajnoczi wrote:
> On Thu, Nov 07, 2019 at 09:33:45AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
> > > This documentation suggests that QEMU spawns the remote processes.  H=
ow
> > > do this work with unprivileged QEMU?  Is there an additional step whe=
re
> > > QEMU drops privileges after having spawned remote processes?
> > >=20
> > > Remote processes require accesses to resources that the main QEMU
> > > process does not need access to, so I'm wondering how this process mo=
del
> > > ensures that each process has only the privileges it needs.
> >=20
> > I guess you have something like capabilities in mind?
>=20
> Or namespaces (unshare(2)).
>=20
> > When using something like selinux, priviledges are per binary
> > so the order of startup doesn't matter.
>=20
> For static SELinux policies that make sense, thanks for explaining.
>=20
> Does libvirt also perform dynamic (i.e. per-instance) SELinux
> configuration?  I guess that cannot be associated with a specific binary
> because multiple QEMU instances launch the same binary yet need to be
> differentiated.

In a traditional SELinux approach, the SELinux context used for any
process is determined by a combination of the label on the binary
and a transition rule.

eg if the qemu-system-x86_64 file is labelled qemu_exec_t, and
there's a context qemu_t for the QEMU process, a transition
rule is defined  "virtd_t + qemu_exec_t ->  qemu_t". This says
that when a process with context "vird_t" execs a binary labelled
qemu_exec_t, the new process gets qemu_t.

We sVirt, however, we can't rely on automatic transitions, because
we need to assign a unique MCS tag for each VM. Thus libvird will
explicitly tell SELinux what label to apply.

In the case of multiprocess QEMU, if using sVirt from libvirt, then
we'll need to continue setting the explicit labels as we'll still
need the MCS tags for each helper process.

If not using libvirt and sVirt, and wanting automatic SELinux
transitions for QEMU helper processes, then each helper would
need to be a separate binary on disk so that each helper can
be given a distinct file label, which in turns lets you define
a set of transitions for each helper according to its expected
access needs.

Having said all that I don't think its worth worrying about
this. Anyone who cares about SELinux with QEMU will want to
be using sVirt  or an equivalent approach to assign unique
MCS per VM. And thus automatic transitions are not possible
even if we had distinct binaries for each helper.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


