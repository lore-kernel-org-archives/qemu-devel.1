Received: from eggs.gnu.org ([2001:4830:134:3::10]:48815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEejK-0003nl-9H
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEejG-0006wP-51
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cEejF-0006wB-S1
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:05:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20161117155504.21843-1-marcandre.lureau@redhat.com>
	<20161117155504.21843-14-marcandre.lureau@redhat.com>
	<87twapdkb5.fsf@dusky.pond.sub.org>
	<CAJ+F1CLjozGuqXARb-W8CjmJY64JFAgWogAL_HnnyhUgJwf5VQ@mail.gmail.com>
	<87vauxmg43.fsf@dusky.pond.sub.org>
	<CAJ+F1CKsiH1Mc+kd7yqtQNe_38W_COukdg=M26uX1Do1MXmXOw@mail.gmail.com>
Date: Wed, 07 Dec 2016 17:05:54 +0100
In-Reply-To: <CAJ+F1CKsiH1Mc+kd7yqtQNe_38W_COukdg=M26uX1Do1MXmXOw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 06 Dec 2016
	13:07:24 +0000")
Message-ID: <8760mvhggt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/17] qapi: add qapi2texi script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Dec 6, 2016 at 2:50 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
>> I had to resort to diff to find your replies, and massage the text
>> manually to produce a readable reply myself.  Please quote the usual
>> way.
>>
>>
> I'd have to switch to something else than gmail (which bothers me for
> various reasons, let's not discuss the merits of various mail clients
> please ;) In general, I don't have problems, but this mail is rather big,
> sorry for the inconvenience..

This time, it was only a bit of mojibake and lots of unwanted line wraps
%-)

I'll try to cut unnecessary quoted material this time.

