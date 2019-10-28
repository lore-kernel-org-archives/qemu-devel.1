Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 00:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13AB20679
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 00:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13AB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOsmG-0008Pd-25
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 20:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <revol@free.fr>) id 1iOslE-0006xO-Rm
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 20:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <revol@free.fr>) id 1iOslC-0004Dd-N4
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 20:19:52 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:46662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <revol@free.fr>) id 1iOslC-0004Ca-Dn
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 20:19:50 -0400
Received: from [IPv6:2a01:e35:2f46:f520:f2de:f1ff:fe47:4134] (unknown
 [IPv6:2a01:e35:2f46:f520:f2de:f1ff:fe47:4134])
 (Authenticated sender: revol)
 by smtp5-g21.free.fr (Postfix) with ESMTPA id 16EF25FF33
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:19:46 +0100 (CET)
Subject: Fwd: [retrocomputing devroom] FOSDEM 2020 - Retrocomputing DevRoom
 Call for Participation
References: <CAKcBoku52-a+i7bQavJXmcA0yG=CXjir6-8UjtVQXuqBH+KvYw@mail.gmail.com>
To: qemu-devel Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=revol@free.fr; prefer-encrypt=mutual; keydata=
 mQINBFoYYUUBEADhZbE0j2O2nzEEEAlJ5rpi1Qnj14pjBvV1LhDuQoSWQlwwSyO02mPXnbse
 dBBh9hqE74uDsismMQGRHtO5MQMV/rwaxKSW+tQzbDI0RcQLhkt1ce5v/4bv0PXbGTvf/D1p
 6HfEv3PDoJK2baqImQt/lpwaxhmQCCJ98SV/IX0gI3k/6lL5TzeJblaO/EhUUJUo+poZ9omM
 LMhdEoWcYUTXKTHjwaQP0yKWxr8JyIppaux8IFB3oxYaqST0tGhJ32Unng0yBwtiSEv0Aw7S
 OlGDavgrbtvsy6c0mL4jGwAEe5ZkZQQCqwvu08oj1LxlwC6NINDk+m+kUZ1+MEbqBQ5oMjxB
 gfJiu7wrirPzGWv5xyHoWI5ENnl3lpYe7ba6zQ7t8Uby47W6NS3LNixx2WD3QrVqgP3oe4Ib
 llPRXgAzTA6A7qPiUj6yQu6in6xaveIcwuEus/FE2HKq+rAKjrDRtTN+uaHM0MFJT+kKon8U
 7dlRlk3olYeDdYpr0mykhTl3aaE4Y5jli2QiJhpvPj8kN70tRkiWNVrPW1sMM7y9BOBAyizH
 J5QKYGVr6B7S9nwppp0aj1AIqHJ3EN9fSuoNiIF8hvwR+yS9UU5b8azPPeGY8nJ/KdPsJqwW
 jGySjZAR8OaTyWcrTVC6jBVkB7CfQkm/VUhkepCFdLln16okrwARAQABtB9GcmFuw6dvaXMg
 UmV2b2wgPHJldm9sQGZyZWUuZnI+iQJOBBMBCAA4FiEEdLSsNeZkcXQ9HPZ9U/6vVZOe1NcF
 AloYYUUCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQU/6vVZOe1Nd55w//bsJPRigi
 R8aYL+GeMdk+pc8VZPNArr1zmL3OeEkcbh2TGDQrOHKRUNQmCDTNiq48Uo1GhL19yaU1GhQG
 0scjRBLpbH3Pb4ANVWjiFdMs8NG6saLOCTTB7b66kp2MrAuuPW0FuM02rkXnwreduWACJKCj
 n1UqjMXcJb1VylqvMYte9+BmAbcoL6cgW8VQsdB3WHYbkuy1zidGqR1kR3BVRwQy4x4/l0cD
 UYAT7u87nrUltEz6M0rCRPzlLAe+kkDxPA641qxjAwuVypTIIRDzZcW6dJBx1kyOY5L0Tmit
 1MUq2bHZozfvQhZlXr/pyAyySiPILNGCyfZY4MFaCoCZ0D5zLr2NWmz2ui25baexOo2cnkyG
 KEqlUiF20+o8RAq+GOlhOVzOE0rvOwclL/haXZsaKs4xUG32FCa5Q+BtWB2t1TEU+GkibEzm
 V/YVCRbyA7/h2+UKJsym35fpEbz0TWAi/otiiKvHZeyhbcEt+5Tl5saMVb4J9hgtmKI2Sg9Y
 LfUsO/WAtTR2zDgSieYPnzkukUTx6M05hBKoWJhq2sksbCAPmA8bzByuxvuxOM1Ui92m6cVI
 Muw2yR+3tmW8pD21S5L+6q9oVgB6gMW+Ixi2Q6rQigT/aO0WUFjW3Xg9mBuveZe18IaqQrQt
 s9Rqi0yNAKw46QDrTGIN7YeCcHW5Ag0EWhhhRQEQAOaWdnYT+j48K0NPh8V2dX3IM+jK3hJp
 sGZdOc8thQyRRo9gQzfLH1hxvqfHPecadTKp0pHHUx0yRo9V0EIDolbN3kM54+zCrzMBybOf
 MOrOiPIBPNpQDgqNbS3EnbnUZ7GntW/PzsAupypkP13c9tzG/2b0S0Rd2wgwedOmp2mlQzdP
 THM5YnnipW8Y69NNE1pNSY9v4fxPZZ9wP/JbhyCWlcPzCK/lW6w1RC+D7OankfkLMT25FY74
 GL4LQPHchhiqvL8KkPW7QZ42cMufkcKYOYBzvj5tBXeuA9wA3lRB1Kw1qDDAONU3tYiHbT6K
 bvAMCX1I1Uq7vToNQrRoVwY1tFjAfiIQ+/VXtB94ZAbjGp45dvT2n9wb81vY5eoRqOHOmEJD
 Cm+7hqc1AEXGNE5xuydckSKTiYn/0caykvnsir628VJA6sH4Ch2lNw/nhtHV4bp9idZ3t+7f
 bVRFQNjTXXM9PlIZqRiXEJ0iVcYsWQAgAbRf5KTgPY1qkUeTCD5qwb22/zz/IV38hWE1vg7+
 c4+G8Zi/FHB+HNzpZ4hqgZCnW4bufH+wQ6owiMCi9gVHp5y2L3hky5Hykq5XVijsI0wf99+z
 DZqJ+NeEWhYKkaXe3uafqRf9+VL+HNIWyU+1HGhf1e0Ml/L26FjTYncVEoZT5XeYwvP/Zflh
 BNFHABEBAAGJAjYEGAEIACAWIQR0tKw15mRxdD0c9n1T/q9Vk57U1wUCWhhhRQIbDAAKCRBT
 /q9Vk57U19CBEADFlNILt0WE9xAz2kDLALrb02+12WgE6jY8PcPPYMluGdgZVamTFE9tX+ow
 oXPLCbXVsFkZ7/Ao+6UcSS99j/UTBCs/fNw3RbtGsjI/Vg2WkbMwcJkXxQPnGbhbcpx7ied4
 7E6vjJefg3gFVTt4DqTmb3m1bjOvbEEZJTpt1/yjckcm8hwOZ3OqIH/FaI70XjpdLeiWKCpZ
 mfvur5zYEBBMu5ZFUCgX8VZ5hrP3oH0TymBq+cCqFFxDwNy5bJ/nSVROwi2tQoied7EpaX5y
 e1vn2N1YzvyrEpcswudO7oPtdrYca1DUT75uEUq1usGHyUysYmQ/cwjKBKD2ognTEn9by7Qq
 vecRhW0Rhw+2nVsl5NKo1UG4TeFlyJRZ/TpjlQlQ4w6Y7ooytcaPxcffMtYLp3JYQwtzrg1W
 frlbyffjw0V82KkglcWK5+sSRImsVRqq6oip4DUCpl2ExYiw99/eVDiGJPEDvCZdgDcJQImc
 vacCYyKTKxtgQIfGrz5CdOJ3OCuUDFJjnVL3eGcbKiCJdLQNxTnfepVnh3flHliAbrnmqZ73
 SYh0OnAsKGOlHk9lHPYousYa+Rx6+IbXeSk9m9rK2SN7G+uhoZ77pvKgeSE50FOMDGKIs5Uh
 GZ/5a9RCEO8nb+k2jfkTtiq7WBCqO/QXKAZr5WdL5I4mnBCRsw==
