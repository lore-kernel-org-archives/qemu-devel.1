Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6FF-00022g-2q
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6FC-0002a2-0g
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:42:09 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55584)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr6FB-0002Zs-LY
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:42:05 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
	<150471928780.24907.14047559834166839201.stgit@frigg.lan>
	<20170906212056.GC25558@flamenco>
Date: Sun, 10 Sep 2017 20:41:56 +0300
In-Reply-To: <20170906212056.GC25558@flamenco> (Emilio G. Cota's message of
	"Wed, 6 Sep 2017 17:20:56 -0400")
Message-ID: <87fubuzc0r.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/20] instrument: Add generic library
 loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Emilio G Cota writes:

> On Wed, Sep 06, 2017 at 20:34:48 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
> (snip)
>> diff --git a/configure b/configure
>> index 80dcc91c98..05bd7b1950 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6034,6 +6034,8 @@ fi
>> echo "CONFIG_TRACE_FILE=3D$trace_file" >> $config_host_mak
>>=20
>> if test "$instrument" =3D "yes"; then
>> +  LDFLAGS=3D"-rdynamic $LDFLAGS"          # limit symbols available to =
clients

> -rdynamic exports all objects to the instrumenters, not the other way aro=
und.
> You can see it with nm(1).

I'll send a minor fix for this in next version.


> BTW I'm using ebf447b5b from your qemu-dbi repo. Is that the same as this
> patchset? It doesn't compile with --enable-instrument:
> $ make
>   CC      x86_64-linux-user/instrument/trace.o
> /data/src/qemu2/instrument/trace.c:12:30: fatal error: qemu-instr/trace.h=
: No such file or directory
> compilation terminated.
> /data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' fail=
ed
> make[1]: *** [instrument/trace.o] Error 1
> Makefile:326: recipe for target 'subdir-x86_64-linux-user' failed
> make: *** [subdir-x86_64-linux-user] Error 2

No, I started using a separate branch to keep the old patches around in the
meantime.


> 		Emilio


Lluis
