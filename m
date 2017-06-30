Received: from eggs.gnu.org ([2001:4830:134:3::10]:36386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQx9i-0003k9-Oa
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQx9h-0004jO-Hc
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:44:22 -0400
References: <20170628142137.7440-1-eblake@redhat.com>
	<a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <783fd421-5d3a-bddf-8470-f0f77315722b@redhat.com>
Date: Fri, 30 Jun 2017 09:44:06 -0500
MIME-Version: 1.0
In-Reply-To: <a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kWF4Q3djcNO3hIJMq40POgawXVChUP6iQ"
Subject: Re: [Qemu-devel] [PATCH] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kWF4Q3djcNO3hIJMq40POgawXVChUP6iQ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Jiri Pirko <jiri@resnulli.us>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <783fd421-5d3a-bddf-8470-f0f77315722b@redhat.com>
Subject: Re: [PATCH] tests: Avoid non-portable 'echo -ARG'
References: <20170628142137.7440-1-eblake@redhat.com>
 <a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
In-Reply-To: <a83183bc-464c-dd5b-aff9-fff07bde833c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 09:38 AM, Max Reitz wrote:
> On 2017-06-28 16:21, Eric Blake wrote:
>> POSIX says that backslashes in the arguments to 'echo', as well as
>> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
>> people should favor 'printf' instead.  This is definitely true where
>> we do not control which shell is running (such as in makefile snippets=

>> or in documentation examples).  But even for scripts where we
>> require bash (and therefore, where echo does what we want by default),=

>> it is still possible to use 'shopt -s xpg_echo' to change bash's
>> behavior of echo.  And setting a good example never hurts when we are
>> not sure if a snippet will be copied from a bash-only script to a
>> general shell script (although I don't change the use of non-portable
>> \e for ESC when we know the running shell is bash).
>>
>> Replace 'echo -n "..."' with 'printf "..."', and 'echo -e "..."'
>> with 'printf "...\n"'.
>>
>> In the qemu-iotests check script, also fix unusual shell quoting
>> that would result in word-splitting if 'date' outputs a space.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

> Question 1: Who's going to take this? :-)

It's test-related, touching mostly iotests. But it's also a candidate
for qemu-trivial (I'll cc them on v2).

>=20
> Question 2: This breaks 171 if TEST_DIR contains a % (e.g.
> "TEST_DIR=3D/tmp/foo%% ./check -raw 171"). Is that OK?

No.  A more formal fix is using 'printf %s "..."' in place of 'echo -n
"..."', if the "..." contains any substitutions.  The extra %s is not
needed when there are no risky substitutions.  I'll spin up a v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kWF4Q3djcNO3hIJMq40POgawXVChUP6iQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVmO2AAoJEKeha0olJ0NqymoH/Rtko7kP8d8v659/90Kr73oj
ZXgzG4o3ese0fOCcIDze7bIoP+XQvBWPmk+tq/UKUHOFRUuHsQqIiIsuFbR0Vwrk
tbcR3UZ2UMBkiiWcDWHYmVHGJCHVqo3C0F77RheIgxz7V8f+xG/B6ZYmidlTDWCG
ZInIdGNvA50Gpr2tojBZnd9jPk8nvRaMA2ndCjDXhmW0NG5loGDLeyOS/2HlDQEs
8NlooA7I9k4h7fLEh3Mr8qiR7VKZjd4ejcfDz1T2QDEfxTmFiviNpTJeDpYK8N4/
FKuvzfXx9A58vk3sJXs20ejQv13hmlZKqOFF6QKwIBNCZBq3WR9MgF/EBd3N1tY=
=xCLz
-----END PGP SIGNATURE-----

--kWF4Q3djcNO3hIJMq40POgawXVChUP6iQ--
