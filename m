Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF38C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 22:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F9D206D5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 22:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBoNCmZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F9D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivU1w-00060f-Iw
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 17:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ivU0n-0004yI-QK
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 17:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ivU0k-0004rW-6w
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 17:34:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ivU0j-0004ps-QU
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 17:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idNolRq4/Ixg9a6sI0PY/AuC2QGc8UpfUi9cKFnkhlE=;
 b=EBoNCmZyYNcZJELy1KjLn9gfPTLTgq3qzBScf4OI4nxiFxNDEy3v+JpGlsAc1khzi8Y5XV
 rZx4JppVvPF5AjeL7ogqMMInXfzfoGip7UjvDxE+ONI7bA90xQo106y1T/F/1PhtjDOnz8
 xnR4pkyS7eyCSetzhh8HG5qQbkOXxfM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ClGZapJIN6q5ivyCatq33w-1; Sat, 25 Jan 2020 17:34:33 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so3602494wrq.6
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 14:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=JikImegiSpJMgw2oXw7CJE7pGg3M7Ng/5d1SXwXJKqM=;
 b=Ql2dwUYiV1chGlcXGNcPEk+zDc79azDl0PFUwxxhTDB3jejzXKO+OH81NcllI6jI5L
 NvqlTWXMxfasxP+x6VjAHHwqDt0GWy+haE1tGU/gzMIp4CJ24xsRs2ZAu8eHtIAjZdcl
 zUHI3VAY0G5+s5lwovnkL2OQiJ3oJwPfzSb+klmRcTW0FJzhuC39oZrb03hAlIgXfEYo
 CYscdjERnGM58R0l6NcFlA3oyaeLIKwA6n/TpD+nTVxFk9NZC1BDLLxi57LwUyPnYDSL
 waitAH+YH1LgfDSuuQkmkXq6qQY4zPCa4UP2nTp6RWh5oZXFUSMlI2AZjvIQKDiLu9cK
 anXw==
X-Gm-Message-State: APjAAAX5OU/aanKuIDv1WOFWBLR4f0j/Ivg/4UVCzdn3lUD6aeqrFmID
 AJCdrDsOAhl9vB+f/BkZxRppgtY8LFgukgPAXUsqczREWU4N0xZRReqUqquHt4emMICP/6uoMgO
 Iqmrw3Kzj/iN++pc=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr11976739wrs.420.1579991670597; 
 Sat, 25 Jan 2020 14:34:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqr/tYRLobmGoobb5K+kPdPblnTGSot6cHtLXslRtoPtyBvGVJkWqYHM/l/MG4I7EVZjOz+w==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr11976718wrs.420.1579991670035; 
 Sat, 25 Jan 2020 14:34:30 -0800 (PST)
