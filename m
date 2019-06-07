Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C9C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D5C2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D5C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZA4w-0001JO-Jk
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hZA1P-0008Qc-0W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hZ9th-0003sv-Rq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hZ9tg-0003iH-HE; Fri, 07 Jun 2019 04:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E04722386E;
 Fri,  7 Jun 2019 08:06:40 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B840080F97;
 Fri,  7 Jun 2019 08:06:36 +0000 (UTC)
Date: Fri, 7 Jun 2019 10:06:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190607080635.GB5055@dhcp-200-226.str.redhat.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 08:06:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.06.2019 um 05:17 hat Eric Blake geschrieben:
> On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> > +static coroutine_fn void nbd_reconnect_loop(NBDConnection *con)
> > +{
> > +    NBDClientSession *s =3D nbd_get_client_session(con->bs);
> > +    uint64_t start_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> > +    uint64_t delay_ns =3D s->reconnect_delay * 1000000000UL;
>=20
> Do we have a #define constant for nanoseconds in a second to make this
> more legible than counting '0's?
>=20
> > +    uint64_t timeout =3D 1000000000UL; /* 1 sec */
> > +    uint64_t max_timeout =3D 16000000000UL; /* 16 sec */
>=20
> 1 * constant, 16 * constant
>=20
> > +
> > +    nbd_reconnect_attempt(con);
> > +
> > +    while (nbd_client_connecting(s)) {
> > +        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
> > +            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > d=
elay_ns)
> > +        {
> > +            s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
> > +            qemu_co_queue_restart_all(&s->free_sema);
> > +        }
> > +
> > +        bdrv_dec_in_flight(con->bs);
> > +        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);
>=20
> Another place where I'd like someone more familiar with coroutines to
> also have a look.

What's the exact question you'd like me to answer?

But anyway, bdrv_dec/inc_in_flight() around the sleep looks wrong to me.
Either the operation must be waited for in drain, then you can't
decrease the counter even during the sleep. Or drain doesn't have to
consider it, then why is the counter even increased in the first place?

The way it currently is, drain can return assuming that there are no
requests, but after the timeout the request automatically comes back
while the drain caller assumes that there is no more activity. This
doesn't look right.

Kevin

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc+hsLAAoJEH8JsnLIjy/W2P4QAIzOr5peWsxoXa7m/TGT10pM
rft5EixrFGjcxmTuUev+zzaPjKBwEwo3tB6FtkTf3ixJTfxBv9xC2SCAAK6+IlMG
TF/YhXl5+2wQyzP4vVXY8JaexZKxeOrZkr97Sam6o1TfBB9m8Ji4ryuen/Km16b7
iPdKaL4+3eW/WiNG+N7FpVtpCzqD/ONOjFVMEio55BAs8YU8cszqqNsH5yRRlkQS
6r56DrlPKL34yrl4+9y5G/4Sf39spd3MCV0wa0D08Q6gE6211LVaq6oKIDES6w3k
NIWIuqfCnGvLhii8gT6c+APLMvn0xkSBcplqc8ZYSJfUc10wzBw5SDRh+uK0KS8u
AlLtdGHq0rhEHttSOuw2mvwZswkHL/HubC6gu5aSvRQ0KFIjrc/zzh5enTjMTd5Y
VVhL8Nqd6KVfHZQHAB4jDNsSS9LODB1YrrILNq00k4oaTV63kpw+4tPpzgJeMxz4
95Eg+bh3Tat3t3ymD5ZRPYC05r+20Wd33LF5pkZ/t+OOFQnUYbNImBpkMo++37vW
qrNMfe7KU4J1seCCmU5sN4dsFw+AVjh/JaQCPGfUynwJufKKMXqzX0LqrrccZ8/V
4KPKwJt0KLfwHVbBni+Jnh0GFEeTusko5FrnZlhIZ3YkPjZd8MIckXfIPgU6GVZB
4hoDlj5k7dBbgVgOw/bx
=Y1+x
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

