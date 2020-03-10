Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DCC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33F222C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1CKXP5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmh3-0006fS-SZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmfp-0004Z8-1L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmfm-0005Fx-Cd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:44:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmfm-0005Co-46
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583876660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pW5Q4cdOWCajEaaNvS77JAvWxHmK38/oLjRoCGReAw=;
 b=L1CKXP5zL8SXzdZF8tt9nGBc8bN4LrDdcbnF9arVwV7Cn8yV0ubxjq5R2rv0gO3UAo5bTi
 of7pFSesBgMXO8Y7rcJ4hpd02ZHR1zMgGERwQTl7ITgybmhXliEG+jpwqMJ21N7e6e/R4E
 Jfr66Az3PsihOk1+Pvw9GXqac9PnSso=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-kZWCE3npPNG2KE898GxuLg-1; Tue, 10 Mar 2020 17:44:18 -0400
X-MC-Unique: kZWCE3npPNG2KE898GxuLg-1
Received: by mail-qv1-f72.google.com with SMTP id h17so31558qvc.18
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 14:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XOiCiAELTh27dIix4JLjy0/MbyuH+/LsOgb0H2TMTk4=;
 b=goKPZEG414JkKGrYIuedBq3hX28uY9GO/0cehUYTProZFU2tDgelOk9ursiE8lK+hO
 9PNwdAZs84xFt3tIOZ/ebirPPNozxRsTG4nV4aXpHgGGWUwGDBEtIFOIu0Ca77hXT/60
 Qgovom5h88yCNQ/mfTMxNIe97c2jGtteABRU09bQ2fkfjd3n1ddhpqiPinq23qvqf0gW
 gJnkbi5KksCIxhiUn7Nc6JO8j+FkoNaFAY/0g22L5jkVa6HdbcoEizxKSlHzrV2N8w5p
 +4hJHy7Z9MAl82B8mtU3jGKMq2TzRFZ9jF9RBinNXy3ZaQuAVzE1ZO44wp6nmYYNjp+u
 J65Q==
X-Gm-Message-State: ANhLgQ31RU/E6yOmA+821P+QF25bClhqdgAiOPTC9VdvxKqYjxy2a3Wa
 fUJsaoicA07wiZdbWkS+G0786khATCN5I6nrFIWFbfY1d0+4fOO7xma8Vnxqhzz3lHtMhz7hLfM
 9u1+4Xz9PzVU6lNI=
X-Received: by 2002:a05:620a:22b:: with SMTP id
 u11mr21403283qkm.225.1583876657907; 
 Tue, 10 Mar 2020 14:44:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vslOEu8u2iVOg6ZaujoLXi1MJaweFmncDMucoDm1pRUyR+Ydtb2IqCEpK/vQmNjaQYcIVBiRA==
X-Received: by 2002:a05:620a:22b:: with SMTP id
 u11mr21403254qkm.225.1583876657529; 
 Tue, 10 Mar 2020 14:44:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 11sm25209866qkr.101.2020.03.10.14.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:44:16 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:44:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <20200310173020-mutt-send-email-mst@kernel.org>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
 <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
 <20200310164239-mutt-send-email-mst@kernel.org>
 <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b191ba0e-a864-fdc2-a029-c22783eb0106@oracle.com>
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

On Tue, Mar 10, 2020 at 02:29:42PM -0700, Liran Alon wrote:
>=20
> On 10/03/2020 22:56, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 08:09:09PM +0200, Liran Alon wrote:
> > > On 10/03/2020 19:44, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
> > > > > Hi,
> > > > >=20
> > > > > This series aims to fix several bugs in VMPort and improve it by =
supporting
> > > > > more VMPort commands and make command results more configurable t=
o
> > > > > user via QEMU command-line.
> > > > >=20
> > > > > This functionality was proven to be useful to run various VMware =
VMs
> > > > > when attempting to run them as-is on top of QEMU/KVM.
> > > > >=20
> > > > > For more details, see commit messages.
> > > > Well two versions in one day and some review comments weren't addre=
ssed.
> > > There is a single review comment that wasn't addressed which is repla=
cing an
> > > enum with a comment. And I explicitly mentioned that it's because I w=
ant
> > > additional opinion on this.
> > > I don't see why such a small thing should block review for 15 patches=
...
> > > All the rest of the comments (Which were great) have been addressed. =
Unless
> > > I have mistakenly missed something, which please point it out if I di=
d.
> > OK I just took a quick peek, two things quickly jumped out at me.
> Thanks for having a look.
> >=20
> > version property really should be a boolean and have some documentation
> > saying what functionality enables.
> I thought that having a version number approach is more generic and easy =
to
> maintain going forward.
> If I understand correctly, this is also the approach taken by qxl & qxl-v=
ga.
>=20
> The more elaborate alternative could have been introducing compat_flags (=
As
> PVSCSI does) but it seems like it will pollute the property space with a =
lot
> of useless VMPort properties.
> (E.g. x-read-eax-bug, x-no-report-unsupported-cmd, x-no-report-vmx-type a=
nd
> etc.).
>=20
> What is the advantage of having a boolean such as "x-vmport-v2" instead o=
f
> having a single "version" property?

