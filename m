Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B372204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B372204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvpv-0001IR-5e
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:52:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNvko-0005zv-ES
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNvkm-0008UR-HF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:47:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNvkm-0008Th-9M
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AAE33079B69
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 08:47:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC0341820F;
	Tue,  7 May 2019 08:47:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 382721132B35; Tue,  7 May 2019 10:47:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
Date: Tue, 07 May 2019 10:47:06 +0200
In-Reply-To: <20190430150556.GA2423@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Tue, 30 Apr 2019 16:05:56 +0100")
Message-ID: <87sgtqejn9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 08:47:10 +0000 (UTC)
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

> On Tue, Apr 30, 2019 at 03:45:46PM +0100, Dr. David Alan Gilbert wrote:
>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> > The QEMU  QMP service is based on JSON which is nice because that is a
>> > widely supported "standard" data format.....
>> >=20
>> > ....except QEMU's implementation (and indeed most impls) are not stric=
tly
>> > standards compliant.

As we'll see below, speaking of "strict standard compliance" is
meaningless, because the standard is too weak.  What you mean is "lowest
common denominator of relevant implementations".

>> > Specifically the problem is around representing 64-bit integers, wheth=
er
>> > signed or unsigned.
>> >=20
>> > The JSON standard declares that largest integer is 2^53-1 and the
>> > likewise the smallest is -(2^53-1):
>> >=20
>> >   http://www.ecma-international.org/ecma-262/6.0/index.html#sec-number=
.max_safe_integer

This is the ECMAScript standard, not the JSON standard.  For JSON, the
situation is more confused.  See below.

>> > A crazy limit inherited from its javascript origins IIUC.
>>=20
>> Ewwww.
>
> Looking a bit deeper it seems this limit comes from the use of double
> precision floating point for storing integers. 2^53-1 is the largest
> integer value that can be stored in a 64-bit float without loss of
> precision.

Correct.  JavaScript has only one type of number, and they're all
represented as double precision floating-point.  Perfectly sensible for
a prototype done in ten days.  Move fast and leave things broken
forever.

JSON is derived from JavaScript.  RFC 4672 is notoriously useless on
precision and range.  RFC 7159 attempts to contain the damage by
spelling out how useless it:

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

RFC 8259 keeps this unchanged.

QEMU does conform to RFC 8259.  It sets limits on range and precision of
numbers accepted: double precision \union the integers between INT64_MIN
and UINT64_MAX inclusive.  The trouble is that conformance doesn't imply
interoperability.

Many other implementations follow JavaScript and limit numbers to
double.

> The Golang JSON parser decodes JSON numbers to float64 by default so
> will have this precision limitation too, though at least they provide
> a backdoor for custom parsing from the original serialized representation.
>
>> > QEMU, and indeed many applications, want to handle 64-bit integers.
>> > The C JSON library impls have traditionally mapped integers to the
>> > data type 'long long int' which gives a min/max of  -(2^63) / 2^63-1.
>> >=20
>> > QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64-1.

Correct.

Support for integers 2^63..2^64-1 is relatively recent: commit
2bc7cfea095 (v2.10, 2017).

Since we really needed these, the QObject input visitor silently casts
negative integers to uint64_t.  It still does for backward
compatibility.  Commit 5923f85fb82 (right after 2bc7cfea095) explains

    The input visitor will cast i64 input to u64 for compatibility
    reasons (existing json QMP client already use negative i64 for large
    u64, and expect an implicit cast in qemu).
=20=20=20=20
    Note: before the patch, uint64_t values above INT64_MAX are sent over
    json QMP as negative values, e.g. UINT64_MAX is sent as -1. After the
    patch, they are sent unmodified.  Clearly a bug fix, but we have to
    consider compatibility issues anyway.  libvirt should cope fine,
    because its parsing of unsigned integers accepts negative values
    modulo 2^64.  There's hope that other clients will, too.