Received: from [10.1.251.124] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id n1sm13096291wrw.52.2020.01.25.14.34.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Jan 2020 14:34:28 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
Date: Sat, 25 Jan 2020 23:34:27 +0100
Message-Id: <FE9C23F6-A793-4A16-AFFB-51C53A894B98@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org> <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: ClGZapJIN6q5ivyCatq33w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 23 Jan 2020, at 18:58, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 1/23/20 2:19 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>>> On 12/24/19 8:41 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>> * scripts/qmp/qmp-shell
>>>>>=20
>>>>>  Half-hearted attempt at a human-friendly wrapper around the JSON
>>>>>  syntax.  I have no use for this myself.
>>>> I use this fairly often as its a useful debugging / experimentation
>>>> / trouble shooting tool. There's similar ish functionality in
>>>> virsh qemu-monitor-command. I think there's scope of a supported
>>>> tool here that can talk to libvirt or a UNIX socket for doing
>>>> QMP commands, with a friendlier syntax & pretty printing.=20
>>>>=20
>>>=20
>>> qmp-shell is one of my go-to tools for working through bitmap workflows
>>> where we don't have convenience commands yet, as some of the setups
>>> required for fleecing et al involve quite a number of steps.
>>>=20
>>> I can copy-paste raw JSON into a socket, but personally I like seeing m=
y
>>> commands neatly organized in a format where I can visually reduce them
>>> to their components at a glance.
>>>=20
>>> (What I mean is: It's hard to remember which QMP commands you've barfed
>>> into a terminal because JSON is hard to read and looks very visually
>>> repetitive.)
>>>=20
>>> I tried to rewrite qmp-shell late last year, actually. I wanted to writ=
e
>>> a new REPL that was json-aware in some manner such that you could write
>>> multi-line commands like this:
>>>=20
>>>> example-command arg=3D{
>>>  "hello": "world"
>>> }
>>>=20
>>> This requires, sadly, a streamable JSON parser. Most JSON parsers built
>>> into Python as-is simply take a file pointer and consume the entirety o=
f
>>> the rest of the stream -- they don't play very nice with incomplete
>>> input or input that may have trailing data, e.g.:
>>>=20
>>>> example-command arg=3D{
>>>  "hello": "world"
>>> } arg2=3D{
>>>  "oops!": "more json!"
>>> }
>>=20
>> QMP is in the same boat: it needs to process input that isn't
>> necessarily full expressions (JSON-text in the RFC's grammar).
>>=20
>> Any conventional parser can be made streaming by turning it into a
>> coroutine.  This is probably the simplest solution for handwritten
>> streaming LL parsers, because it permits recursive descent.  In Python,
>> I'd try a generator.
>>=20
>> Our actual solution for QMP predates coroutine support in QEMU, and is
>> rather hamfisted:
>>=20
>> * Streaming lexer: it gets fed characters one at a time, and when its
>>  state machine says "token complete", it feeds the token to the
>>  "streamer".
>>=20
>> * "Streamer": gets fed tokens one at a time, buffers them up counting
>>  curly and square bracket nesting until the nesting is zero, then
>>  passes the buffered tokens to the parser.
>>=20
>> * Non-streaming parser: it gets fed a sequence of tokens that constitute
>>  a full expression.
>>=20
>> The best I can say about this is that it works.  The streamer's token
>> buffer eats a lot of memory compared to a real streaming parser, but in
>> practice, it's a drop in the bucket.
>>=20
>=20
> I looked into this at one point. I forget why I didn't like it. I had
> some notion that I should replace this one too, but forget exactly why.
> Maybe it wasn't that bad, if I've forgotten.
>=20
>>> Also, due to the nature of JSON as being a single discrete object and
>>> never a stream of objects, no existing JSON parser really supports the
>>> idea of ever seeing more than one object per buffer.
>>=20
>> That plainly sucks.
>>=20
>>> ...So I investigated writing a proper grammar for qmp-shell.
>>=20
>> Any parser must start with a proper grammar.  If it doesn't, it's a toy,
>> or a highway to madness.
>>=20
>>> Unfortunately, this basically means including the JSON grammar as a
>>> subset of the shell grammar and writing your own parser for it entirely=
.
>>=20
>> Because qmp-shell is a half-hearted wrapper: we ran out of wrapping
>> paper, so JSON sticks out left and right.
>>=20
>> Scrap and start over.
>>=20
>>> I looked into using Python's own lexer; but it's designed to lex
>>> *python*, not *json*. I got a prototype lexer working for this purpose
>>> under a grammar that I think reflects JSON, but I got that sinking
>>> feeling that it was all more trouble than it was worth, and scrapped
>>> working on it any further.
>>=20
>> Parsing JSON is pretty simple.  Data point: QAPISchemaParser parses our
>> weird derivative of JSON in 239 SLOC.
>>=20
>>> I did not find any other flex/yacc-like tools that seemed properly
>>> idiomatic or otherwise heavily specialized. I gave up on the idea of
>>> writing a new parser.
>>=20
>> While I recommend use of tools for parsing non-trivial grammars (you'll
>> screw up, they won't), they're massive overkill for JSON.
>>=20
>>> I'd love to offer a nice robust QMP shell that is available for use by
>>> end users, but the syntax of the shell will need some major considerati=
ons.
>>=20
>> Scrap and start over.
>>=20
>> [...]
>>=20
>=20
> Yes, I agree: Scrap and start over.
>=20
> What SHOULD the syntax look like, though? Clearly the idea of qmp-shell
> is that it offers a convenient way to enter the top-level keys of the
> arguments dict. This works absolutely fine right up until you need to
> start providing nested definitions.

Well, if you are really ready to start from scratch, I might offer the XL s=
yntax
as a starting point for a discussion of a user-visible syntax that is also
applicable for text-based or binary API exchanges.

I=E2=80=99m going to talk about it at FOSDEM in the =E2=80=9Cminimalist lan=
guages=E2=80=9D design.
Those who are in Brussels might want to attend to get a better feel.
Source code is here: https://github.com/c3d/xl, but the only part you
care about for this discussion is src/{parser,scanner}.{c,h} and the
syntax configuration file src/xl.syntax. As well as renderer styles
src/xl.stylesheet, src/html.stylesheet, etc.

Key points for the use case considered:
- Tiny (~2000 lines of code for parser/scanner, a C and a C++ implementatio=
n)
- Fully introspectable, serializable in a cross-platform way, printable (wi=
th styles)
- Character-precise position tracking for error printing
- Parser preserves comments (for documentation generators)
- Small, if slow, interpreter in about 20K lines of code (~bash speed on so=
me tests)
  meaning we would get a =E2=80=9Cqemu scripting language=E2=80=9D with loo=
ps, tests, arithmetic, etc.

More detailed discussion at end of this mail if you think it warrants a sec=
ond look.
In any case, if it helps, I=E2=80=99d be happy to help connecting it to qem=
u=E2=80=A6

>=20
> For the nesting, we say: "Go ahead and use JSON, but you have to take
> all the spaces out."

Here, that would be A.B.C, which parses as
(infix.
 (infix.
  A
  B)
 C
)

(result of `xl -nobuiltins -parse test.xl -style debug -show`)

Also, an example given earlier:

 { 'command': 'iothread-set-poll-params',
   'data': {
       'id': 'str',
=09'*max-ns': 'uint64',
=09'*grow': 'uint64',
=09'*shrink': 'uint64'
   },
   'map-to-qom-set': 'IOThread'
 }

could be written as:

command iothread_set_poll_params
=09data
=09=09id : str
=09=09*max_ns : uint64
=09=09*grow : uint64
=09=09*shrink : uint64
=09map_to_qom_set IOThread

But if you want to keep the original syntax, it seems to parse and render p=
ractically OK:

% cat /tmp/a.xl=20
{ 'command': 'iothread-set-poll-params',
   'data': {
       'id': 'str',
        '*max-ns': 'uint64',
        '*grow': 'uint64',
        '*shrink': 'uint64'
   },
   'map-to-qom-set': 'IOThread'
 }

%xl -nobuiltins -parse /tmp/a.xl  -show           =20
{ 'command':'iothread-set-poll-params', 'data': { 'id':'str',=20
    '*max-ns':'uint64', '*grow':'uint64', '*shrink':'uint64'
}, 'map-to-qom-set':'IOThread' }

This is with no change to the XL parser / scanner code
whatsoever, not even to the syntax file. So that gives me hope
that we could have a =E2=80=9Creasonably good=E2=80=9D compatibility mode
that transforms the quasi-JSON format into the new form,
with a single parser accepting both.

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

The XL proposal here would be to have a single format shared by
- The source definitions used to generate C code
- The monitor / internal shell syntax
- The command-line syntax
- The API data (possibly in serialized form for compactness)

>=20
> Do we still have a general-case problem of how to represent QAPI
> structures in plaintext? Will this need to be solved for the CLI, too?
>=20
> --js

More info below.

Here are some aspects that I think are interesting about it:

- Tiny (2000 lines of code for scanner and parser, ~20K for a full interpre=
ter)
C:  wc parser.c parser.h scanner.c scanner.h=20
     716    2183   26702 parser.c
     100     440    3372 parser.h
     926    2966   30537 scanner.c
     206     945    8249 scanner.h
    1948    6534   68860 total

C++:
     726    2372   26918 parser.cpp
     885    2480   26363 scanner.cpp
     248    1025    8867 ../include/scanner.h
     166     687    5958 ../include/parser.h
    2025    6564   68106 total

- Simple (parse tree with 8 node types, integer, real, name/symbol, text, i=
nfix, prefix, postfix and block)

=09+ integer, e.g. 12, 1_000_000 or 16#33A or 2#10101
=09+ real, e.g. 11.3, 16#1.FFF#e-3, 2#1.01
=09+ text, e.g. =E2=80=9CABC=E2=80=9D, =E2=80=98ABC=E2=80=99, <<Long text, =
multi-lines>> (configurable separators)
=09+ name/symbols, a.g. Foo_Bar, +, <=3D, (precedence and spelling configur=
able)

=09+ infix, e.g. A+B, A and B
=09+ prefix, e.g. +3, sin X
=09+ postfix, e.g. 3%, 3 km
=09+ block, e.g. [A], (A), {A} and indentation blocks

- Fully introspectable (mostly because the parse tree is simple)
- Reversible, i.e. can be printed, including with formatting, e.g.:
=09% xl -nobuiltins -parse demo/1-hello.xl -show
=09tell "localhost=E2=80=9D,=20
=09    print "Hello World=E2=80=9D
=09% xl -nobuiltins -parse demo/1-hello.xl -style debug -show  =20
=09(prefix
=09 tell
=09 (infix,
=09  =E2=80=9Clocalhost"
=09  (block indent
=09   (prefix
=09    print
=09    "Hello World=E2=80=9D
=09   ))))
- Also has a binary serializer that produces a platform-independent format
- Has multiple implementations, notably C and C++ implementation (and even =
one in XL :-)
- Validated on thousands of lines of input, with various language styles (e=
.g. Ada-like or functional)
- Character-level position tracking for error messages in scripts / config =
files:
=09/tmp/xl.xl:1007:8: Mismatched identation, expected =E2=80=9C)"
=09/tmp/xl.xl:2409:23: Mismatched identation, expected ""
- Designed to be easy to read and write
- Powerful enough to parse itself (https://github.com/c3d/xl/blob/master/xl=
2/native/xl.parser.xl)
- Dynamically configurable syntax (spelling and precedence of operators)
- Multi-line text with configurable separators, e.g. the following can be m=
ade a text constant by having XML and END_XML as text separators:
     XML
         <stuff>
            Insert your XML here
        </stuff>=20
    END_XML
- Based-numbers in any base, e.g. 8#777, 16#FFFF_FFFF and 2#1.001 as valid =
numbers
- Has essentially a single contributor (me), so easy to relicense as needed
- There is an interpreter, e.g. potential evaluate expressions like 2+3*A
- Relatively fast (6.1s to parse 1M lines of code representing 40M of code,=
 cpp ~1s)
% wc /tmp/tmp.xl
 1000000 3893922 41679700 /tmp/tmp.xl
% time xl -parse /tmp/tmp.xl
 6.10s user 0.21s system 99% cpu 6.346 total
- Support multiple styles, e.g. using { } for blocks or indentation, parent=
heses or not, etc.

Cons (but I=E2=80=99m not the better person to come up with cons on this pe=
t project of mine ;-):
- Idiosyncratic
- Single contributor
- Not well maintained
- Definitely not production quality (even the makefiles are broken ;-)
- Has some CI testing, but it fails, and it=E2=80=99s totally insufficient
- Interpreter far from perfect
- Designed with another purpose in mind (a programming language)
- Syntax is not C-centric, e.g. 16#FFFF instead of 0xFFFF.
- Name syntax does not allow -, i.e. max-ns is =E2=80=9Cmax minus ns=E2=80=
=9D, max_ns OK.
- [insert probably about a thousand others here]

Precedences and other stuff can be configured dynamically, through a file
in the current implementations, eg. https://github.com/c3d/xl-c/blob/master=
/xl.syntax.
So that means we can have a =E2=80=9Cnice=E2=80=9D syntax for the commands =
and objects,
and a format that can serve both as a config file format, as a command
language, and as a full shell-style language with if, loops, etc.

It also supports nested syntaxes, i.e. dynamic changes of precedence
between selected separators. Used to support simplified C syntax
with =E2=80=9Cextern int foo();=E2=80=9D, where the =E2=80=9CC=E2=80=9D syn=
tax is active between =E2=80=9Cextern=E2=80=9D
and =E2=80=9C;=E2=80=9D. Could be useful for compatibility.

Parse tree is simple enough that it=E2=80=99s fully introspectable.

There is a (configurable) renderer, so you can generate source from the
internal data structure. The renderer can generate colorized source
code in HTML, so I guess we could generate C data structures relatively
easily.

I believe that it is relatively trivial to configure the parser syntax file=
=20
to accept the QEMU quasi-JSON. (some code changes required to teach
it to totally ignore whitespace, toi avoid error messages).

More complete documentation about the language is here:
https://c3d.github.io/xl, but it=E2=80=99s quite light on implementation de=
tails.
So read only if you have a bit of time.