>> Markus Armbruster <armbru@redhat.com> writes:
>> >
>> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> > >
>> > >> As the name suggests, the qapi2texi script converts JSON QAPI
>> > >> description into a texi file suitable for different target
>> > >> formats (info/man/txt/pdf/html...).
[...]
>> > > Missing: a brief discussion of deficiencies.  These include:
>> > >
>> > > * The generated QMP documentation includes internal types
>> > >
>> > >   We use qapi-schema.json both for defining the external QMP interfa=
ce
>> > >   and for defining internal types.  qmp-introspect.py carefully
>> > >   separates the two, to not expose internal types.  qapi2texi.py hap=
pily
>> > >   exposes everything.
>> > >
>> > >   Currently, about a fifth of the types in the generated docs are
>> > >   internal:
>> > >
>> > >       AcpiTableOptions
>> > >       BiosAtaTranslation
>> > >       BlockDeviceMapEntry
>> > >       COLOMessage
>> > >       COLOMode
>> > >       DummyForceArrays
>> > >       FailoverStatus
>> > >       FloppyDriveType
>> > >       ImageCheck
>> > >       LostTickPolicy
>> > >       MapEntry
>> > >       MigrationParameter
>> > >       NetClientDriver
>> > >       NetFilterDirection
>> > >       NetLegacy
>> > >       NetLegacyNicOptions
>> > >       NetLegacyOptions
>> > >       NetLegacyOptionsKind
>> > >       Netdev
4>> > >       NetdevBridgeOptions
>> > >       NetdevDumpOptions
>> > >       NetdevHubPortOptions
>> > >       NetdevL2TPv3Options
>> > >       NetdevNetmapOptions
>> > >       NetdevNoneOptions
>> > >       NetdevSocketOptions
>> > >       NetdevTapOptions
>> > >       NetdevUserOptions
>> > >       NetdevVdeOptions
>> > >       NetdevVhostUserOptions
>> > >       NumaNodeOptions
>> > >       NumaOptions
>> > >       NumaOptionsKind
>> > >       OnOffAuto
>> > >       OnOffSplit
>> > >       PreallocMode
>> > >       QCryptoBlockCreateOptions
>> > >       QCryptoBlockCreateOptionsLUKS
>> > >       QCryptoBlockFormat
>> > >       QCryptoBlockInfo
>> > >       QCryptoBlockInfoBase
>> > >       QCryptoBlockInfoQCow
>> > >       QCryptoBlockOpenOptions
>> > >       QCryptoBlockOptionsBase
>> > >       QCryptoBlockOptionsLUKS
>> > >       QCryptoBlockOptionsQCow
>> > >       QCryptoSecretFormat
>> > >       QCryptoTLSCredsEndpoint
>> > >       QapiErrorClass
>> > >       ReplayMode
>> > >       X86CPUFeatureWordInfo
>> > >       X86CPURegister32
>> > >
>> > >   Generating documentation for internal types might be useful, but
>> > >   letting them pollute QMP interface documentation isn't.  Needs fix=
ing
>> > >   before we release.  Until then, needs a FIXME comment in qapi2texi=
.py.
>> > >
>> > > * Union support is lacking
>> > >
>> > >   The doc string language is adequate for documenting commands, even=
ts,
>> > >   and non-union types.  It doesn't really handle union variants. Har=
dly
>> > >   surprising, as you fitted the language do existing practice, and
>> > >   existing (mal-)practice is neglecting to document union variant
>> > >   members.
>> > >
>> > > * Documentation is lacking
>> > >
>> > >   See review of qapi-code-gen.txt below.
>> > >
>> > > * Doc comment error message positions are imprecise
>> > >
>> > >   They always point to the beginning of the comment.
>> > >
>> > > * Probably more
>> > >
>> > >   We should update this with noteworthy findings during review.  I
>> > >   tried, but I suspect I missed some.
>> >
>> > ok
>> >
>> > >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> > >> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> > >> index 4d1b0e4..1b456b4 100644
>> > >> --- a/scripts/qapi.py
>> > >> +++ b/scripts/qapi.py
[...]
>> > >> +    def append(self, line):
>> > >> +        """Adds a # comment line, to be parsed and added to curren=
t section"""
>> > >
>> > > Imperative mood:
>> > >
>> > >     """Add a comment line, to be parsed and added to the current sec=
tion."""
>> > >
>> > > However, we're not always adding to the current section, we can also
>> > > start a new one.  The following avoids suggesting anything about the
>> > > current section:
>> > >
>> > >     """Parse a comment line and add it to the documentation."""
>> > >
>> > > When the function name is a verb, and its doc string starts with a
>> > > different verb, the name might be suboptimal.  Use your judgement.
>> > >
>> > > If this one-liner is too terse, we can try a multi-line doc string:
>> > >
>> > >     """Parse a comment line and add it to the documentation.
>> > >
>> > >     TODO should we tell more about how we parse?
>> > >
>> > >     Args:
>> > >         line: the comment starting with '#', with the newline stripp=
ed.
>> > >
>> > >     Raises:
>> > >         QAPISchemaError: TODO explain error conditions
>> > >     """
>> > >
>> > > Format stolen from the Google Python Style Guide[2], because PEP257 =
is
>> > > of not much help there.
>> > >
>> > > Once you start with such elaborate doc strings, pressure will likely
>> > > mount to do the same elsewhere.  Could be a distraction right now.  =
Use
>> > > your judgement.
>> >
>> > ok, thanks
>> >
>> > >> +        line =3D line[1:]
>> > >> +        if not line:
>> > >> +            self._append_freeform(line)
>> > >> +            return
>> > >> +
>> > >> +        if line[0] !=3D ' ':
>> > >> +            raise QAPISchemaError(self.parser, "missing space afte=
r #")
>> > >> +        line =3D line[1:]
>> > >
>> > > QAPISchemaError takes the error position from its QAPISchemaParser
>> > > argument.  In other words, the error position depends on the state of
>> > > the parser when it calls this function.  Turns out the position is t=
he
>> > > beginning of the comment.  Servicable here.  Action at a distance,
>> > > though.
>> > >
>> > > Less strict:
>> > >
>> > >            # strip leading # and space
>> > >            line =3D line[1:]
>> > >            if line[0] =3D=3D ' ':
>> > >                line =3D line[1:]
>> > >
>> > > Also avoids special-casing empty comments.
>> >
>> > That would raise "IndexError: string index out of range" on empty comm=
ent
>> > lines ("#")
>>
>> Fixable:
>>                if line.startswith(' '):
>>
>> > Also I'd like to keep the error in case a space is missing (it caught =
some
>> > already).
>>
>> On the one hand, I share your distaste for lack of space between # and
>> comment text.  On the other hand, I dislike enforcing spacing
>> inconsistently: enforce in doc comments, but not in other comments.
>
> It's only enforced for doc comments, which I think is fair.

If it's worth enforcing for some comments (which I doubt), then why
isn't it worth enforcing for all of them?  Anyway, it's something we can
fiddle with on top.

[...]
>> > > Not fixed since v3:
>> > >
>> > > * Flat union where 'base' is a string, e.g. union UserDefFlatUnion in
>> > >   qapi-schema-test.json has base 'UserDefUnionBase', args is set(['a=
',
>> > >   'B', 'e', 'D', 'f', 'i', 'o', 'n', 's', 'r', 'U'])
>> > >
>> > > * Command where 'data' is a string, e.g. user_def_cmd0 in
>> > >   qapi-schema-test.json has data 'Empty2', args is set(['E', 'm', 'p=
',
>> > >   '2', 't', 'y'])
>> > >
>> > > * Event where 'data' is a string, no test case handy (hole in test
>> > >   coverage)
>> >
>> > ok, I changed it that way, that fixes it:
>> > +    if isinstance(data, list):
>> > +        args =3D set([name.strip('*') for name in data])
>> > +    else:
>> > +        args =3D set()
>>
>> Uh, sure this does the right thing when data is a dict?
>>
>
> yes, the line above takes care of extracting the keys in data.

Ah, I misunderstood.  First mapping dict to list of keys, then dealing
with either list or other should indeed work.

