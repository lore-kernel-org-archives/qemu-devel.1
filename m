Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A4C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5420578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56535 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQA80-0000Tw-QX
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:32:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQA6I-0007bv-RL
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQA5T-0008Hr-8p
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQA5P-0008G3-W9
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:29:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 077703079B9D
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 12:29:41 +0000 (UTC)
Received: from work-vm (ovpn-117-195.ams2.redhat.com [10.36.117.195])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 716C010027BF;
	Mon, 13 May 2019 12:29:36 +0000 (UTC)
Date: Mon, 13 May 2019 13:29:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190513122933.GC2786@work-vm>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
	<875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190513120856.GH15029@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 13 May 2019 12:29:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
 JSON standards compliance
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, May 08, 2019 at 02:44:07PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >=20
> > > On Tue, May 07, 2019 at 10:47:06AM +0200, Markus Armbruster wrote:
> > >
> > >> >> > I can think of some options:
> > >> >> >=20
> > >> >> >   1. Encode unsigned 64-bit integers as signed 64-bit integer=
s.
> > >> >> >=20
> > >> >> >      This follows the example that most C libraries map JSON =
ints
> > >> >> >      to 'long long int'. This is still relying on undefined
> > >> >> >      behaviour as apps don't need to support > 2^53-1.
> > >> >> >=20
> > >> >> >      Apps would need to cast back to 'unsigned long long' for
> > >> >> >      those QMP fields they know are supposed to be unsigned.
> > >>=20
> > >> Ugly.  It's also what we did until v2.10, August 2017.  QMP's inpu=
t
> > >> direction still does it, for backward compatibility.
> > >>=20
> > >> >> >=20
> > >> >> >=20
> > >> >> >   2. Encode all 64-bit integers as a pair of 32-bit integers.
> > >> >> >    =20
> > >> >> >      This is fully compliant with the JSON spec as each half
> > >> >> >      is fully within the declared limits. App has to split or
> > >> >> >      assemble the 2 pieces from/to a signed/unsigned 64-bit
> > >> >> >      int as needed.
> > >>=20
> > >> Differently ugly.
> > >>=20
> > >> >> >=20
> > >> >> >=20
> > >> >> >   3. Encode all 64-bit integers as strings
> > >> >> >=20
> > >> >> >      The application has todo all parsing/formatting client
> > >> >> >      side.
> > >>=20
> > >> Yet another ugly.
> > >>=20
> > >> >> >=20
> > >> >> >=20
> > >> >> > None of these changes are backwards compatible, so I doubt we=
 could make
> > >> >> > the change transparently in QMP.  Instead we would have to ha=
ve a
> > >> >> > QMP greeting message capability where the client can request =
enablement
> > >> >> > of the enhanced integer handling.
> > >>=20
> > >> We might be able to do option 1 without capability negotiation.  v=
2.10's
> > >> change from option 1 to what we have now produced zero complaints.
> > >>=20
> > >> On the other hand, we made that change for a reason, so we may wan=
t a
> > >> "send large integers as negative integers" capability regardless.
> > >>=20
> > >> >> >=20
> > >> >> > Any of the three options above would likely work for libvirt,=
 but I
> > >> >> > would have a slight preference for either 2 or 3, so that we =
become
> > >> >> > 100% standards compliant.
> > >>=20
> > >> There's no such thing.  You mean "we maximize interoperability wit=
h
> > >> common implementations of JSON".
> > >
> > > s/common/any/
> >=20
> > info: error correction applied, future applications will be silent ;-=
P
> >=20
> > >> Let's talk implementation for a bit.
> > >>=20
> > >> Encoding and decoding integers in funny ways should be fairly easy=
 in
