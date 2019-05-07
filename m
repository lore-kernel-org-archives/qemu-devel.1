Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F62C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9C5206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9C5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3t4-0004j2-5s
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 13:28:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO3sK-0004Lc-9C
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO3sJ-0007Ap-1I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hO3sI-0007AO-Oq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC46988305;
	Tue,  7 May 2019 17:27:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3F660BF3;
	Tue,  7 May 2019 17:27:20 +0000 (UTC)
Date: Tue, 7 May 2019 18:27:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190507172717.GZ27205@redhat.com>
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
	<CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
	<20190507152211.GU27205@redhat.com>
	<82f77ed6-b308-c5b0-2bdc-3f18472d7061@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82f77ed6-b308-c5b0-2bdc-3f18472d7061@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 17:27:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Nikos Mavrogiannopoulos <nmav@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 10:14:25AM -0700, Richard Henderson wrote:
> On 5/7/19 8:22 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 07, 2019 at 11:59:05AM +0200, Nikos Mavrogiannopoulos wro=
te:
> >> In terms of RHEL what is preferred is (1) use a crypto lib, and (2) =
if
> >> that's not possible use getrandom(). That is summarized in this
> >> article:
> >>
> >> https://www.redhat.com/en/blog/understanding-red-hat-enterprise-linu=
x-random-number-generator-interface
> >=20
> > For QEMU this would mean re-writing the code to use qcrypto_random_by=
tes
> > instead. This internal API is backed by a crypto lib if available,
> > falling back to /dev/urandom or /dev/random on UNIX, or CryptGenRando=
m
> > on Windows. We could add getrandom() support there too.
>=20
> At least this last step is done:
>=20
>   https://patchwork.ozlabs.org/patch/1056828/

Ah yes, I forgot you had done that already, which is nice.

> > The main question is whether to implement a new backends/rng-builtin.=
c
> > or modify backends/rng-random.c so that it has a NULL filename by
> > default, which would be taken as meaning use the qcrypto_random_bytes
> > API.  The latter benefits that all existing VMs which don't have a
> > filename set would get the new behaviour. The latter has downside
> > that it is not discoverable from mgmt apps, so they won't know if
> > they can rely on it or not.
> >=20
> > Thus I'd probably tend towards a new backend for discoverability.
>=20
> What does it mean to rely on the filename, really?
>=20
> We could special case "/dev/urandom" as qcrypto_random_bytes, which wou=
ld end
> up using getrandom(2) or /dev/urandom via the crypto lib anyway.
>=20
> We could even special case "/dev/random" as getrandom(2) w/GRND_RANDOM,=
 if we
> cared to bypass the crypto lib.

IME magic like this has a habit of coming back to bite you. eg if we late=
r
find there is some use case where its important to /really/ use /dev/uran=
dom
and we've magically turned /dev/urandom into a call to gnutls, we're stuc=
k.

If we want to use qcrypto_random_bytes we must have an explicit way to ge=
t
that, rather than changing semantics of existing filenames apps might be
passing.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

