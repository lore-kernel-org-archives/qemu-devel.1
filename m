Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39136FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BF82178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvRrGw5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BF82178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSzld-00016n-0C
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSzkj-0000bK-3U
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSzkf-00066D-Uu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:36:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34415
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSzkf-00064z-QQ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573202177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QkRo7iAAomqNN9JBrDU1HvmrD/98RdJ80/l2278qGLQ=;
 b=gvRrGw5sEsVBL//tpQdECtSpxT4bsxPRLRhS6leUhSHbH9JwFdRx5mi+nVcEHjS4d8rloj
 jWjCv4kCiIE13D9sLzrFIGkqBMfvnFRixbV0zpSBwqPSKbRO/cpuZcPrU7jQnDiFTlhuUs
 2wx58oDAytVorWTuUwPiD4toQs8jX3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-kaHpo0-cMW6PFZLnwG8JmQ-1; Fri, 08 Nov 2019 03:36:13 -0500
X-MC-Unique: kaHpo0-cMW6PFZLnwG8JmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BF21005500;
 Fri,  8 Nov 2019 08:36:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B64AF5DA7C;
 Fri,  8 Nov 2019 08:35:43 +0000 (UTC)
Subject: Re: [Qemu-devel] Exposing feature deprecation to machine clients
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
 <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
 <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
 <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <40756c69-71b2-f52f-24f0-d9ebd0b69b24@redhat.com>
Date: Fri, 8 Nov 2019 09:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AWHrVZYRo3NsAuGp91BG90EZQCc2MoqIN"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AWHrVZYRo3NsAuGp91BG90EZQCc2MoqIN
Content-Type: multipart/mixed; boundary="EiFUJOdlICUpyH6oYF0D9VBSEAjUDdlbY"

--EiFUJOdlICUpyH6oYF0D9VBSEAjUDdlbY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 20:13, Vladimir Sementsov-Ogievskiy wrote:
> 07.11.2019 21:52, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Markus,
>>
>> On 8/15/19 7:40 PM, John Snow wrote:
>>> On 8/15/19 10:16 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>> [...]
>>>>> I asked Markus this not too long ago; do we want to amend the QAPI
>>>>> schema specification to allow commands to return with "Warning" strin=
gs,
>>>>> or "Deprecated" stings to allow in-band deprecation notices for cases
>>>>> like these?
>>>>>
>>>>> example:
>>>>>
>>>>> { "return": {},
>>>>> =C2=A0=C2=A0 "deprecated": True,
>>>>> =C2=A0=C2=A0 "warning": "Omitting filter-node-name parameter is depre=
cated, it will
>>>>> be required in the future"
>>>>> }
>>>>>
>>>>> There's no "error" key, so this should be recognized as success by
>>>>> compatible clients, but they'll definitely see the extra information.
>>>>
>>>> This is a compatible evolution of the QMP protocol.
>>>>
>>>>> Part of my motivation is to facilitate a more aggressive deprecation =
of
>>>>> legacy features by ensuring that we are able to rigorously notify use=
rs
>>>>> through any means that they need to adjust their scripts.
>>>>
>>>> Yes, we should help libvirt etc. with detecting use of deprecated
>>>> features.=C2=A0 We discussed this at the KVM Forum 2018 BoF on depreca=
ting
>>>> stuff.=C2=A0 Minutes:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.or=
g>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 https://lists.nongnu.org/archive/html/qemu-de=
vel/2018-10/msg05828.html
>>>>
>>>> Last item is relevant here.
>>>>
>>>> Adding deprecation information to QMP's success response belongs to "W=
e
>>>> can also pass the buck to the next layer up", next to "emit a QMP
>>>> event".
>>>>
>>>> Let's compare the two, i.e. "deprecation info in success response"
>>>> vs. "deprecation event".
>>>>
>>>> 1. Possible triggers
>>>>
>>>> Anything we put in the success response should only ever apply to the
>>>> (successful) command.=C2=A0 So this one's limited to QMP commands.
>>>>
>>>> A QMP event is not limited to QMP commands.=C2=A0 For instance, it cou=
ld be
>>>> emitted for deprecated CLI features (long after the fact, in addition =
to
>>>> human-readable warnings on stderr), or when we detect use of a
>>>> deprecated feature only after we sent the success response, say in a
>>>> job.=C2=A0 Neither use case is particularly convincing.=C2=A0 Reportin=
g use of
>>>> deprecated CLI in QMP feels like a work-around for the CLI's
>>>> machine-unfriendliness.=C2=A0 Job-like commands should really check th=
eir
>>>> arguments upfront.
>>>>
>>>> 2. Connection to trigger
>>>>
>>>> Connecting responses to commands is the QMP protocol's responsibility.
>>>> Transmitting deprecation information in the response trivially ties it
>>>> to the offending command.
>>>>
>>>> The QMP protocol doesn't tie events to anything.=C2=A0 Thus, a depreca=
tion
>>>> event needs an event-specific tie to its trigger.
>>>>
>>>> The obvious way to tie it to a command mirrors how the QMP protocol ti=
es
>>>> responses to commands: by command ID.=C2=A0 The event either has to be=
 sent
