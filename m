Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA4C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE9E204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE9E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwas-0004xI-TJ
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:41:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNwa9-0004O5-3R
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNwa5-00061H-JW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNwa5-0005zw-75
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA30633025B
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 09:40:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F076D5B08E;
	Tue,  7 May 2019 09:39:57 +0000 (UTC)
Date: Tue, 7 May 2019 10:39:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190507093954.GG27205@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgtqejn9.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 07 May 2019 09:40:10 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 10:47:06AM +0200, Markus Armbruster wrote:

> > The Golang JSON parser decodes JSON numbers to float64 by default so
> > will have this precision limitation too, though at least they provide
> > a backdoor for custom parsing from the original serialized representation.
> >
> >> > QEMU, and indeed many applications, want to handle 64-bit integers.
> >> > The C JSON library impls have traditionally mapped integers to the
> >> > data type 'long long int' which gives a min/max of  -(2^63) / 2^63-1.
> >> > 
> >> > QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64-1.
> 
> Correct.
> 
> Support for integers 2^63..2^64-1 is relatively recent: commit
> 2bc7cfea095 (v2.10, 2017).
> 
> Since we really needed these, the QObject input visitor silently casts
> negative integers to uint64_t.  It still does for backward
> compatibility.  Commit 5923f85fb82 (right after 2bc7cfea095) explains
> 
>     The input visitor will cast i64 input to u64 for compatibility
>     reasons (existing json QMP client already use negative i64 for large
>     u64, and expect an implicit cast in qemu).
>     
>     Note: before the patch, uint64_t values above INT64_MAX are sent over
>     json QMP as negative values, e.g. UINT64_MAX is sent as -1. After the
>     patch, they are sent unmodified.  Clearly a bug fix, but we have to
>     consider compatibility issues anyway.  libvirt should cope fine,
>     because its parsing of unsigned integers accepts negative values
>     modulo 2^64.  There's hope that other clients will, too.

So QEMU reading stuff sent by libvirt in a back compatible manner is
ok. The problem was specifically when a QEMU reply sent back UINT64_MAX
value as a positive number.


