Received: from eggs.gnu.org ([2001:4830:134:3::10]:52641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1eCAEH-000466-84
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1eCAEE-00054B-2l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:12:13 -0500
Date: Tue, 7 Nov 2017 22:11:11 +0200
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20171107201111.2fgkbjc7ktpiyhy5@postretch>
References: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
	<w5160b3k4c0.fsf@maestria.local.igalia.com>
	<20171103142633.GO5078@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6lkhw2zsaqhlzlz"
Content-Disposition: inline
In-Reply-To: <20171103142633.GO5078@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] throttle: fix a qemu crash
 problem when calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alberto Garcia <berto@igalia.com>, sochin jiang <sochin.jiang@huawei.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org


--m6lkhw2zsaqhlzlz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 02:26:33PM +0000, Stefan Hajnoczi wrote:
>On Wed, Oct 25, 2017 at 10:40:47AM +0200, Alberto Garcia wrote:
>> On Tue 24 Oct 2017 05:33:51 AM CEST, sochin jiang wrote:
>> > --- a/block/throttle-groups.c
>> > +++ b/block/throttle-groups.c
>> > @@ -576,7 +576,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMe=
mber *tgm)
>> >
>> >      /* remove the current tgm from the list */
>> >      QLIST_REMOVE(tgm, round_robin);
>> > -    throttle_timers_destroy(&tgm->throttle_timers);
>> > +    if (throttle_timers_are_initialized(&tgm->throttle_timers)) {
>> > +        throttle_timers_destroy(&tgm->throttle_timers);
>> > +    }
>> >      qemu_mutex_unlock(&tg->lock);
>> >
>> >      throttle_group_unref(&tg->ts);
>>
>> I don't know what the rest of the people think, but I'm not completely
>> convinced that it's a good idea to have an active ThrottleState inside a
>> ThrottleGroupMember without timers.
>>
>> Perhaps in blk_remove_bs() after detaching the AioContext from the BDS
>> we can attach the default one (what you would get with
>> blk_get_aio_context()).
>>
>> On the other hand I think that Manos's series to remove the legacy
>> throttling code gets rid of BlockBackend.ThrottleGroupMember completely.
>
>What is the status of Manos' series?
>
>It would be good to merge it and then consider currently open throttling
>bugs again.
>

I have been busy with schoolwork the past weeks, but I'm close to=20
finishing some changes Kevin recommended for this series. I hope they=20
will be ready soon.

--m6lkhw2zsaqhlzlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAloCE18ACgkQc2J8L2kN
9xDWmxAArt7acokctqvu9PjvNSX/2w4KKmlmcFVgp6Q8JfJDwTfUoeUXaraVDgoA
xjHVoU89dWdgfFQ41nPm6dKwQ72+2p4T+HRa4uR1DA/ZtkvX0VKopSFjYUVMyR8R
ZpXQ/rWmlIc5f9gLhovqbjFCS3a68aNQVADI8iIBQij3Cw29m1j9JbOom7LPYbdL
P1aiBphERffiYc000HAty8oPaO6cwZtbwc+nhLuWYhiJOgQgtXVEwc2H3/MpLk1k
cgicLZa5j4Ngqog32mV646KkV5IZGoNdg4ciXpCjCV90ogySI6t8BoHVXKUBHeHb
LWRDdpJL4t+GWkklOv8hQq22JRnttOKbMR5Sv4gV1wLrHL/94ZPQ/D3RldxtVsRB
WxRvpmSBYEODzaiRn/j/8eoLr9QA2tfg8lq2YiqMv8goiuNb2+zoKqwG1xwTU2KN
xv+AAtKIzkSJczH34g62nDl2ejzgysXWq6btPFGH5MuMPWY3T8vbtnvxVY1dj1ep
vHyWYjm2qu3WgBgYoHWFdTvDvtt8VaA7VP+0Dhgfq3RUXtaoOd0QddFHj0RWACqu
iDQTlsklf+74XfmQuWVfQv3sL21iQn7AzLIrbEcXcYsvK+rbHH/CMbcPdSdHlSrf
vpAM7u4z/lzqcBYfEEECtSh8liElwUMcjAPd7DqDVfvzkr8+FRE=
=ZMss
-----END PGP SIGNATURE-----

--m6lkhw2zsaqhlzlz--
