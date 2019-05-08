Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A25FC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C3721019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLz4-0002Uu-Jc
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:47:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOLvi-0006k4-KK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOLvg-0008Nv-Ey
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOLvg-0008NH-7S
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93291309B167
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 12:44:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C50E660C93;
	Wed,  8 May 2019 12:44:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 496C71132B35; Wed,  8 May 2019 14:44:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
Date: Wed, 08 May 2019 14:44:07 +0200
In-Reply-To: <20190507093954.GG27205@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 7 May 2019 10:39:54 +0100")
Message-ID: <875zql3ylk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 08 May 2019 12:44:11 +0000 (UTC)
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
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, May 07, 2019 at 10:47:06AM +0200, Markus Armbruster wrote:
>
>> > The Golang JSON parser decodes JSON numbers to float64 by default so
>> > will have this precision limitation too, though at least they provide
>> > a backdoor for custom parsing from the original serialized representat=
ion.
>> >
>> >> > QEMU, and indeed many applications, want to handle 64-bit integers.
>> >> > The C JSON library impls have traditionally mapped integers to the
>> >> > data type 'long long int' which gives a min/max of  -(2^63) / 2^63-=
1.
>> >> >=20
>> >> > QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64=
-1.
>>=20
>> Correct.
>>=20
>> Support for integers 2^63..2^64-1 is relatively recent: commit
>> 2bc7cfea095 (v2.10, 2017).
>>=20
>> Since we really needed these, the QObject input visitor silently casts
>> negative integers to uint64_t.  It still does for backward
>> compatibility.  Commit 5923f85fb82 (right after 2bc7cfea095) explains
>>=20
>>     The input visitor will cast i64 input to u64 for compatibility
>>     reasons (existing json QMP client already use negative i64 for large
>>     u64, and expect an implicit cast in qemu).
>>=20=20=20=20=20
>>     Note: before the patch, uint64_t values above INT64_MAX are sent over
>>     json QMP as negative values, e.g. UINT64_MAX is sent as -1. After the
>>     patch, they are sent unmodified.  Clearly a bug fix, but we have to
>>     consider compatibility issues anyway.  libvirt should cope fine,
>>     because its parsing of unsigned integers accepts negative values
>>     modulo 2^64.  There's hope that other clients will, too.
>
> So QEMU reading stuff sent by libvirt in a back compatible manner is
> ok. The problem was specifically when a QEMU reply sent back UINT64_MAX
> value as a positive number.

Yes.  The commit message (tries to) explain exactly that.

>> >> > Libvirt has historically used the YAJL library which uses 'long lon=
g int'
>> >> > and thus can't officially go beyond 2^63-1 values. Fortunately it l=
ets
>> >> > libvirt get at the raw json string, so libvirt can re-parse the val=
ue
>> >> > to get an 'unsigned long long'.
>> >> >=20
>> >> > We recently tried to switch to Jansson because YAJL has a dead upst=
ream
>> >> > for many years and countless unanswered bugs & patches. Unfortunate=
ly we
>> >> > forgot about this need for 2^64-1 max, and Jansson also uses 'long =
long int'
>> >> > and raises a fatal parse error for unsigned 64-bit values above 2^6=
3-1. It
>> >> > also provides no backdoor for libvirt todo its own integer parsing.=
 Thus
