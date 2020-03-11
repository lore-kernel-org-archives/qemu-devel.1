Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FEC10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042062146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX4tnGPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042062146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuu3-0006iV-6F
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBurw-00048J-R2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBuru-0001U0-0u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBurt-0001Py-JK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583908164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKE/hnYUqsdtGChb/PvxGkZTt9Mev3XKOf2/glRGxqU=;
 b=gX4tnGPMdUTcw5W+zbXbS+ZKOuf4N6I9xwUx9+Eb3+6WUYNfMlqqeFC4qV5A2O0pR/pCxX
 D6WjgVKYtDqvCwjwlXIV8LYi8qHsIwSDlidLYzkpxnLXGnb3T+Yf9wj3ZIxm8rcNqANpKK
 h3cu/ns7cKnn75wuRwRYEOiJyNDi0+M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Xy9AE79-P3WmF95d5orFtg-1; Wed, 11 Mar 2020 02:29:23 -0400
X-MC-Unique: Xy9AE79-P3WmF95d5orFtg-1
Received: by mail-qv1-f72.google.com with SMTP id a12so704140qvv.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g5lA92+3jq8tJNvzRJUtuPhUdhnc9K7jJNvZyPV/GRs=;
 b=JWGmqGo36T+5xotlE8WlUWMYugz7+pHlQNbcQ9fEw/L9YRG5yVhqLySf3yayeKMRZl
 ex/EXBO1whsPYAV0gOsyD43ari7BapfX79yNvfSRMpv9VnA0tJeax5scYH/ujAFRkINS
 upnIYLtD8/LbzPsMU9fqIG9ifdjknu65/IToo6vVl1T1hb2qPt08lCXp5rNYlZwvOMFV
 jZ6E9aIpszZxKRrAG30Wnz65x40Lt1dRkbEz0tDV9jFTB82FBxmWZ+vmSO98iuZFn3aV
 olg2T9wAEOC1x17NJm5VfjbGpvEB2ekaJkIQuBshsJSydTK4WQZGycPVG5U9FULBG1jz
 XCrA==
X-Gm-Message-State: ANhLgQ2kpC/W3KqL4NFV2RnuwWJP7znLahixzrj2D8ukjgbsbVJiDEKx
 LHt0BvsVDZTHZs+gQLZzspSiLRNjzpJbdtIlmIFOI8nHi0gje01Q3JIKtgK49kdlg9tGNitpRtf
 0J+FQ/NkhQTOqCwU=
X-Received: by 2002:a0c:fb03:: with SMTP id c3mr1529016qvp.13.1583908162451;
 Tue, 10 Mar 2020 23:29:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvb6zxHvfcibpypkdV7DJOVnjcGji4umQPPlf4jeyqG3WT3pxgPG9dEglXVFJCER2Oyqwsrow==
X-Received: by 2002:a0c:fb03:: with SMTP id c3mr1528999qvp.13.1583908162123;
 Tue, 10 Mar 2020 23:29:22 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id d22sm5514698qte.93.2020.03.10.23.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:29:21 -0700 (PDT)
Date: Wed, 11 Mar 2020 02:29:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <20200311022120-mutt-send-email-mst@kernel.org>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
 <20200310164239-mutt-send-email-mst@kernel.org>
 <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
 <20200310173020-mutt-send-email-mst@kernel.org>
 <95fdfa38-1ef1-8735-2d50-e24c8a909144@oracle.com>
 <20200310175825-mutt-send-email-mst@kernel.org>
 <b7e638a0-959a-4db0-7056-a0ab490a404b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b7e638a0-959a-4db0-7056-a0ab490a404b@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:19:59AM +0200, Liran Alon wrote:
>=20
> On 11/03/2020 0:00, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 11:57:49PM +0200, Liran Alon wrote:
> > > On 10/03/2020 23:44, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 02:29:42PM -0700, Liran Alon wrote:
> > > > > On 10/03/2020 22:56, Michael S. Tsirkin wrote:
> > > > > > On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
> > > > > > > On 10/03/2020 19:44, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > This series aims to fix several bugs in VMPort and improv=
e it by supporting
> > > > > > > > > more VMPort commands and make command results more config=
urable to
> > > > > > > > > user via QEMU command-line.
> > > > > > > > >=20
> > > > > > > > > This functionality was proven to be useful to run various=
 VMware VMs
