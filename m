Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E9C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45993217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsW2PUYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45993217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWpb-0003DG-UG
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuWnt-0001U5-RH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuWns-0002bN-Pp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:21:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuWns-0002X8-LC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579764082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRnk/JMDoFNJJxFT6WfDVqoBKDMVmbMiPOrEYR7hQUs=;
 b=XsW2PUYEYBSVWHIjN9T6wA2wamPEP/RwCgTKsYo7MdlS/K70Oj3+mIn644XdVa+NCN4jOY
 A9GAZbxJbTi/BDhs4Ty86lHixq0y4We427qGu+Nk/wDB1NkD9II0b5y2kymJBZMTF82JBn
 c9YahFiatPgLwpZ2UJdfpgUiz9wwfXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-AyZOdMkjMDexj29qk4tlsg-1; Thu, 23 Jan 2020 02:21:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA87F1800D48;
 Thu, 23 Jan 2020 07:21:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC7A210016EB;
 Thu, 23 Jan 2020 07:21:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 421B31138600; Thu, 23 Jan 2020 08:21:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <20191224130035.GC2710539@redhat.com>
 <a95b7572-d863-bc88-66aa-3beed679cefe@redhat.com>
Date: Thu, 23 Jan 2020 08:21:13 +0100
In-Reply-To: <a95b7572-d863-bc88-66aa-3beed679cefe@redhat.com> (John Snow's
 message of "Wed, 22 Jan 2020 17:42:10 -0500")
Message-ID: <874kwmeiza.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AyZOdMkjMDexj29qk4tlsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 12/24/19 8:00 AM, Daniel P. Berrang=C3=A9 wrote:
>> Based on experiance in libvirt, this is an even larger job than (4),
>> as the feature set here is huge.  Much of it directly ties into the
>> config problem, as to deal with SELinux / namespace setup the code
>> needs to understand what resources to provide access to. This
>> requires a way to express 100% coverage of all QEMU configuration
>> in use & analyse it to determine what resources it implies. So this
>> ties strongly into QAPI-ification completion.
>
> Is it totally bonkers to suggest that QEMU provide a method of digesting
> a given configuration and returning a configuration object that a
> standalone jailer can use?
>
> So we have a QEMU manager, the generic jailer, and QEMU. QEMU and the
> manager cooperate to produce the jailing configuration, and the jailer
> does what we ask it to.
>
> Nuts?

With the nuts-o-meter calibrated for QEMU CLI: nope, this hardly moves
the needle.