>> >> > we had to abort our switch to jansson as it broke parsing QEMU's JS=
ON:
>> >> >=20
>> >> >   https://bugzilla.redhat.com/show_bug.cgi?id=3D1614569
>> >> >=20
>> >> > Other JSON libraries we've investigated have similar problems. I im=
agine
>> >> > the same may well be true of non-C based JOSN impls, though I've not
>> >> > investigated in any detail.
>> >> >=20
>> >> > Essentially libvirt is stuck with either using the dead YAJL library
>> >> > forever, or writing its own JSON parser (most likely copying QEMU's
>> >> > JSON code into libvirt's git).
>> >> >=20
>> >> > This feels like a very unappealing situation to be in as not being
>> >> > able to use a JSON library of our choice is loosing one of the key
>> >> > benefits of using a standard data format.
>> >> >=20
>> >> > Thus I'd like to see a solution to this to allow QMP to be reliably
>> >> > consumed by any JSON library that exists.
>>=20
>> JSON is terrible at interoperability, so good luck with that.
>>=20
>> If you reduce your order to "the commonly used JSON libraries we know",
>> we can talk.
>
> I don't particularly want us to rely on semantics of small known set
> of JSON libs. I really do want us to do something that is capable of
> working with any JSON impl that exists in any programming language.

I think we're disagreeing mostly on the meaning of terms, and in ways
that don't matter all that much.

When you say "any JSON impl that exists in any programming language",
then I understand "any conceivable implementation that conforms to the
specification".

Trouble is the specification underspecifies numbers to a degree that you
cannot know what conforming implementations will accept.  An
implementation that accepts just 0 would still be conforming.  It would
also be useless.  An implementation that accepts just 64 bit signed
integers would still be conforming.  Useless?  Depends.  My point is: we
cannot know what *all* implementations accept.

One of "know" and "all" will have to give.

My choice is to relax in accordance with the guidance from RFC 7159 and
8259 I quoted (and you snipped):

    This specification allows implementations to set limits on the range
    and precision of numbers accepted.  Since software that implements
    IEEE 754-2008 binary64 (double precision) numbers [IEEE754] is
    generally available and widely used, good interoperability can be
    achieved by implementations that expect no more precision or range
    than these provide, in the sense that implementations will
    approximate JSON numbers within the expected precision.  A JSON
    number such as 1E400 or 3.141592653589793238462643383279 may indicate
    potential interoperability problems, since it suggests that the
    software that created it expects receiving software to have greater
    capabilities for numeric magnitude and precision than is widely
    available.

    Note that when such software is used, numbers that are integers and
    are in the range [-(2**53)+1, (2**53)-1] are interoperable in the
    sense that implementations will agree exactly on their numeric
    values.

Bottom line: limiting integer use to 53 bits signed is likely to
maximize interoperability with common implementations.  It might well
achieve interoperability with all implementations that matter to us.  I
think that's close enough to "all" to stop arguing about the difference.
If you insist to call it "all" going forward, I'll silently
error-correct it to "enough".

> My suggested option 2 & 3 at least would manage that I believe, as
> any credible JSON impl will be able to represent 32-bit integers
> or strings without loosing data.

You just relaxed your categorical "all" to just "credible" :)

> Option 1 would not cope as some impls can't even cope with
> signed 64-bit ints.
>
>> >> > I can think of some options:
>> >> >=20
>> >> >   1. Encode unsigned 64-bit integers as signed 64-bit integers.
>> >> >=20
>> >> >      This follows the example that most C libraries map JSON ints
>> >> >      to 'long long int'. This is still relying on undefined
>> >> >      behaviour as apps don't need to support > 2^53-1.
>> >> >=20
>> >> >      Apps would need to cast back to 'unsigned long long' for
>> >> >      those QMP fields they know are supposed to be unsigned.
>>=20
>> Ugly.  It's also what we did until v2.10, August 2017.  QMP's input
>> direction still does it, for backward compatibility.
>>=20
>> >> >=20
>> >> >=20
>> >> >   2. Encode all 64-bit integers as a pair of 32-bit integers.
>> >> >=20=20=20=20=20
>> >> >      This is fully compliant with the JSON spec as each half
>> >> >      is fully within the declared limits. App has to split or
>> >> >      assemble the 2 pieces from/to a signed/unsigned 64-bit
>> >> >      int as needed.
>>=20
>> Differently ugly.
>>=20
>> >> >=20
>> >> >=20
>> >> >   3. Encode all 64-bit integers as strings
>> >> >=20
>> >> >      The application has todo all parsing/formatting client
>> >> >      side.
>>=20
>> Yet another ugly.
>>=20
>> >> >=20
>> >> >=20
>> >> > None of these changes are backwards compatible, so I doubt we could=
 make
>> >> > the change transparently in QMP.  Instead we would have to have a
>> >> > QMP greeting message capability where the client can request enable=
ment
>> >> > of the enhanced integer handling.
>>=20
>> We might be able to do option 1 without capability negotiation.  v2.10's
>> change from option 1 to what we have now produced zero complaints.
>>=20
>> On the other hand, we made that change for a reason, so we may want a
>> "send large integers as negative integers" capability regardless.
>>=20
>> >> >=20
>> >> > Any of the three options above would likely work for libvirt, but I
>> >> > would have a slight preference for either 2 or 3, so that we become
>> >> > 100% standards compliant.
>>=20
>> There's no such thing.  You mean "we maximize interoperability with
>> common implementations of JSON".
>
> s/common/any/

