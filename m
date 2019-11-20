Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76BB20878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch0Px2mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76BB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUOR-0008Qv-01
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iXUJO-0005gA-9N
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iXUJM-00074e-9O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:02:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iXUJM-00074A-1H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574272958;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYMnn3xDMQgLziWzXyYujuuMi/LJA2sGU+cy0z4/x38=;
 b=Ch0Px2mpmRZvqrWoKNsRR7NMOqd+MqmJF0TR7PHO2zP+w8jthM0pCSAM3e9vJj8WBU+1RV
 RikIwUMdXIVsy1tMxeGLC5CjFZml6chshtaKHFQ2/W669yDIrCOSStnY/xeUEophMPTGdt
 O3wZN9UTDKQ8zinRPdsQaqVPI9rrmkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-SexjqyqGOmWrXJGYEyt3Iw-1; Wed, 20 Nov 2019 13:02:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8366107ACC4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 18:02:33 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88BD51024802;
 Wed, 20 Nov 2019 18:02:32 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:02:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: add VMX features to named CPU models
Message-ID: <20191120180229.GQ2785116@redhat.com>
References: <20191120173753.8894-1-pbonzini@redhat.com>
 <20191120175002.GP2785116@redhat.com>
 <7e1b3701-8c5a-409c-8c8f-29cb673da3ac@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7e1b3701-8c5a-409c-8c8f-29cb673da3ac@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: SexjqyqGOmWrXJGYEyt3Iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 06:57:20PM +0100, Paolo Bonzini wrote:
> On 20/11/19 18:50, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 20, 2019 at 06:37:53PM +0100, Paolo Bonzini wrote:
> >> This allows using "-cpu Haswell,+vmx", which we did not really want to
> >> support in QEMU but was produced by Libvirt when using the "host-model=
"
> >> CPU model.
> > Can you say what is currently broken ?  If I launch my current QEMU (I =
have
> > 4.1.1 on Fedora 31):
> >=20
> >  qemu-system-x86_64 -cpu Haswell,+vmx
> >=20
> > ... I don't get any reported errors.
> >=20
>=20
> KVM does not load in the guest, though?

Ah ok, thanks. Can you just put something in the commit message to that
effect.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