X-Forwarded-Message-Id: <CAKcBoku52-a+i7bQavJXmcA0yG=CXjir6-8UjtVQXuqBH+KvYw@mail.gmail.com>
Message-ID: <096052e8-9fdf-7c21-dcb9-13ecf7bd98c6@free.fr>
Date: Mon, 28 Oct 2019 01:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKcBoku52-a+i7bQavJXmcA0yG=CXjir6-8UjtVQXuqBH+KvYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 212.27.42.5
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

anyone wants to talk about using QEMU for old platform emulation? (like,
m68k or older=E2=80=A6)


Fran=C3=A7ois.


-------- Message transf=C3=A9r=C3=A9 --------
Sujet=C2=A0: [retrocomputing devroom] FOSDEM 2020 - Retrocomputing DevRoo=
m
Call for Participation
Date=C2=A0: Sun, 27 Oct 2019 23:48:33 +0100
De=C2=A0: Pau Garcia Quiles <pgquiles@elpauer.org>
Pour=C2=A0: retrocomputing-devroom@lists.fosdem.org

Hello,

FOSDEM is a free software event that offers open source communities a
place to meet, share ideas and collaborate. It is renowned for being
highly developer-oriented and brings together 8000+ participants from
all over the world. It is held in the city of Brussels (Belgium).

