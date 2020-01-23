Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE69B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpjLuiF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE69B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iujA3-0005g9-W3
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuhjz-0004or-C5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuhjw-0003zF-V4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:02:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuhjw-0003yN-Qn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579806124;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gqOrEcq9njh+eHq7yVHSPVkftfuEuw7ErAH94+T8Nw=;
 b=YpjLuiF/eOUGZ7zqgn0hCuuxuxQwPjB/6fGSKvihQDf1CA30sFYGPSFnGghUQhyxgvZ4Z7
 fZR5+r7GNvIZK+/D1LltSQF3+wwVH2gKK0lK/lmy1JmuJkSScBaTYUxVU1Pgo/F30TWmK1
 K8eTQQaLiP9BVBEPYtWC5CquWgXiAlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-T1-tzPGHOZGIdtDyYGSziA-1; Thu, 23 Jan 2020 14:02:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1D0800D4E;
 Thu, 23 Jan 2020 19:02:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53C8B5C1BB;
 Thu, 23 Jan 2020 19:01:48 +0000 (UTC)
Date: Thu, 23 Jan 2020 19:01:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200123190145.GI657556@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: T1-tzPGHOZGIdtDyYGSziA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:58:45PM -0500, John Snow wrote:
> Yes, I agree: Scrap and start over.
>=20
> What SHOULD the syntax look like, though? Clearly the idea of qmp-shell
> is that it offers a convenient way to enter the top-level keys of the
> arguments dict. This works absolutely fine right up until you need to
> start providing nested definitions.
>=20
> For the nesting, we say: "Go ahead and use JSON, but you have to take
> all the spaces out."
>=20
> This... works, charitably, but is hardly what I would call usable.
>=20
> For the CLI, we offer a dot syntax notation that resembles nothing in
> particular. It often seems the case that it isn't expressive enough to
> map losslessly to JSON. I suspect it doesn't handle siblings very well.
>=20
> A proper HMP-esque TUI would likely have need of coming up with its own
> pet syntax for commands that avoid complicated nested JSON definitions,
> but for effort:value ratio, having a QMP shorthand shell that works
> arbitrarily with any command might be a better win.
>=20
> Do we still have a general-case problem of how to represent QAPI
> structures in plaintext? Will this need to be solved for the CLI, too?

I don't know if you've ever looked at how Kubernetes/OpenShift exposes
its functionality on the command line ? I think it is interesting to
note that they largely don't try to solve this problem of flattening
JSON for humans on the CLI using their client.

Everything in their world is an object described in JSON/YAML, and
there are a small set of generic commands that can act on any type
of object. These commands primarily input and output JSON or YAML
documents directly. As a user you can pick either format since it
can do a lossless conversion in both directions server side.

So when configuring objects you'll always provide a JSON/YAML doc.
They've got some clever stuff for updating objects where you can
provide a JSON patch for only the bits which need changing.

When querying/listing objects by default it displays only a small
subset of their config information in a human friendly-ish format.
If you want to see everything then you ask for it in JSON/YAML
format. There's also an expression language that lets you extract
particular pieces of information based on requested properties,
and you can filter the list of objects based on attributes and so
on.

I think it is fair to say the structure of kubernetes object config
is on a par with hierarchical complexity of QEMU. The lack of a simple
human targetted data input format does not appear to have negatively
impacted the adoption of Kubernetes. It is worth questioning why this
is the case, while we feel the human CLI syntax for QEMU is so
critically important to QEMU's future ?



Part of it is that the machine oriented data input format via QMP
suffers from the fact that it came second in QEMU after HMP. As a
result, 90% of the documentation that illustrates QEMU will use the
human CLI syntax, varying vintages of that. Since all the docs are
focused on the HMP/CLI syntax, whenever there's a new feature we
feel pressured to expose it & document it in the human syntax too.

All this results in a situation where JSON is functionally the best
way to configure QEMU, but practically the worse, since very few
people understand how to actually use it. This is a vicious circle
holding back QMP/JSON and making the human syntax an ever greater
burden for users & maintainers


IOW, the difficulty with configuring QEMU via JSON is not the fault
of JSON itself, it is the lack of knowledge amongst users and docs,
compounded by our never ending "improvements" to the human syntax.
There are other factors too, such as our only partial coverage of
config using JSON - some is only possible via the CLI still.


I guess my point is that with a scrap & startover view point, we
should arguably completely ignore the design question of how to
flatten JSON for humans/command line, as it is the wrong problem.
Instead focus on the problem of making use of JSON the best way
to deal with QEMU both functionally and practically, for humans
and machines alike.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