It's not clear what should happen going forward. Let's say version is
incremented again. This then becomes challenging for downstreams to
backport.

> Will it suffice if I would just add documentation above "version" propert=
y
> on what is was the functionality in "version=3D=3D1"?
> (Though, it's just easy to scan the vmport.c code for if's involving
> ">version"... "version" is more of an internal field for machine-type
> compatibility and not really meant to be used by user)
>=20
> Which approach do you prefer?

I just dislike versions, they are hard to maintain.

Individual ones is cleanest imho. Self-documenting.
But if not, I'd do something like "x-vmport-fixes" and
set bits there for each bugfix.


> > userspace properties should use the non-abbreviated
> > vm-executable since vmx is easy to confuse with vm extensions.
> I really wish you would reconsider this. VMX is a really common term in
> VMware terminology.
> It is found in binary names, ".vmx" file, ".vmx" file properties, VMware
> Tools prints, open-vm-tools source code and etc.

Well that at least is easy to google.

=09.vmx

=09<vmname>.vmx

=09This is the primary configuration file, which stores settings
=09chosen in the New Virtual Machine Wizard or virtual machine settings
=09editor. If you created the virtual machine under an earlier version of
=09VMware Workstation on a Linux host, this file may have a .cfg extension

so .vmx as used here has nothing to do with VM Executable version or
type. Looks like it's just a source of confusion on the vmware
side too :)



>=20
> In contrast, even though I have dealt for many years with VMware
> technologies, I have never known that VMX=3D=3Dvm-executable.

Well you said that's what it stands for. I have no idea.  From what you
say now maybe vmx basically is being used as a prefix for all things
vmware. In that case vmport-version and vmport-type or even
vmware-version and vmware-type will do just as well.


> I still think it will introduce much confusion. On the other hard, I don'=
t
> see much confusing with this use of VMX with Intel VT-x
> because it is only used inside vmport.c and in vmport properties names. A=
nd
> the properties names match the names of the guest
> code that interface with vmport in open-vm-tools source code.
>=20
> If you still have a strong opinion on this, I will change it as you say i=
n
> v3... But please consider above arguments.

I'm just saying don't use vmx. It's too late to try to give
it a different meaning. Figure out what it's supposed to
stand for and write it out in full.

> >=20
> > That's just a quick look.
> >=20
> >=20
> > > > Some people do this, try to wear the maintainers out by sheer volum=
e.
> > > > It works sometimes but it's not a nice tactic. I personally think i=
t's
> > > > worth taking the time to think harder about ways to address all
> > > > comments, not try to dismiss them.
> > > That's not what I tried to do. I carefully fixed all comments I saw i=
n the
> > > review discussion and run tests.
> > > The only thing which wasn't addressed is removing an enum and replaci=
ng it
> > > with a comment.
> > > The hint that I try to manipulate maintainers is disrespectful. I ass=
ume
> > > that this isn't your intention, as we all just want to collaborate to=
gether
> > > here. No need to make this a personal discussion.
> > >=20
> > > If you think that replacing the enum with a comment is a blocker for =
v2
> > > patch-series, I will go ahead and submit v3 with that change.
> > Yes IMHO it needs to be fixed but please go over the comments and try t=
o
> > address them all as best you can, instead of looking for an explanation
> > why the comments were irrelevant and can be dismissed.
>=20
> I'm not trying to finding explanation on why the comments are irrelevant =
and
> can be dismissed... It's not my first time contributing code to QEMU/KVM.=
..
>=20
> > Sure someone
> > might propose you introduce a bug, and that can't just be addressed, bu=
t
> > that's not the case here.  Also please do not send multiple revisions o=
f
> > a large patchset in a day.  People need time for review.
> OK. I will make note of that for next time.
> I would have thought maintainers prefer to always have ability to pick up
> the latest version that is ready to avoid reviewing old code that was
> already discussed. Assuming all previous comments were addressed.
>=20
> Thanks,
> -Liran
>=20


