Received: from eggs.gnu.org ([2001:4830:134:3::10]:53067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftBPu-0000hV-WF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftBPq-0003YY-8K
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:42:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-2-marcandre.lureau@redhat.com>
	<87in40b3fc.fsf@dusky.pond.sub.org>
	<CAJ+F1CLdS0V0wGjHS0eUe=VV0ExsTp+Bk09TTJn9Rm5A_DRjCg@mail.gmail.com>
	<87wosg80ic.fsf@dusky.pond.sub.org>
	<CAJ+F1CLD=sAqOhZjmED0_m5vfMGsNjM0sKgG_FJ+KucxkbbMwA@mail.gmail.com>
Date: Fri, 24 Aug 2018 14:37:05 +0200
In-Reply-To: <CAJ+F1CLD=sAqOhZjmED0_m5vfMGsNjM0sKgG_FJ+KucxkbbMwA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 24 Aug 2018
	14:15:57 +0200")
Message-ID: <8760007xfy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qdict: add qdict_steal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
> On Fri, Aug 24, 2018 at 1:30 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > On Fri, Aug 24, 2018 at 10:05 AM Markus Armbruster <armbru@redhat.com>=
 wrote:
>> >>
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
[...]
>> >> > @@ -406,6 +406,28 @@ void qdict_del(QDict *qdict, const char *key)
>> >> >      }
>> >> >  }
>> >> >
>> >> > +/**
>> >> > + * qdict_steal(): Steal a 'key:value' pair from the dictionary
>> >>
>> >> "Steal" is cute, but perhaps qdict_get_and_del() would be clearer.
>> >
>> > "steal" is common in glib. I don't mind renaming.
>>
>> Hmm.  I found g_hash_table_steal(), but it's a bit different: it
>> "Removes a key and its associated value from a GHashTable without
>> calling the key and value destroy functions" (that part seems close
>> enough), but returns a bool rather than the value.  Feels like sub-par
>> design to me.  Is this the precedence you have in mind?
>
> They are many more _steal* functions in the GNOME libraries (search
> with devhelp): the general idea is to remove an object from the owner
> (without destrying), and return that object/reference.

Alright, I don't mind calling it "steal".
