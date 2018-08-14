Received: from eggs.gnu.org ([2001:4830:134:3::10]:34454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpebP-0006lK-5Q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpebL-0000XM-SI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:03:35 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpebL-0000Wx-G6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:03:31 -0400
Date: Tue, 14 Aug 2018 21:03:29 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180814190329.GA13798@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm>
	<20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-8135-1534273409-0001-2"
Content-Disposition: inline
In-Reply-To: <871sb1t0cn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-8135-1534273409-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 05:49:12PM +0200, Markus Armbruster wrote:
>> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>>> --- a/hmp-commands.hx
>>>> +++ b/hmp-commands.hx
>
> Subject claims "qmp: add", but the patch also adds to hmp.  Recommend to
> split the patch into QMP and HMP part.

Hello,

Sure, I can do that.

>> qapi/misc.json seems to always use 'int' for integer types. Is
>> this value large enough on 64-bit architectures?
>
> Yes.  QAPI's int translates to int64_t.

Thanks.

>> Just curious, what is the difference between 's' and 'F'. Is that
>> only for documentation purposes (and maybe tab completion) or is
>> the usage different? I noticed existing code uses qdict_get_str()
>> for both 's' and 'F'.
>
> The main behavioral difference is completion.

Good to know, thanks.

> I recommend to start with the QMP interface.  Parameters are unordered
> there.  memsave and pmemsave both take mandatory @val, @size, @filename.
> memsave additionally takes optional @cpu-index.

Yes.

> Your pmemload has pmemsave's arguments plus and mandatory @offset.
> Rationale for adding @offset?  You may have answered this question
> already; pointer to that answer would be fine.

My initial patch didn't have the offset. It was suggested by Eric
Blake in <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>:

On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
> Do you additionally need an offset where to start reading from within
> the file (that is, since you already have the 'size' parameter to avoid
> reading the entire file, and the 'val' parameter to target anywhere in
> physical memory, how do I start reading anywhere from the file)?

It sounded useful to me so I added it.

> Once we got the QMP interface nailed down, we can move to the HMP
> interface.

Good point.

> These two should become a separate bug fix patch.  The bug being fixed
> is completion.

Sure, they are in separate patches. Just wanted to show the
general changes I applied from the reviews.

Thanks for the review.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-8135-1534273409-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAltzJ3cACgkQkv79t+RM
MvngnA/+IoeMKn+wqHEFWmgiDvsmIPgPpIFBw59rOiicqg6Sch25LQ6vU6ordEgu
gKtxb+5BQ8NAUtqKo8zdhZGcZ79FxQ1Bo9npg/ZFN6wkEKICyrhmKrd9QWDC+JBk
8+7AMEZ8Q2+VbJ+zr8xt2go+v/Mxjnkf3h2jQzGN6xYm6YR6e0aKgPBXcOBCdwq5
LiDFmyUcW5d0e2xjTAWGBoQNBYBBHAbkZsIUSKL5jBALwBhtgXXUza+aYCZML+AN
6Aj76vlDvuGr/qoiksE8s0xrFnIGFebsVDvSNXX9xNwIq66hE+FT9C0ojJSJo6ci
VJSvpG3/3ru52vXgCRihHb9VGpKvOnNGuenC3oNfTCEqk2SHwWSWnaseMpb191yn
H8U6OfXNH6uH7ZP18yXTIf+sCH+pD8Gy9aVumvtN1N2XxbdH40AS9xhmzXUJncMx
FKASH+GEBNMy0fgHadz/nalYYFyM4vIkgzOl+6EdikVYyz0GRhzhUKiY+razUc+R
e/31T3gY+bWipQcb15OBc87c3laz13oepnsnVSYnZ+hT6wrJKbe+Cx7msj4MrttC
gQmnBJyeK/vgyH22A7eFarYPzyGrUkML4DgpfhcPhZmZzqSYKE2Gf1AbSDCnIqwQ
yE/UnqXIyAdXA1Wxt4NfQa7ie4u+nu6Xteq89+tSeCTFW77XwR4=
=tIRT
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-8135-1534273409-0001-2--
