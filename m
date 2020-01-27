Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09BFC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE2C214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b50eVI41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE2C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzsY-0006PE-Lo
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ivzrl-0005wo-QA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ivzrk-0000ME-D5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:35:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ivzrk-0000Jd-9J
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580114127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxtEmNwkLR3DxAPqrUM8T7w/Fm8VY+Vs+GJm63sjt80=;
 b=b50eVI416+il++QIWUvsW/vwwb70xO5vL1D2KIhCH/WZM7v14wedbVIk4J1SACDSR5dszJ
 K0ezx7ZoXoRc5crjTd70EWAXd1FuTYu7T6DWDMOvUlasAe+OtGQ4pHP4OrEpnifGZ/tN/h
 oTnNJqvHDfRWZv306KY6+3tsUhmS+dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-E6tsTxcEOR-x8O8UeXmd8Q-1; Mon, 27 Jan 2020 03:35:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ECA6107ACC4;
 Mon, 27 Jan 2020 08:35:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-84.ams2.redhat.com
 [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD9C938C;
 Mon, 27 Jan 2020 08:35:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 05AAE1747D; Mon, 27 Jan 2020 09:35:14 +0100 (CET)
Date: Mon, 27 Jan 2020 09:35:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127083513.hgl5ydgpn4mkuho5@sirius.home.kraxel.org>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <f24ff946-2c37-d7c7-ff18-d67e22aa438e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f24ff946-2c37-d7c7-ff18-d67e22aa438e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: E6tsTxcEOR-x8O8UeXmd8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> We build a "configuration" struct in QAPI, and extend from there.
>=20
> (2) We offer "--config myconfig.yaml" as an option for specifying
> options.

Yes.

> This precludes the use of *any* traditional command line flags.

Hmm.  Given that the transition effort will probably take a while
I think it makes sense to allow mixing config file and cmd line
switches, if it is only for testing the config file parsing and
processing.  Maybe have a (temporary) -x-config for that?

We already have qapi schema for -blockdev + -display + -audiodev +
-chardev, creating a configuration struct which supports these
shouldn't be that much effort.  Then move over QemuOpts one by one.

The most tricky part here probably is -device support.

> (4) Just scrap the existing config file system entirely. It was never
> finished and does not help solve the existing problem that we do not
> have a schema for our configuration syntax.

Yep.  Zero reason to keep that once everything transitioned to qapi.

> - We WOULD need a new YAML parsing layer in QEMU, generated by QAPI.
> Supporting two deserialization layers could lead to strange
> discrepancies between the two formats at runtime. So, admittedly, using
> JSON would be *even easier*, as we could re-use the same parsers already
> battle-tested in QEMU. We could get *MAXIMUM* code re-use this way.

Well, we can support multiple formats, much like openshift accepts both
json and yaml.  json is pretty much there already, so we could start
with that and add yaml later on.  Possibly even the ini-style syntax
accepted by -readconfig today, although I'm not sure there is much
benefit in that.

> - We will break compatibility with our existing CLI. People will not be
> happy about this, especially, perhaps, embedded board and TCG developers
> who use fairly minimal command lines regularly.

Once config file support is complete enough we should be able to offload
backward compatibility command line parsing to some script which
transforms the cli into a config file.  Which is probably better than
trying to add -writeconfig to qemu as we don't have to do the string
processing in C then.

cheers,
  Gerd