> > >> the QObject visitors.  The generated QMP marshallers all use them.
> > >> Trouble is a few commands still bypass the generated marshallers, =
and
> > >> mess with the QObject themselves:
> > >>=20
> > >> * query-qmp-schema: minor hack explained in qmp_query_qmp_schema()=
's
> > >>   comment.  Should be harmless.
> > >>=20
> > >> * netdev_add: not QAPIfied.  Eric's patches to QAPIfy it got stuck
> > >>   because they reject some abuses like passing numbers and bools a=
s
> > >>   strings.
> > >>=20
> > >> * device_add: not QAPIfied.  We're not sure QAPIfication is feasib=
le.
> > >>=20
> > >> netdev_add and device_add both use qemu_opts_from_qdict().  Perhap=
s we
> > >> could hack that to mirror what the QObject visitor do.
> > >>=20
> > >> Else, we might have to do it in the JSON parser.  Should be possib=
le,
> > >> but I'd rather not.
> > >>=20
> > >> >> My preference would be 3 with the strings defined as being
> > >> >> %x lower case hex formated with a 0x prefix and no longer than =
18 characters
> > >> >> ("0x" + 16 nybbles). Zero padding allowed but not required.
> > >> >> It's readable and unambiguous when dealing with addresses; I do=
n't want
> > >> >> to have to start decoding (2) by hand when debugging.
> > >> >
> > >> > Yep, that's a good point about readability.
> > >>=20
> > >> QMP sending all integers in decimal is inconvenient for some value=
s,
> > >> such as addresses.  QMP sending all (large) integers in hexadecima=
l
> > >> would be inconvenient for other values.
> > >>=20
> > >> Let's keep it simple & stupid.  If you want sophistication, JSON i=
s the
> > >> wrong choice.
> > >>=20
> > >>=20
> > >> Option 1 feels simplest.
> > >
> > > But will still fail with any JSON impl that uses double precision f=
loating
> > > point for integers as it will loose precision.
> > >
> > >> Option 2 feels ugliest.  Less simple, more interoperable than opti=
on 1.
> > >
> > > If we assume any JSON impl can do 32-bit integers without loss of
> > > precision, then I think we can say it is guaranteed portable, but
> > > it is certainly horrible / ugly.
> > >
> > >> Option 3 is like option 2, just not quite as ugly.
> > >
> > > I think option 3 can be guaranteed to be loss-less with /any/ JSON =
impl
> > > that exists, since you're delegating all string -> int conversion t=
o
> > > the application code taking the JSON parser/formatter out of the eq=
uation.
> >=20
> > Double-checking: do you propose to encode *all* numbers as strings, o=
r
> > just certain "problematic" numbers?
> >=20
> > If the latter, I guess your idea of "problematic" is "not representab=
le
> > exactly as double precision floating-point".
>=20
> We have a few options
>=20
>  1. Use string format for values > 2^53-1, int format below that
>  2. Use string format for all fields which are 64-bit ints whether
>     signed or unsigned
>  3. Use string format for all fields which are integers, even 32-bit
>     ones
>=20
> I would probably suggest option 2. It would make the QEMU impl quite
> easy IIUC, we we'd just change the QAPI visitor's impl for the int64
> and uint64 fields to use string format (when the right capability is
> negotiated by QMP).
>=20
> I include 3 only for completeness - I don't think there's a hugely
> compelling reason to mess with 32-bit ints.

What about when the size is architecture dependent?

> Option 1 is the bare minimum needed to ensure precision, but to me
> it feels a bit dirty to say a given field will have different encoding
> depending on the value. If apps need to deal with string encoding, they
> might as well just use it for all values in a given field.

Yeh, 1 is horrid; it's too easy to miss a case which forgot to handle
 the 2^53-1 because we hadn't forced a large value down that check.

Dave

> > > I guess I'd have a preference for option 3 given that it has better
> > > interoperability
> >=20
> > If we add a QMP capability for interoperability with JSON
> > implementations that set limits on range and precision that are
> > incompatible with the ones QMP sets, one could argue we effectively p=
ay
> > the price for option 3, so we should take it for its benefits.
> >=20
> > Option 1 without a QMP capability merely reverts the change we made i=
n
> > 2.10.  We can do that if we think it's sufficient.
> >=20
> > You expressed a strong preference for maximizing interoperability (vi=
a
> > option 3).  Acknowledged.  However, I care a lot more about issues we
> > know we have than about issues somebody might have.
> >=20
> > You mentioned the libvirt's switch to Jansson you had to abort due to
> > QMP sending numbers Jansson refuses to parse.  That's the kind of
> > non-hypothetical issue that can make me mess with the QMP language.
> >=20
> > You wrote Jansson "raises a fatal parse error for unsigned 64-bit val=
ues
> > above 2^63-1".  Does that mean it rejects 9223372036854775808, but
> > accepts 9223372036854775808.0 (with loss of precision)?
>=20
> If it sees a '.' in the number, then it call strtod() and checks for
> the overflow conditions.
>=20
> If it doesn't see a '.' in the number then it calls strtoll and checks
> for the overflow conditions.
>=20
> So to answer you question, yes, it looks like it will reject
> 9223372036854775808 and accept 9223372036854775808.0 with loss of
> precision.
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