>> > Libvirt has historically used the YAJL library which uses 'long long i=
nt'
>> > and thus can't officially go beyond 2^63-1 values. Fortunately it lets
>> > libvirt get at the raw json string, so libvirt can re-parse the value
>> > to get an 'unsigned long long'.
>> >=20
>> > We recently tried to switch to Jansson because YAJL has a dead upstream
>> > for many years and countless unanswered bugs & patches. Unfortunately =
we
>> > forgot about this need for 2^64-1 max, and Jansson also uses 'long lon=
g int'
>> > and raises a fatal parse error for unsigned 64-bit values above 2^63-1=
. It
>> > also provides no backdoor for libvirt todo its own integer parsing. Th=
us
>> > we had to abort our switch to jansson as it broke parsing QEMU's JSON:
>> >=20
>> >   https://bugzilla.redhat.com/show_bug.cgi?id=3D1614569
>> >=20
>> > Other JSON libraries we've investigated have similar problems. I imagi=
ne
>> > the same may well be true of non-C based JOSN impls, though I've not
>> > investigated in any detail.
>> >=20
>> > Essentially libvirt is stuck with either using the dead YAJL library
>> > forever, or writing its own JSON parser (most likely copying QEMU's
>> > JSON code into libvirt's git).
>> >=20
>> > This feels like a very unappealing situation to be in as not being
>> > able to use a JSON library of our choice is loosing one of the key
>> > benefits of using a standard data format.
>> >=20
>> > Thus I'd like to see a solution to this to allow QMP to be reliably
>> > consumed by any JSON library that exists.

JSON is terrible at interoperability, so good luck with that.

If you reduce your order to "the commonly used JSON libraries we know",
we can talk.

>> > I can think of some options:
>> >=20
>> >   1. Encode unsigned 64-bit integers as signed 64-bit integers.
>> >=20
>> >      This follows the example that most C libraries map JSON ints
>> >      to 'long long int'. This is still relying on undefined
>> >      behaviour as apps don't need to support > 2^53-1.
>> >=20
>> >      Apps would need to cast back to 'unsigned long long' for
>> >      those QMP fields they know are supposed to be unsigned.

Ugly.  It's also what we did until v2.10, August 2017.  QMP's input
direction still does it, for backward compatibility.

>> >=20
>> >=20
>> >   2. Encode all 64-bit integers as a pair of 32-bit integers.
>> >=20=20=20=20=20
>> >      This is fully compliant with the JSON spec as each half
>> >      is fully within the declared limits. App has to split or
>> >      assemble the 2 pieces from/to a signed/unsigned 64-bit
>> >      int as needed.

Differently ugly.

>> >=20
>> >=20
>> >   3. Encode all 64-bit integers as strings
>> >=20
>> >      The application has todo all parsing/formatting client
>> >      side.

Yet another ugly.

>> >=20
>> >=20
>> > None of these changes are backwards compatible, so I doubt we could ma=
ke
>> > the change transparently in QMP.  Instead we would have to have a
>> > QMP greeting message capability where the client can request enablement
>> > of the enhanced integer handling.

We might be able to do option 1 without capability negotiation.  v2.10's
change from option 1 to what we have now produced zero complaints.

On the other hand, we made that change for a reason, so we may want a
"send large integers as negative integers" capability regardless.

>> >=20
>> > Any of the three options above would likely work for libvirt, but I
>> > would have a slight preference for either 2 or 3, so that we become
>> > 100% standards compliant.

There's no such thing.  You mean "we maximize interoperability with
common implementations of JSON".

Let's talk implementation for a bit.

Encoding and decoding integers in funny ways should be fairly easy in
the QObject visitors.  The generated QMP marshallers all use them.
Trouble is a few commands still bypass the generated marshallers, and
mess with the QObject themselves:

* query-qmp-schema: minor hack explained in qmp_query_qmp_schema()'s
  comment.  Should be harmless.

* netdev_add: not QAPIfied.  Eric's patches to QAPIfy it got stuck
  because they reject some abuses like passing numbers and bools as
  strings.

* device_add: not QAPIfied.  We're not sure QAPIfication is feasible.

netdev_add and device_add both use qemu_opts_from_qdict().  Perhaps we
could hack that to mirror what the QObject visitor do.

Else, we might have to do it in the JSON parser.  Should be possible,
but I'd rather not.

>> My preference would be 3 with the strings defined as being
>> %x lower case hex formated with a 0x prefix and no longer than 18 charac=
ters
>> ("0x" + 16 nybbles). Zero padding allowed but not required.
>> It's readable and unambiguous when dealing with addresses; I don't want
>> to have to start decoding (2) by hand when debugging.
>
> Yep, that's a good point about readability.

QMP sending all integers in decimal is inconvenient for some values,
such as addresses.  QMP sending all (large) integers in hexadecimal
would be inconvenient for other values.

Let's keep it simple & stupid.  If you want sophistication, JSON is the
wrong choice.


Option 1 feels simplest.

Option 2 feels ugliest.  Less simple, more interoperable than option 1.

Option 3 is like option 2, just not quite as ugly.

Can we agree to eliminate option 2 from the race?

