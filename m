Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99256C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C70C206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE/VyA4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C70C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDaT-0005lK-K8
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYDZg-0004yC-0B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:54:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYDZf-0003Vr-1i
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589223285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBN51VE7in+n7nu6wVIdo9bSemXdDPrQ/OE6WH6ytK8=;
 b=XE/VyA4Monh1IdcvQFFxDHLc57rMf4uV+aQj9FB5jlzNSjU0UXePM9aQRwxmX0vJgH0n+B
 UqDLous6Xvzq+lAHPL0/naVr82hsvLxQ48lQ15dmpmvXs9xSuhalQxYppWdG0HaN7HWQpA
 BWMgoTe75szUxF/L6qOvlP8tmS1qaLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-JaQaii22OeqJ10yqBHDAGg-1; Mon, 11 May 2020 14:54:44 -0400
X-MC-Unique: JaQaii22OeqJ10yqBHDAGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC000BFC5;
 Mon, 11 May 2020 18:54:42 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30A0D5C1B5;
 Mon, 11 May 2020 18:54:34 +0000 (UTC)
Date: Mon, 11 May 2020 20:54:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200511205432.1af56b7e@redhat.com>
In-Reply-To: <B4E56027-03A4-48DA-ACE1-73B2811528E5@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
 <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
 <20200424184448.GS4952@habkost.net>
 <20200429173254.58c8582f@redhat.com>
 <B4E56027-03A4-48DA-ACE1-73B2811528E5@nutanix.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 May 2020 17:42:16 +0000
Ani Sinha <ani.sinha@nutanix.com> wrote:

> > On Apr 29, 2020, at 9:02 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> >=20
> > On Fri, 24 Apr 2020 14:44:48 -0400
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >  =20
> >> On Fri, Apr 24, 2020 at 03:23:56PM +0000, Ani Sinha wrote: =20
> >>>=20
> >>>  =20
> >>>> On Apr 22, 2020, at 4:15 PM, Ani Sinha <ani.sinha@nutanix.com> wrote=
:
> >>>>=20
> >>>>=20
> >>>>  =20
> >>>>> On Apr 21, 2020, at 8:32 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> >>>>>=20
> >>>>> On Tue, Apr 21, 2020 at 02:45:04PM +0000, Ani Sinha wrote:   =20
> >>>>>>=20
> >>>>>>  =20
> >>>>>>> On Apr 20, 2020, at 8:32 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> >>>>>>>=20
> >>>>>>> But I for one would like to focus on keeping PIIX stable
> >>>>>>> and focus development on q35.  Not bloating PIIX with lots of new
> >>>>>>> features is IMHO a good way to do that.   =20
> >>>>>>=20
> >>>>>> Does this mean this patch is a no-go then? :(   =20
> >>>>>=20
> >>>>> I'd support this patch, as I don't think it can really be described=
 as
> >>>>> bloat or destabalizing. It is just adding a simple property to
> >>>>> conditionalize existing functionality.  Telling people to switch to=
 Q35
> >>>>> is unreasonable as it is not a simple 1-1 conversion from existing =
use
> >>>>> of PIIX. Q35 has much higher complexity in its configuration, has h=
igher
> >>>>> memory overhead per VM too, and lacks certain features of PIIX too.=
   =20
> >>>>=20
> >>>> Cool. How do we go forward from here?
> >>>>  =20
> >>>=20
> >>> We would really appreciate if we can add this extra knob in
> >>> Qemu. Maybe someone else also in the community will find this
> >>> useful. We don=E2=80=99t want to maintain this patch internally forev=
er
> >>> but rather prefer we maintain this as a Qemu community.   =20
> >>=20
> >> Michael, I agree with Daniel here and I don't think we should
> >> start refusing PIIX features if they are useful for a portion of
> >> the QEMU community.
> >>=20
> >> Would you reconsider and merge this patch? =20
> >=20
> > I put this patch on my review queue (hopefully next week I'd be able to=
 get to it) =20
>=20
> Any progress?
>=20

see my reply on v2