> >> > Libvirt has historically used the YAJL library which uses 'long long int'
> >> > and thus can't officially go beyond 2^63-1 values. Fortunately it lets
> >> > libvirt get at the raw json string, so libvirt can re-parse the value
> >> > to get an 'unsigned long long'.
> >> > 
> >> > We recently tried to switch to Jansson because YAJL has a dead upstream
> >> > for many years and countless unanswered bugs & patches. Unfortunately we
> >> > forgot about this need for 2^64-1 max, and Jansson also uses 'long long int'
> >> > and raises a fatal parse error for unsigned 64-bit values above 2^63-1. It
> >> > also provides no backdoor for libvirt todo its own integer parsing. Thus
> >> > we had to abort our switch to jansson as it broke parsing QEMU's JSON:
> >> > 
> >> >   https://bugzilla.redhat.com/show_bug.cgi?id=1614569
> >> > 
> >> > Other JSON libraries we've investigated have similar problems. I imagine
> >> > the same may well be true of non-C based JOSN impls, though I've not
> >> > investigated in any detail.
> >> > 
> >> > Essentially libvirt is stuck with either using the dead YAJL library
> >> > forever, or writing its own JSON parser (most likely copying QEMU's
> >> > JSON code into libvirt's git).
> >> > 
> >> > This feels like a very unappealing situation to be in as not being
> >> > able to use a JSON library of our choice is loosing one of the key
> >> > benefits of using a standard data format.
> >> > 
> >> > Thus I'd like to see a solution to this to allow QMP to be reliably
> >> > consumed by any JSON library that exists.
> 
> JSON is terrible at interoperability, so good luck with that.
> 
> If you reduce your order to "the commonly used JSON libraries we know",
> we can talk.

I don't particularly want us to rely on semantics of small known set
of JSON libs. I really do want us to do something that is capable of
working with any JSON impl that exists in any programming language.

My suggested option 2 & 3 at least would manage that I believe, as
any credible JSON impl will be able to represent 32-bit integers
or strings without loosing data.

Option 1 would not cope as some impls can't even cope with
signed 64-bit ints.

> >> > I can think of some options:
> >> > 
> >> >   1. Encode unsigned 64-bit integers as signed 64-bit integers.
> >> > 
> >> >      This follows the example that most C libraries map JSON ints
> >> >      to 'long long int'. This is still relying on undefined
> >> >      behaviour as apps don't need to support > 2^53-1.
> >> > 
> >> >      Apps would need to cast back to 'unsigned long long' for
> >> >      those QMP fields they know are supposed to be unsigned.
> 
> Ugly.  It's also what we did until v2.10, August 2017.  QMP's input
> direction still does it, for backward compatibility.
> 
> >> > 
> >> > 
> >> >   2. Encode all 64-bit integers as a pair of 32-bit integers.
> >> >     
> >> >      This is fully compliant with the JSON spec as each half
> >> >      is fully within the declared limits. App has to split or
> >> >      assemble the 2 pieces from/to a signed/unsigned 64-bit
> >> >      int as needed.
> 
> Differently ugly.
> 
> >> > 
> >> > 
> >> >   3. Encode all 64-bit integers as strings
> >> > 
> >> >      The application has todo all parsing/formatting client
> >> >      side.
> 
> Yet another ugly.
> 
> >> > 
> >> > 
> >> > None of these changes are backwards compatible, so I doubt we could make
> >> > the change transparently in QMP.  Instead we would have to have a
> >> > QMP greeting message capability where the client can request enablement
> >> > of the enhanced integer handling.
> 
> We might be able to do option 1 without capability negotiation.  v2.10's
> change from option 1 to what we have now produced zero complaints.
> 
> On the other hand, we made that change for a reason, so we may want a
> "send large integers as negative integers" capability regardless.
> 
> >> > 
> >> > Any of the three options above would likely work for libvirt, but I
> >> > would have a slight preference for either 2 or 3, so that we become
> >> > 100% standards compliant.
> 
> There's no such thing.  You mean "we maximize interoperability with
> common implementations of JSON".

s/common/any/

> Let's talk implementation for a bit.
> 
> Encoding and decoding integers in funny ways should be fairly easy in
> the QObject visitors.  The generated QMP marshallers all use them.
> Trouble is a few commands still bypass the generated marshallers, and
> mess with the QObject themselves:
> 
> * query-qmp-schema: minor hack explained in qmp_query_qmp_schema()'s
>   comment.  Should be harmless.
> 
> * netdev_add: not QAPIfied.  Eric's patches to QAPIfy it got stuck
>   because they reject some abuses like passing numbers and bools as
>   strings.
> 
> * device_add: not QAPIfied.  We're not sure QAPIfication is feasible.
> 
> netdev_add and device_add both use qemu_opts_from_qdict().  Perhaps we
> could hack that to mirror what the QObject visitor do.
> 
> Else, we might have to do it in the JSON parser.  Should be possible,
> but I'd rather not.
> 
> >> My preference would be 3 with the strings defined as being
> >> %x lower case hex formated with a 0x prefix and no longer than 18 characters
> >> ("0x" + 16 nybbles). Zero padding allowed but not required.
> >> It's readable and unambiguous when dealing with addresses; I don't want
> >> to have to start decoding (2) by hand when debugging.
> >
> > Yep, that's a good point about readability.
> 
> QMP sending all integers in decimal is inconvenient for some values,
> such as addresses.  QMP sending all (large) integers in hexadecimal
> would be inconvenient for other values.
> 
> Let's keep it simple & stupid.  If you want sophistication, JSON is the
> wrong choice.
> 
> 
> Option 1 feels simplest.

But will still fail with any JSON impl that uses double precision floating
point for integers as it will loose precision.

> Option 2 feels ugliest.  Less simple, more interoperable than option 1.

If we assume any JSON impl can do 32-bit integers without loss of
precision, then I think we can say it is guaranteed portable, but
it is certainly horrible / ugly.

> Option 3 is like option 2, just not quite as ugly.

I think option 3 can be guaranteed to be loss-less with /any/ JSON impl
that exists, since you're delegating all string -> int conversion to
the application code taking the JSON parser/formatter out of the equation.

This is close to the approach libvirt takes with YAJL parser today. YAJL
parses as a int64 and we then ignore its result, and re-parse the string
again in libvirt as uint64. When generating json we format as uint64
in libvirt and ignore YAJLs formatting for int64.

> Can we agree to eliminate option 2 from the race?

I'm fine with eliminating option 2.

I guess I'd have a preference for option 3 given that it has better
interoperability

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