FOSDEM 2020 will take place during the weekend of February 1st-2nd
2020. More details about the event can be found at
http://www.fosdem.org.


CALL FOR PARTICIPATION

After success in the past two years, the Retrocomputing DevRoom will
be back in 2020, with talks about usage of older computing hardware
and software in modern times.

Presentation topics could include but are not limited to:
   - Emulation of old systems to run videogames, legacy software, etc
   - New software, hardware or related to be used with classic systems
   - Open source software emulation/simulation
   - Open hardware
   - Operating systems/executives for retrocomputers/retrosystems
   - Uses of retrocomputing today
   - Other retrosystems topics
   - Opportunities in retrocomputing

You are not limited to slide presentations, of course. Be creative.

However, FOSDEM is an open source conference, therefore we ask you to
stay clear of marketing presentations. We are not afraid of technical
stuff: devrooms are a place for development teams to meet, discuss,
hack and publicly present their project=E2=80=99s latest  improvements an=
d
future directions.

If you will have special needs for your talk (e. g. because you will
need to plug some sort of a system, you need sound, etc), please note
that clearly in your proposal so that we can provide it.

You can use the Wikipedia definition of retrocomputing as a reference
definition to see if you talk qualifies, although it is not exclusive:
https://en.wikipedia.org/wiki/Retrocomputing


IMPORTANT DATES
   -  30 November 2019: submission deadline for talk proposals
   -  14 December 2019: announcement of the final schedule
   -  1 February 2020: Retrocomputing DevRoom


USEFUL INFORMATION

Use the FOSDEM Pentabarf tool to submit your proposal:
https://penta.fosdem.org/submission/FOSDEM20

- If necessary, create a Pentabarf account and activate it. Please
reuse your account from previous years if you have already created it.
- In the "Person" section, provide First name, Last name (in the
"General" tab), Email (in the "Contact" tab) and Bio ("Abstract" field
in the "Description" tab).
- Submit a proposal by clicking on "Create event".
- Important! Select the "Retrocomputing DevRoom" track (on the
"General" tab). If you do not select a track, then nobody, from any
track, will look at your submission!
- Provide the title of your talk ("Event title" in the "General" tab).
- Provide a description of the subject of the talk and the intended
audience (in the "Abstract" field of the "Description" tab)
- Provide a rough outline of the talk or goals of the session (a short
list of bullet points covering topics that will be discussed) in the
"Full description" field in the "Description" tab
- Provide an expected length of your talk in the "Duration" field,
including discussion. The default duration is 30 minutes.
- Slides are NOT required at the moment of submission

Please note neither FOSDEM nor the Retrocomputing DevRoom will
reimburse any expenses you incur.


RECORDING OF TALKS

The FOSDEM organizers plan to have live streaming and recording fully
working, both for remote/later viewing of talks, and so that people
can watch streams in the hallways when rooms are full. This requires
speakers to consent to being recorded and streamed.

If you plan to be a speaker, please understand that by doing so you
implicitly give consent for your talk to be recorded and streamed. The
recordings will be published under the same license as all FOSDEM
content (CC-BY).

Hope to hear from you soon! And please forward this announcement.


CONTACT

The Retrocomputing DevRoom is managed by Pau Garcia Quiles and
Fran=C3=A7ois Revol (retro-devroom-manager@fosdem.org).

A mailing list of speakers, audience and the curious is available,
please subscribe at:
https://lists.fosdem.org/listinfo/retrocomputing-devroom


--=20
Pau Garcia Quiles
http://www.elpauer.org
_______________________________________________
retrocomputing-devroom mailing list
retrocomputing-devroom@lists.fosdem.org
https://lists.fosdem.org/listinfo/retrocomputing-devroom