>>>> just to the offending monitor (currently, all events are broadcast to
>>>> all monitors), or include a suitable monitor ID.
>>>>
>>>> For non-command triggers, we'd have to invent some other tie.
>>>>
>>>> 3. Interface complexity
>>>>
>>>> Tying the event to some arbitrary trigger adds complexity.
>>>>
>>>> Do we need non-command triggers, and badly enough to justify the
>>>> additional complexity?
>>>>
>>>> 4. Implementation complexity
>>>>
>>>> Emitting an event could be as simple as
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_deprecated(qmp_command_id(),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Omitting 'filter-node-name'");
>>>>
>>>> where qmp_command_id() returns the ID of the currently executing
>>>> command.=C2=A0 Making qmp_command_id() work is up to the QMP core.=C2=
=A0 Simple
>>>> enough as long as each QMP command runs to completion before its monit=
or
>>>> starts the next one.
>>>>
>>>> The event is "fire and forget".=C2=A0 There is no warning object propa=
gated
>>>> up the call chain into the QMP core like errors objects are.
>>>>
>>>> "Fire and forget" is ideal for letting arbitrary code decide "this is
>>>> deprecated".
>>>>
>>>> Note the QAPI schema remains untouched.
>>>>
>>>> Unlike an event, which can be emitted anywhere, the success response
>>>> gets built in the QMP core.=C2=A0 To have the core add deprecation inf=
o to
>>>> it, we need to get the info to the core.
>>>>
>>>> If deprecation info originates in command code, like errors do, we nee=
d
>>>> to propagate it up the call chain into the QMP core like errors.
>>>>
>>>> Propagating errors is painful.=C2=A0 It has caused massive churn all o=
ver the
>>>> place.
>>>>
>>>> I don't think we can hitch deprecation info to the existing error
>>>> propagation, since we need to take the success path back to the QMP
>>>> core, not an error path.
>>>>
>>>> Propagating a second object for warnings... thanks, but no thanks.
>>>>
>>>
>>> Probably the best argument against it. Fire-and-forget avoids the
>>> problem. Events might work just fine, but the "tie" bit seems like a ya=
k
>>> in need of a shave.
>>>
>>>> The QMP core could provide a function for recording deprecation info f=
or
>>>> the currently executing QMP command.=C2=A0 This is how we used to reco=
rd
>>>> errors in QMP commands, until Anthony rammed through what we have now.
>>>> The commit messages (e.g. d5ec4f27c38) provide no justification.=C2=A0=
 I
>>>> dimly recall adamant (oral?) claims that recording errors in the Monit=
or
>>>> object cannot work for us.
>>>>
>>>> I smell a swamp.
>>>>
>>>> Can we avoid plumbing deprecation info from command code to QMP core?
>>>> Only if the QMP core itself can recognize deprecated interfaces.=C2=A0=
 I
>>>> believe it can for the cases we can expose in introspecion.=C2=A0 Let =
me
>>>> explain.
>>>>
>>>> Kevin recently added "features" to the QAPI schema language.=C2=A0 The
>>>> implementation is incomplete, but that's detail.=C2=A0 The idea is to =
tack a
>>>> "deprecated" feature to deprecated stuff in the QAPI schema.
>>>>
>>>
>>> That's a good idea too; but the semantics of exactly *what* was
>>> deprecated may be hard to capture.
>>>
>>>> Commands and arguments need to support features for that.
>>>> Implementation should be relatively straightforward.
>>>>
>>>> Deprecating an argument's optionalness may require a
>>>> "optional-deprecated" feature.=C2=A0 I've seen more elegant designs, b=
ut I've
>>>> also seen plenty of uglier ones.
>>>>
>>>> Note that features are tied to schema syntax.=C2=A0 To express semanti=
cally
>>>> conditional deprecation like "if you specify argument FOO, then not
>>>> specifying argument BAR is deprecated", we'd have to add a language fo=
r
>>>> these conditions.=C2=A0 Uh, not now, maybe never.
>>>>
>>>> The primary use of having deprecation defined in the QAPI schema is
>>>> introspection.=C2=A0 The BoF minutes mention this, too.
>>>>
>>>> A secondary use could be detecting use of deprecated features right in
>>>> the QMP core.=C2=A0 No need for ad hoc code in commands, no need for p=
lumbing
>>>> information from there to the QMP core.
>>>>
>>>> I'd like to pursue this idea, then see how well it suits our deprecati=
on
>>>> needs.
>>>>
>>>
>>> I should clearly remember to talk to you before thinking about QMP in
>>> public, because you've thought about it much more.
>>
>> Pre-release period, time to deprecate some stuffs :)
>>
>> How should we proceed? Do you have something in mind?
>>
>> There are older threads about this. Should we start a new thread? Gather=
 the different ideas on the Wiki?
