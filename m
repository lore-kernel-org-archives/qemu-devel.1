Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE701C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24A8205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24A8205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGP53-0000Ob-Gp
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 10:29:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGP41-0008LF-VG
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGP40-0002vG-PM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGP40-0002uk-EB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 782734E90E;
	Tue, 16 Apr 2019 14:27:55 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F4019C7D;
	Tue, 16 Apr 2019 14:27:48 +0000 (UTC)
Date: Tue, 16 Apr 2019 15:27:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416142745.GP31311@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415203917.GA32317@habkost.net>
	<20190416081605.GB31311@redhat.com>
	<20190416142313.GE32317@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190416142313.GE32317@habkost.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 16 Apr 2019 14:27:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: mst@redhat.com, Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416142745.zelKWo3FYyIQwhg_6mTKx2QevQbeOrXQXiofNwIU7Lg@z>

On Tue, Apr 16, 2019 at 11:23:13AM -0300, Eduardo Habkost wrote:
> On Tue, Apr 16, 2019 at 09:16:05AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Mon, Apr 15, 2019 at 05:39:17PM -0300, Eduardo Habkost wrote:
> > > On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> > > > Add a new base CPU model called 'Dhyana' to model processors from=
 Hygon
> > > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > > >=20
> > > > The following features bits have been removed compare to AMD EPYC=
:
> > > > aes, pclmulqdq, sha_ni
> > > >=20
> > > > The Hygon Dhyana support to KVM in Linux is already accepted upst=
ream[1].
> > > > So add Hygon Dhyana support to Qemu is necessary to create Hygon'=
s own
> > > > CPU model.
> > > >=20
> > > > Reference:
> > > > [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc=
9adf87
> > > >=20
> > > > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > >=20
> > > Thanks for the patch.
> > >=20
> > > I'm wondering if we should let the CPU model be used only on
> > > Hygon hosts, to avoid confusion.
> >=20
> > Why should we artificially restrict it ?  All the other CPUs are able=
 to
> > be used on any host that is able to support the feature list required=
 by
> > the CPU model. If some other host has sufficient features to run Dhya=
na
> > the CPU model we shouldn't block it.
>=20
> Running it on Intel or AMD hosts will create a frankenstein CPU
> with vendor=3DAuthenticAMD|GenuineIntel but with
> family/model/stepping/model_id values that make sense only on
> Hygon CPUs.  I don't see why this is preferable to simply telling
> the user that the CPU model is unavailable.

IIUC, you're saying that we don't (can't?) honour the "vendor" field
QEMU has listed against the CPU model, so the guest sees the vendor
of the real physical host ?

If so that's news to me, and does indeed make it interesting to
disable the mismatched combination.

> If somebody really needs that specific set of features and know
> they are runnable on their AMD host, they can easily run
> "-cpu EPYC,+aes,+pclmulqdq,+sha-ni".
>=20
> We have the same issue with Intel & AMD CPUs.  The only reason we
> don't prevent this with AMD or Intel CPU models is our huge fear
> of breaking backwards compatibility.

We could put a deprecation warning that we intended to stop allowing
this mismatch Intel/AMD guest vs host models and tie it to machine
type.

ie, if we deprecate in 4.1, then in 5.0 we can make pc-i440fx-5.0
machine type refuse to allow this combination.

That way existing deployed guests keep working, and users get some
warning that we're going to stop future guests doing this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

