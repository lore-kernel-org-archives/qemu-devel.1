Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3B8C48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F68208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F68208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyfZ-0006Qs-Qd
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37207)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdyI8-0003om-LB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdyI7-0002bq-2e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdyI4-00024J-Uj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF3715D688;
 Thu, 20 Jun 2019 14:43:35 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7AF160928;
 Thu, 20 Jun 2019 14:43:30 +0000 (UTC)
Date: Thu, 20 Jun 2019 11:43:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190620144328.GA1862@habkost.net>
References: <20180205224205.GA3291@localhost.localdomain>
 <20180206154320.288acdc2@redhat.com>
 <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
 <20190617170106.48d776ca@redhat.com>
 <0a31228d-4d32-2c54-649b-6aef9953fffc@redhat.com>
 <20190617173343.68e3c9ec@redhat.com>
 <20190617162700.GC19178@habkost.net>
 <20190618133410.18b93bcd@redhat.com>
 <20190618135516.GH19178@habkost.net>
 <20190620110239.6c4c092d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190620110239.6c4c092d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 20 Jun 2019 14:43:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
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
Cc: marcel@redhat.com, peter.maydell@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 11:02:39AM +0200, Igor Mammedov wrote:
> On Tue, 18 Jun 2019 10:55:16 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Jun 18, 2019 at 01:34:10PM +0200, Igor Mammedov wrote:
> > > On Mon, 17 Jun 2019 13:27:00 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >  =20
> > > > On Mon, Jun 17, 2019 at 05:33:43PM +0200, Igor Mammedov wrote: =20
> > > > > On Mon, 17 Jun 2019 17:15:21 +0200
> > > > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:   =20
> > > > [...] =20
> > > > > > Yes. Eduardo and you should write some lines to explain this,=
 and then
> > > > > > we will follow :)   =20
> > > > > Unfortunately I don't recall details anymore. One could check o=
ut all
> > > > > implementations of class_by_name callbacks to find out current =
state.   =20
> > > >=20
> > > > See this message for a summary of existing class_by_name quirks:
> > > >=20
> > > >   https://www.mail-archive.com/qemu-devel@nongnu.org/msg615503.ht=
ml
> > > >   Date: Wed, 08 May 2019 10:34:44 +0200
> > > >   Message-ID: <877eb173a3.fsf@dusky.pond.sub.org>
> > > >   Subject: Re: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_by_=
name() functions
> > > >=20
> > > > I'm unsure about Igor's suggestion to get rid of CPU model names
> > > > and use only QOM type names in external interfaces.  In either
> > > > case, we can still simplify the rules rules and reduce the amount
> > > > of arch-specific code. =20
> > > as far as we have cpu_class_by_name, we have to watch over that
> > > new patches/targets won't add some custom handling/fallbac/whatnot.=
 =20
> >=20
> > We can get rid of CPUClass::cpu_class_by_name() without changing
> > the external interfaces provided by QEMU.
> if you mean QMP, than it is possible to keep model there where
> it already exists. Based on experiment [1](x86) I did, it's local to
> affected target and doesn't pollute other code.

I mean both command line and QMP.

>=20
> > I don't have a strong opinion about using only QOM types at -cpu,
> > yet.  But first we need to get rid of the arch-specific CPU model
> > name exceptions enumerated at the URL above (which would be very
> > welcome).
> One way to get rid of them is to deprecate them in favor of strict
> match (no fallback/substitutions/aliases) to typename and when we
> drop it make switch type based naming only.

This is true, but is it desirable?  Aren't we just moving
complexity elsewhere?  Management software would still need to
translate CPU models from existing VM configurations to QOM type
names.

>=20
> 1) I've just took a quick look at how much of duplicated/confusing
> code we could get rid off if we drop cpu_class_by_name/*_cpu_list.
> It amounts to >800LOC of trivial removal (not counting ppc/s390
> that depend on model naming heavily and in need of some non
> trivial refactoring)

Removing the code might be trivial.  Coordinating with the
maintainers of all architectures to confirm this is really
something everybody wants is the difficult part.

If you really want to do it, please make sure all the
architecture maintainers (and libvirt developers) are involved in
the discussion.

>=20
> >=20
> > >=20
> > > On contrary -device works just with type names for all devices,
> > > applying the same to -cpu which is basically translator
> > >    model->type[,-global type.foo,...]
> > > would be consistent with -device and less confusing for everyone
> > > (not counting significant code reduction).
> > > It would certainly simplify contributing new targets as contributor
> > > won't have to care about cpu model naming and do something about it=
.
> > >=20
> > > This option wasn't considered before because we didn't have depreca=
tion
> > > back then, but now it opens possibility to simplify qemu and consol=
idate
> > > naming. (we probably would be able to fold '-cpu help' into '-devic=
e help'
> > > as well).
> > >  =20
> >=20
>=20

--=20
Eduardo