>>
>> (Obviously you are not the one responsible of this topic, you just happe=
n to be the last one worried about it on the list).
>>
>> Regards,
>>
>> Phil.
>=20
> Hi!
>=20
> I wanted to resend, but faced some problems, and understand that I can't =
do it in time before soft-freeze..
> But you say, that we can deprecate something even after hard-freeze?
>=20
> Ok, the problem that I faced, is that deprecation warnings breaks some io=
tests.. What can we do?
>=20
> 1. Update iotests...
>    1.1 Just update iotests outputs to show warnings. Then, in next releas=
e cycle, update iotests, to not use deprecated things
>    or
>    1.2 Update iotests to not use deprecated things.. Not appropriate for =
hard freeze.

I personally don=E2=80=99t have a problem with any test patches during free=
ze,
but maybe I should be more careful with auto-grouped patches.

> or
> 2. Commit deprecations without warnings.. But how do people find out abou=
t this?
>=20
> Next, what exactly to deprecate? As I understand, we can't deprecate driv=
e-mirror now?
> So I propose to:
>=20
> 1. deprecate drive-backup

I suspect I missed something at KVM Forum, but what=E2=80=99s the hurry her=
e?

Max

> 2. add optional filter-node-name parameter to drive-mirror, to correspond=
 to commit and mirror
> 3. deprecate that filter-node-name is optional for commit and mirror.
>=20



--EiFUJOdlICUpyH6oYF0D9VBSEAjUDdlbY--

--AWHrVZYRo3NsAuGp91BG90EZQCc2MoqIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FKN0ACgkQ9AfbAGHV
z0BXqwgArhdnpdy8/zFpIPntZdSbZcWHohBf4ISZyVnWvp3DtCILW25GolCIv+n4
yT/S/Qfh5PTpJMNeEPKQhDM02a2L9OiXYkp3O/MRjXTWuwEH9TwL5YsUQFkqx5Js
dUk35xq9DRWepY6+qox7KmwtbXp9kDKeRMHzTBSpCdhylezvwd1TsyysqH2sNpCQ
hWdXAeQ0ErvetA4iST6wFRLzr7ntWqBRj9udjb/q1VxgbFCCKf7J83h1ReFTdZDn
4cVS4OGoG3f5tTcHg2FYk1h5qclgBw+klpv5lF9kofZPGMcWaBxFnsEhxJVwYR90
4nk4PMAnEgaB5yJvCOw0Tc6jIxKlQw==
=36pW
-----END PGP SIGNATURE-----

--AWHrVZYRo3NsAuGp91BG90EZQCc2MoqIN--


