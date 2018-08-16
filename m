Received: from eggs.gnu.org ([2001:4830:134:3::10]:45693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqDPK-0004jK-Bn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqDPG-0003gm-Cl
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:13:26 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:51361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqDPG-0003gH-3v
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:13:22 -0400
Date: Thu, 16 Aug 2018 10:13:20 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180816081320.GA16148@ruderich.org>
References: <851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm>
	<20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
	<87bma3ityy.fsf@dusky.pond.sub.org>
	<20180815154626.GA23638@ruderich.org>
	<87pnyig92q.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-29738-1534407200-0001-2"
Content-Disposition: inline
In-Reply-To: <87pnyig92q.fsf@dusky.pond.sub.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-29738-1534407200-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 07:43:41AM +0200, Markus Armbruster wrote:
>> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>> Also, had you considered rearranging and making them optional,
>>> for example if you do:
>>>
>>> val:l,filename:F,offset:i?,size:i?
>>>
>>> I think that would mean you can do the fairly obvious:
>>>   pmemload addr "myfile"
>>>
>>> with the assumption that loads the whole file.
>>
>> This would deviate from pmemsave/memsave, but feels more natural.
>
> The different order or arguments in HMP is somewhat ugly.  Okay if it
> makes the command more pleasant to use.  Up to you and Dave to decide.
>
> If you decide to deviate, consider
>
>     filename:F,address:l,size:i?,offset:i?

=46rom what I understand we can't have optional arguments in the
middle. Would you prefer mandatory size/offset parameters in HMP
or optional parameters but inconsistent with pmemsave/memsave?
Both works for me.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-29738-1534407200-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlt1MhsACgkQkv79t+RM
MvlPkA/+PTLB6N9uGAA5fpYQ4It6GIvU6M0zHHTTxHJCqJuyH1P3bKwjneQ0f1hh
ha51IGtP2uxfIftHETxv1XiU2XC0J0LeClKf2zGqvsjwWWdtGgwk8lNdRHbPoW4L
wrDsrVScDsB0ObqzBLPKad/eai8OjCsDJhtyMpUH176b+kT5Dnhh24q8JZB+U8yE
YY2+MLEI8jiBmjOgVNycquTJHCcTuicFO7Rakdwb22V++vPc5XvwvxmFqmMu6gZg
DjUHfcnLcQIMl5+LHNwOkMh1egaY/rxtHLGgC5i69VL7iKTjsKQfgQAS6wfSBxz4
tP1JtEvobuMWYZidDi0iwyjUjxmMgPKdNGiMKcfTdHF3g2IKgHymb3PTjkKMNj9L
syXHvllhySya/V0ELAZreqwNKBxlm0v1gkigHJLVhNbjRpy8/2ZvBBrYZeaAUqQG
j2uoeBickqj+miILk46LMQswHyWj36rv0joXiqKMZjsTgSKP+G/RF42zejT46LXO
IZg8IbiWCsIjtJ3VKx1pn8scUZQWNfWil9EudxruXtQ89e98GECQ7o25Qgpt8w5/
Z+NozNX46EjYr7ZZrdvdFqNA+F5CiZK2aYi3BkUmS6phR3XHnHHV5u2uxtxBK7OG
KwLai6BnE0hyohUcbCoJaHBgycnRExD+WZ1fNgvP2LMOSCgZ8Eg=
=4fOk
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-29738-1534407200-0001-2--
