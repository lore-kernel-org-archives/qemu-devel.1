Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04A7C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8552166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bREFtOP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8552166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuT4-0003gb-SI
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iyuSA-0003AP-69
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iyuS8-0002IJ-On
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iyuS7-00028M-K0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580808302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4DtaN164akoN1Uf1ADsrUmp5p+IPW6HV8SS2r10XXo=;
 b=bREFtOP+owGaVSJkPyBnkaRpLJroSiQDHgiMnNQqg43+xVItRAAWSjCVt8zmN8PrLSOg6Q
 pifTdTDDcYHCNfb3Uv712S6sq7Vwij209G5E9nv4GAJB6zliO9NdsfSBlMRA+b4UHtLCYn
 ojhaCC+hsPFoeQjPbbFMzYjq1IauWdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-n_7Wz8qQOmydE0bZ6SuDiQ-1; Tue, 04 Feb 2020 04:24:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7968EDBF5;
 Tue,  4 Feb 2020 09:24:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 441FDF6C1;
 Tue,  4 Feb 2020 09:24:52 +0000 (UTC)
Date: Tue, 4 Feb 2020 09:24:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Does Libvirt's json parser support single quoted string in qmp
 json string?
Message-ID: <20200204092450.GB2205287@redhat.com>
References: <ADDDD4B8-45AD-4D79-9332-06F2A50B26CE@sina.com>
 <9bac386b-5a90-3c10-b63b-d45a2e8c2d58@redhat.com>
 <20200203101352.GB1922177@redhat.com>
 <1f285f58-7a8f-0656-4f0a-8acfe56bad43@redhat.com>
 <87eevabwls.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87eevabwls.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: n_7Wz8qQOmydE0bZ6SuDiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvirt-users@redhat.com, Peter Luo <d8514@sina.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 09:11:27AM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > [adding Markus]
> >
> > On 2/3/20 4:13 AM, Daniel P. Berrang=C3=A9 wrote:
> >> On Fri, Jan 31, 2020 at 06:44:42AM -0600, Eric Blake wrote:
> >>> On 1/31/20 4:38 AM, Peter Luo wrote:
> >>>
> >>>> error: internal error: cannot parse json {"execute": "block-commit",=
 "arguments": { "device": "drive-virtio-disk2", "job-id": "job100", "base":=
'json:{"encrypt.key-secret":"vol-38973xjl.secret","driver":"qcow2","file":{=
"driver":"file","filename":"/pitrix/data/container/vol-38973xjl.img"}}', "t=
op": "/pitrix/data/container/vol-38973xjl_ss-2tw7v0mm.img"}}: lexical error=
: invalid char in json text.
> >>>>
> >>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , "job-id":=
 "job100", "base":'json:{"encrypt.key-secret":"vo
> >>>>
> >>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (right here) ------^
> >>>>
> >>>
> >>> qemu's QMP language has an extension where it accepts 'string' in add=
ition
> >>> to the JSON "string".  But it uses a hand-rolled parser, so it can do
> >>> whatever it wants.
> >>
> >> Can we deprecate & remove this extension in QEMU ?
>=20
> I think deprecating the extension makes sense only if we can actually
> kill it.
>=20
> We could try to make the extension opt-in, and have only the intermal
> users opt in.  Can't say offhand whether that's practical.
>=20
> > We could start a deprecation clock, if desired, but I don't know how
> > many external users would be impacted (at least qemu's testsuite
> > heavily relies on the extension of single quotes).
>=20
> Looks like this:
>=20
>     rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s=
 } }",
>                                   QapiErrorClass_str(error_get_class(err)=
),
>                                   error_get_pretty(err));
>=20
> Without the extension, we'd suffer from a mild case of leaning toothpick
> syndrome:
>=20
>     rsp =3D qdict_from_jsonf_nofail("{ \"error\": { \"class\": %s, \"desc=
\": %s } }",
>                                   QapiErrorClass_str(error_get_class(err)=
),
>                                   error_get_pretty(err));
>=20
> I intentionally picked an example outside tests/ :)

This is purely QEMU internal code. That is fine to use whatever
extensions are desired, as it isn't exposed to end users or mgmt
apps.=20

The harm from JSON extensions comes in places where our public API
accepts it - CLI, QMP, JSON inside disk images, etc, as those are
all places where interoperability with third party apps is relevant


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


