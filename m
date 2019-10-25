Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C220CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B54020679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0QamOnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B54020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0A1-0000cU-Fw
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNzyQ-0006g0-GA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNzyP-0001QS-2A
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:49:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNzyO-0001Q5-UG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blY7wZY0TDmik3qjGXHGv8cwWd9dhnSJfmtV7JAv3No=;
 b=f0QamOnU9MWdUnMKZLDaznJPCtDujVE/hLVUGNg8NT3slf8S/GTPnZWsG7qgfnFPyj27TJ
 eam8TH+ftyRMdJQB3SeUANPnWR/T/FWpYmBHBr1i2TP83Rndri2yP+WUk43omKX9HG11tc
 XlhQD8f3cbZ7NKErPaU/MXMDVt3i39A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-HeiCxOUMNW-4QFbKyxxsnw-1; Fri, 25 Oct 2019 09:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F181800DCA;
 Fri, 25 Oct 2019 13:49:42 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E408619C7F;
 Fri, 25 Oct 2019 13:49:35 +0000 (UTC)
Date: Fri, 25 Oct 2019 10:49:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
Message-ID: <20191025134934.GE6744@habkost.net>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
 <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HeiCxOUMNW-4QFbKyxxsnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, libvir-list@redhat.com,
 Cornelia Huck <cohuck@redhat.com>,
 Michal Skrivanek <michal.skrivanek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing mskrivanek, danpb, libvir-list.

On Fri, Oct 25, 2019 at 10:02:29AM +0200, David Hildenbrand wrote:
> On 25.10.19 09:55, Christian Borntraeger wrote:
> >=20
> >=20
> > On 25.10.19 09:17, David Hildenbrand wrote:
> > > On 25.10.19 04:25, Eduardo Habkost wrote:
> > > > We had introduced versioned CPU models in QEMU 4.1, including a
> > > > method for querying for CPU model versions using
> > >=20
> > > Interesting, I was not aware of that.
> > >=20
> > > On s390x, we somewhat have versioned CPU models, but we decided again=
st giving them explicit names (e.g., z13-v1 or z13-4.1.0), because it didn'=
t really seem to be necessary. (and we often implement/add features for old=
er CPU models, there is a lot of fluctuation) Actually, you would have had =
to add "z13-z/VM-x.x.x" or "z13-LPAR-x.x.x" or "z13-KVM-x.x.x" to model the=
 features you actually see in all the different virtual environments ("what=
 a CPU looks like"). Not to talk about QEMU versions in addition to that. S=
o we decided to always model what you would see under LPAR and are able to =
specify for a KVM guest. So you can use "z13" in an up-to-date LPAR environ=
ment, but not in a z/VM environment (you would have to disable features).
> > >=20
> > > Each (!base) CPU model has a specific feature set per machine. Libvir=
t uses query-cpu-model-expansion() to convert this model+machine to a machi=
ne-independent representation. That representation is sufficient for all us=
e cases we were aware of (esp. "virsh domcapabilities", the host CPU model,=
 migration).
> > >=20
> > > While s390x has versioned CPU models, we have no explicit way of spec=
ifying them for older machines, besides going over query-cpu-model-expansio=
n and using expanded "base model + features".
> > >=20
> > > I can see that this might make sense on x86-64, where you only have m=
aybe 3 versions of a CPU (e.g., the one Intel messed up first - Haswell, th=
e one Intel messed up next - Haswell-noTSX, and the one that Intel eventual=
ly did right - Haswell-noTSX-IBRS) and you might want to specify "Haswell" =
vs. "Haswell-IBRS" vs. "Haswell-noTSX-IBRS". But actually, you will always =
want to go for "Haswell-noTSX-IBRS", because you can expect to run in updat=
ed environments if I am not wrong, everything else are corner cases.
> > >=20
> > > Of course, versioned CPU model are neat to avoid "base model + list o=
f features", but at least for expanding the host model on s390x, it is not =
really helpful. When migrating, the model expansion does the trick.
> > >=20
> > > I haven't looked into details of "how to specify or model versions". =
Maybe IBM wants to look into creating versions for all the old models we ha=
d. But again, not sure if that is of any help for s390x. CCing IBM.
> >=20
> > I agree that this does not look very helpful.
> > Especially as several things depend on the kernel version a QEMU versio=
n is
> > not sufficient to be guarantee construction success.
> > So we would need something like z14-qemu4.0-kernel-5.2-suse-flavour-onL=
PAR
> >=20
> > Instead we do check if we can construct an equivalent model on the migr=
ation target.
> > And that model is precise. We do even have versions.
> > Right now with QEMU on s390  our models are versioned in a way that we =
fence of
> > facilities for old machine versions.
> >=20
> > For example
> > -machine s390-virtio-ccw-3.1 -cpu z14 will not have the multiple epoch =
facility
> > and
> > -machine s390-virtio-ccw-4.0 -cpu z14 will have the multiple epoch faci=
lity.
> > As migration does always require the tuple of machine and cpu this is s=
ave. I fail
> > to see what the benefit of an explicit z14-3.1 would be.
> >=20
>=20
> AFAIKS the only real benefit of versioned CPU models is that you can add =
new
> CPU model versions without new QEMU version.
>=20
> Then you can specify "-cpu z13-vX" or "-cpu z13 -cpuv X" (no idea how
> versioned CPU model were implemented) on any QEMU machine. Which is the s=
ame
> as telling your customer "please use z13,featX=3Don" in case you have a g=
ood
> reason to not use the host model (along with baselining) but use an expli=
cit
> model.

Exactly.  oVirt, specifically, don't use host-model.

>=20
> If you can change the default model of QEMU machines, you can automate th=
is
> process. I am pretty sure this is a corner case, though (e.g., IBRS).
> Usually you have a new QEMU machine and can simply enable the new feature
> from that point on.

When -noTSX happened, we thought it was a corner case.  Then we
had -IBRS & -IBPB.  Then we had SSBD (with no new CPU models).
Then we had MD_CLEAR (with no new CPU models).  It's now very
easy to get an insecure VM created if you are not using
host-model.

--=20
Eduardo