info: error correction applied, future applications will be silent ;-P

>> Let's talk implementation for a bit.
>>=20
>> Encoding and decoding integers in funny ways should be fairly easy in
>> the QObject visitors.  The generated QMP marshallers all use them.
>> Trouble is a few commands still bypass the generated marshallers, and
>> mess with the QObject themselves:
>>=20
>> * query-qmp-schema: minor hack explained in qmp_query_qmp_schema()'s
>>   comment.  Should be harmless.
>>=20
>> * netdev_add: not QAPIfied.  Eric's patches to QAPIfy it got stuck
>>   because they reject some abuses like passing numbers and bools as
>>   strings.
>>=20
>> * device_add: not QAPIfied.  We're not sure QAPIfication is feasible.
>>=20
>> netdev_add and device_add both use qemu_opts_from_qdict().  Perhaps we
>> could hack that to mirror what the QObject visitor do.
>>=20
>> Else, we might have to do it in the JSON parser.  Should be possible,
>> but I'd rather not.
>>=20
>> >> My preference would be 3 with the strings defined as being
>> >> %x lower case hex formated with a 0x prefix and no longer than 18 cha=
racters
>> >> ("0x" + 16 nybbles). Zero padding allowed but not required.
>> >> It's readable and unambiguous when dealing with addresses; I don't wa=
nt
>> >> to have to start decoding (2) by hand when debugging.
>> >
>> > Yep, that's a good point about readability.
>>=20
>> QMP sending all integers in decimal is inconvenient for some values,
>> such as addresses.  QMP sending all (large) integers in hexadecimal
>> would be inconvenient for other values.
>>=20
>> Let's keep it simple & stupid.  If you want sophistication, JSON is the
>> wrong choice.
>>=20
>>=20
>> Option 1 feels simplest.
>
> But will still fail with any JSON impl that uses double precision floating
> point for integers as it will loose precision.
>
>> Option 2 feels ugliest.  Less simple, more interoperable than option 1.
>
> If we assume any JSON impl can do 32-bit integers without loss of
> precision, then I think we can say it is guaranteed portable, but
> it is certainly horrible / ugly.
>
>> Option 3 is like option 2, just not quite as ugly.
>
> I think option 3 can be guaranteed to be loss-less with /any/ JSON impl
> that exists, since you're delegating all string -> int conversion to
> the application code taking the JSON parser/formatter out of the equation.

Double-checking: do you propose to encode *all* numbers as strings, or
just certain "problematic" numbers?

If the latter, I guess your idea of "problematic" is "not representable
exactly as double precision floating-point".

> This is close to the approach libvirt takes with YAJL parser today. YAJL
> parses as a int64 and we then ignore its result, and re-parse the string
> again in libvirt as uint64. When generating json we format as uint64
> in libvirt and ignore YAJLs formatting for int64.
>
>> Can we agree to eliminate option 2 from the race?
>
> I'm fine with eliminating option 2.

Eric, too.  Consider it eliminated.

> I guess I'd have a preference for option 3 given that it has better
> interoperability

If we add a QMP capability for interoperability with JSON
implementations that set limits on range and precision that are
incompatible with the ones QMP sets, one could argue we effectively pay
the price for option 3, so we should take it for its benefits.

Option 1 without a QMP capability merely reverts the change we made in
2.10.  We can do that if we think it's sufficient.

You expressed a strong preference for maximizing interoperability (via
option 3).  Acknowledged.  However, I care a lot more about issues we
know we have than about issues somebody might have.

You mentioned the libvirt's switch to Jansson you had to abort due to
QMP sending numbers Jansson refuses to parse.  That's the kind of
non-hypothetical issue that can make me mess with the QMP language.

You wrote Jansson "raises a fatal parse error for unsigned 64-bit values
above 2^63-1".  Does that mean it rejects 9223372036854775808, but
accepts 9223372036854775808.0 (with loss of precision)?

