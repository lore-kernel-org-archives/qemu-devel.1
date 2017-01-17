Received: from eggs.gnu.org ([2001:4830:134:3::10]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTQlJ-0005cc-9A
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTQlF-0004Ah-6v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:13:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cTQlE-0004A2-VK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:13:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAJ+F1C+okVYu7pvZzGVdC-Y5CeA0OLhCO5jU7TDLK8nUtm6R=w@mail.gmail.com>
Date: Tue, 17 Jan 2017 11:13:02 +0100
In-Reply-To: <CAJ+F1C+okVYu7pvZzGVdC-Y5CeA0OLhCO5jU7TDLK8nUtm6R=w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 17 Jan 2017
	09:54:36 +0000")
Message-ID: <8760lec7v5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jan 17, 2017 at 12:34 PM Markus Armbruster <armbru@redhat.com>
> wrote:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On 16 January 2017 at 09:33, Markus Armbruster <armbru@redhat.com>
>> wrote:
>> >> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
>> >> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
>> >> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
>> >>
>> >> We did all the respins with in this squashed form to reduce noise.
>> >> However, since the unsquashed form is better suited for review, and
>> >> probably nicer if we have to revisit this part of the work down the
>> >> road, I'm proposing to merge this unsquashed.
>> >>
>> >> If you want me to post the unsquashed patches, I'm happy to redo this
>> >> pull request.
>> >>
>> >> If you'd rather pull the squashed version, likewise.
>> >>
>> >> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
>> >> get it in, the easier for Marc-Andr=C3=A9 and me.
>> >>
>> >> v2:
>> >> * Rebased (v1 conflicts with commit e1ff3c6)
>> >> * test-qapi.py tweaked to avoid trailing empty lines in .out
>> >>
>> >> The following changes since commit
>> b6af8ea60282df514f87d32e36afd1c9aeee28c8:
>> >>
>> >>   Merge remote-tracking branch
>> 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging
>> (2017-01-13 14:38:21 +0000)
>> >>
>> >> are available in the git repository at:
>> >>
>> >>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-16
>> >>
>> >> for you to fetch changes up to 56e8bdd46a8a42d89b0afea9da83ae7679cc04=
39:
>> >>
>> >>   build-sys: add qapi doc generation targets (2017-01-16 10:11:43 +01=
00)
>> >>
>> >> ----------------------------------------------------------------
>> >> QAPI patches for 2017-01-16
>> >
>> > This seems to trigger some warnings from older makeinfo versions:
>> >
>> > On the Fedora 20 ppc64be box and Ubuntu 14.04.5 LTS aarch64 box
>> > (Ubuntu: makeinfo (GNU texinfo) 5.2;
>> >  Fedora: makeinfo (GNU texinfo) 5.1)
>>
>> Nobody should be using F20 by now, but the Ubuntu LTS is still legit.
>>
>> > /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VE=
RSION
>> > /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VE=
RSION
>> > /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: V=
ERSION
>> > /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: V=
ERSION
>>
>> This is supposed to be defined in Makefile:
>>
>>     MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
>>
>> Hrrm, Texinfo's NEWS file has for 6.0:
>>
>> * texi2any:
>>   [...]
>>   . -D'var val' on the command line works as intended again.
>>
>> I tried to find out more about this fix, but the Texinfo repository's
>> commit log is useless.
>>
>> I can reproduce the warning with 6.2 by running makeinfo without -D.
>> Curiously, output isn't affected.  Looks like @subtitle is ignored by
>> makeinfo.
>>
>> Possible work-around I could squash in:
>>
>> diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
>> index 818e525..e0f2454 100644
>> --- a/docs/qemu-qmp-ref.texi
>> +++ b/docs/qemu-qmp-ref.texi
>> @@ -38,7 +38,9 @@ along with this manual.  If not, see
>> http://www.gnu.org/licens
>> es/ <http://www.gnu.org/licenses/>.
>>
>>  @titlepage
>>  @title QMP Reference Manual
>> +@iftex @c Work around bug in Texinfo prior to 6.0
>>  @subtitle QEMU version @value{VERSION}
>> +@end iftex
>>  @page
>>  @vskip 0pt plus 1filll
>>  @insertcopying
>>
>> Marc-Andr=C3=A9, what do you think?
>>
>
> Since title @subtitle is being ignored by makeinfo, that looks fine.
> However, I think I would prefer rather have the warning since it's a
> makeinfo bug on old versions and it can be ignored. Hopefully, this thread
> can easily be found for reference (update commit message too?). Either wa=
y,
> I don't mind. Thanks

My proposed work-around suppresses the warning we get from old versions
of makeinfo, but might degrade the title page with future versions of
makeinfo.

Peter, what's your preference?