>> > >> +    if meta =3D=3D 'alternate' or \
>> > >> +       (meta =3D=3D 'union' and not expr.get('discriminator')):
>> > >> +        args.add('type')
>> > >
>> > > As explained in review of v3, this is only a subset of the real set =
of
>> > > members.  Computing the exact set is impractical when working with t=
he
>> > > abstract syntax tree.  I believe we'll eventually have to rewrite th=
is
>> > > code to work with the QAPISchemaEntity instead.
>> >
>> > I don't think we want to list all the members as this would lead to
>> > duplicated documentation. Instead it should document only the members =
of
>> > the expr being defined.
>>
>> You're sticking to established practice, which makes lots of sense.
>> However, established practice is a lot more clear for simple cases than
>> for things like members inherited from base types, variant members and
>> such.  At some point, we'll have to figure out how we want not so simple
>> cases documented.  Until then, we can't really decide how to check
>> documentation completeness.
>>
>> >                         In which case, it looks like this check is good
>> > enough, no?
>>
>> For now, yes.  Later on, maybe.
>>
>> Let's document the limitation in a comment and the commit message, and
>> move on.
>
> I'd appreciate your help to list the limitations in the commit message, as
> I have not as thorough understanding as you, and even worse I often don't
> use the same name for the various concepts.

I'll try.

Deducing concept names from code isn't always easy...

[...]
>> > >> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
>> > >> new file mode 100755
>> > >> index 0000000..0cec43a
>> > >> --- /dev/null
>> > >> +++ b/scripts/qapi2texi.py
[...]
>> > >> +def texi_union(expr, doc):
>> > >> +    """
>> > >> +    Format an union to texi
>> > >
>> > > I think it's "a union".
>> >
>> > ok
>> >
>> > >> +    """
>> > >> +    attrs =3D "@{ " + texi_args(expr, "base") + " @}"
>> > >> +    discriminator =3D expr.get("discriminator")
>> > >> +    if not discriminator:
>> > >> +        union =3D "Flat Union"
>> > >> +        discriminator =3D "type"
>> > >> +    else:
>> > >> +        union =3D "Union"
>> > >
>> > > Condition is backwards.
>> >
>> > fixed
>> >
>> > >> +    attrs +=3D " + '%s' =3D [ " % discriminator
>> > >> +    attrs +=3D texi_args(expr, "data") + " ]"
>> > >> +    body =3D texi_body(doc)
>> > >> +
>> > >> +    return STRUCT_FMT(type=3Dunion,
>> > >> +                      name=3Ddoc.symbol,
>> > >> +                      attrs=3Dattrs,
>> > >> +                      body=3Dbody)
>> > >
>> > > You're inventing syntax here.  Example output:
>> > >
>> > >  -- Union: QCryptoBlockOpenOptions { QCryptoBlockOptionsBase } +
>> > >           'format' =3D [ 'qcow': QCRYPTOBLOCKOPTIONSQCOW, 'luks':
>> > >           QCRYPTOBLOCKOPTIONSLUKS ]
>> > >
>> > >      The options that are available for all encryption formats when
>> > >      opening an existing volume
>> > >           Since: 2.6
>> > >
>> > >  -- Flat Union: ImageInfoSpecific { } + 'type' =3D [ 'qcow2':
>> > >           IMAGEINFOSPECIFICQCOW2, 'vmdk': IMAGEINFOSPECIFICVMDK, 'lu=
ks':
>> > >           QCRYPTOBLOCKINFOLUKS ]
>> > >
>> > >      A discriminated record of image format specific information
>> > >      structures.
>> > >           Since: 1.7
>> > >
>> > > Note that QCryptoBlockOpenOptions is actually a flat union, and
>> > > ImageInfoSpecific a simple union.  As I said, the condition is
>> > > backwards.
>> > >
>> > > The meaning of the attrs part is unobvious.  Familiarity with schema
>> > > syntax doesn't really help.
>> > >
>> > > Could we simply use schema syntax here?
>> >
>> > Union: QCryptoBlockOpenOptions {
>> > 'base': QCryptoBlockOptionsBase,
>> > 'discriminator': 'format',
>> > 'data':  { 'qcow': QCryptoBlockOptionsQCow, 'luks':
>> > QCryptoBlockCreateOptionsLUKS }
>> >
>> > }
>> >
>> > Doesn't look obvious either and pollute the documentation with
>> > schema-specific parameters.
>>
>> The schema syntax for flat unions is pretty horrid :)  I hope to improve
>> it, but there's more urgent fish to fry.
>>
>> > > If not: whatever format you use, you first need to explain it.
>> >
>> > I am not sure my solution is the best and will remain, but ok let's tr=
y to
>> > document it for now.
>>
>> Before you pour time into documenting what you have, we should probably
>> discuss what we need.
>>
>
> Can this be marked as limitation and improved laster? The series is big,
> patch is getting bigger over time, it's quite hard to handle all your
> requirements in one go.

I'm sure it is!

How about this: you split off the code to derive documentation from the
schema expressions into its own patch.  The initial qapi2texi patch gets
a FIXME comment instead, explaining what kind of information the
generated documentation lacks.  I think it's basically member types.
The split-off patch then resolves that FIXME.

This lets me apply the first patch.  We can then discuss how to do the
second patch better.  If you're out of time or energy on this topic (I'd
understand), you could even leave it to me.  After all, it's me who's
particular about it...

[...]
