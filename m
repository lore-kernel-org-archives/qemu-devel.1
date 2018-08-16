Received: from eggs.gnu.org ([2001:4830:134:3::10]:50836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqDnR-0001dC-0e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqDnK-0005nW-IZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:38:18 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:54493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqDnK-0005ms-9W
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:38:14 -0400
Date: Thu, 16 Aug 2018 10:38:12 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180816083812.GA22830@ruderich.org>
References: <20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
	<87bma3ityy.fsf@dusky.pond.sub.org>
	<20180815154626.GA23638@ruderich.org>
	<87pnyig92q.fsf@dusky.pond.sub.org>
	<20180816081320.GA16148@ruderich.org>
	<87h8jud8et.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-10518-1534408692-0001-2"
Content-Disposition: inline
In-Reply-To: <87h8jud8et.fsf@dusky.pond.sub.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-10518-1534408692-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 10:26:18AM +0200, Markus Armbruster wrote:
>> On Thu, Aug 16, 2018 at 07:43:41AM +0200, Markus Armbruster wrote:
>>>> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>>>> Also, had you considered rearranging and making them optional,
>>>>> for example if you do:
>>>>>
>>>>> val:l,filename:F,offset:i?,size:i?
>>>>>
>>>>> I think that would mean you can do the fairly obvious:
>>>>>   pmemload addr "myfile"
>>>>>
>>>>> with the assumption that loads the whole file.
>>>>
>>>> This would deviate from pmemsave/memsave, but feels more natural.
>>>
>>> The different order or arguments in HMP is somewhat ugly.  Okay if it
>>> makes the command more pleasant to use.  Up to you and Dave to decide.
>>>
>>> If you decide to deviate, consider
>>>
>>>     filename:F,address:l,size:i?,offset:i?
>>
>> From what I understand we can't have optional arguments in the
>> middle. Would you prefer mandatory size/offset parameters in HMP
>> or optional parameters but inconsistent with pmemsave/memsave?
>
> If you guys decide you want consistency with memsave, that's fine with
> me.  If you decide you want to rearrange arguments for better usability,
> that's also fine.  I just wanted to throw in another rearrangement for
> you to consider.

Thanks for your suggestions. Then I'll go with
"val:l,size:l,offset:l,filename:F" for now. I'll send the revised
patch series soon.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-10518-1534408692-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlt1N/AACgkQkv79t+RM
MvlG+g/9Eb8lM1I8xAFy5vY1yDmkZSRu3fEWGCvbyId0+AYFwzsFhcCNdFwb8LLf
5oOo4n5STdKOoGdbxA0/0ldKVoTwqvGzNx9u8cW4MPxrFl4Me3vwJajQrMoZdvOx
etU0Wp8sYz+W3mMuSzuJ37FzVqiHOBE61uS7CocSDoGnQOk1agU6RuZG1MjDfE85
YnUXXw8FqsI5B1hUmIzkvhD4GEUDfPNM27rgmDmMMmo2JhD51fci/vDwfuTRoPGH
wwdhnvT340BmetEUpSnupvPRR5hsoNOISP0+R04qTuq6IcXxEfoVp/rosl7gcRkr
gnKmLiEdhuXyldGfo9O/GpPbHu6bpg7qLLgyXTwq6fjC6yVEIvLjS0KcZOSrYuaP
pHBdTE/a+MbhlbpDlsTcTF3te9KYFyGxpc+GOyhqQXfAG8Qb+Y2bUUzRs19lOdEc
as89/syRHM1m6UKEpME0amNmvAkn6UZRYxerlFbdUtBfxnAgM0QO8zk7rMSl9vyM
VgKvFlXa1h5SlUBv/814hil9ozo8xXuseSvk1OCjBACu7MPXsux7sEiZ8rzCoqwe
45g3xd7HTcA33D5M5u0zARKlw5tbgo34SDsCtu9Bn2bAvkymog0Q+rI8p/xp4+v3
RjQ3QAIoSIYfGyzyR3RYMfkxhhESjWfnlzy+qe+Yoey1fppjsnI=
=h0NS
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-10518-1534408692-0001-2--