> > > > > > > > > when attempting to run them as-is on top of QEMU/KVM.
> > > > > > > > >=20
> > > > > > > > > For more details, see commit messages.
> > > > > > > > Well two versions in one day and some review comments weren=
't addressed.
> > > > > > > There is a single review comment that wasn't addressed which =
is replacing an
> > > > > > > enum with a comment. And I explicitly mentioned that it's bec=
ause I want
> > > > > > > additional opinion on this.
> > > > > > > I don't see why such a small thing should block review for 15=
 patches...
> > > > > > > All the rest of the comments (Which were great) have been add=
ressed. Unless
> > > > > > > I have mistakenly missed something, which please point it out=
 if I did.
> > > > > > OK I just took a quick peek, two things quickly jumped out at m=
e.
> > > > > Thanks for having a look.
> > > > > > version property really should be a boolean and have some docum=
entation
> > > > > > saying what functionality enables.
> > > > > I thought that having a version number approach is more generic a=
nd easy to
> > > > > maintain going forward.
> > > > > If I understand correctly, this is also the approach taken by qxl=
 & qxl-vga.
> > > > >=20
> > > > > The more elaborate alternative could have been introducing compat=
_flags (As
> > > > > PVSCSI does) but it seems like it will pollute the property space=
 with a lot
> > > > > of useless VMPort properties.
> > > > > (E.g. x-read-eax-bug, x-no-report-unsupported-cmd, x-no-report-vm=
x-type and
> > > > > etc.).
> > > > >=20
> > > > > What is the advantage of having a boolean such as "x-vmport-v2" i=
nstead of
> > > > > having a single "version" property?
> > > > It's not clear what should happen going forward. Let's say version =
is
> > > > incremented again. This then becomes challenging for downstreams to
> > > > backport.
> > > As all conditions are in the form of "if (s->version > X)" then incre=
menting
> > > version from 1 to 2 doesn't break any condition of "if (s->version > =
1)".
> > > What is the challenge of backporting I'm missing?
> > the challenge is figuring out which parts does version apply to.
> > It might be easy if there's just code, harder if there's
> > also data, etc.
> You mean things such as the following?
> s->some_field =3D (s->version > X) ? A : B;
>=20
> True that it could be a bit more difficult to spot.
>=20
> > > > > Will it suffice if I would just add documentation above "version"=
 property
> > > > > on what is was the functionality in "version=3D=3D1"?
> > > > > (Though, it's just easy to scan the vmport.c code for if's involv=
ing
> > > > > ">version"... "version" is more of an internal field for machine-=
type
> > > > > compatibility and not really meant to be used by user)
> > > > >=20
> > > > > Which approach do you prefer?
> > > > I just dislike versions, they are hard to maintain.
> > > >=20
> > > > Individual ones is cleanest imho. Self-documenting.
> > > I agree. That's the PVSCSI approach of compat_flags. Have many proper=
ties
> > > but each define bit in a compat_flags that specifies behavior.
> > > The disadvantage it have is that it over-complicates code and introdu=
ce many
> > > properties that will never be used as it's just for internal binding =
to
> > > machine-type.
> > > > But if not, I'd do something like "x-vmport-fixes" and
> > > > set bits there for each bugfix.
> > > Hmm this could a nice and simple approach.
> > > Will it be OK then in this case to define "x-vmport-fixes" value in
> > > hw_compat_4_2[] to a hard-coded value (e.g. "20") without directly en=
coding
> > > each individual bit via vmport.h constants?
> > Well how are you going to check a specific flag then?
> In the code itself I will have constants of course.
> I meant just in hw_compat_4_2[] machine-type compat entry because the
> bitmask value there should be specified as a string value.
> >=20
> > > I will note though that it seems this "x-vmport-fixes" bitmap seems t=
o be
> > > the first of it's kind. But I'm OK with this approach.
> So just to be clear before implementing your suggesting approach, this
> doesn't bother you right?

So it would be like this:

{
=09"x-vmport-fixes" : "0x7" /* VMPORT_FOO | VMPORT_BAR */
}

I prefer DEFINE_PROP_BIT myself. But this version is not too terrible I
think.

--=20
MST


