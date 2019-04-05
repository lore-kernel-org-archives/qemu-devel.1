Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F12C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B4520700
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TUcLISWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B4520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37435 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJFm-0002Lz-3r
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 03:27:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJEa-0001NW-Ab
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJ53-00018M-LM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:16:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:39383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hCJ53-00014z-9S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1554448449;
	bh=BkfLWYQla2vyPPOPe4nLdV3JuYB6bebyXixIKinQ2+Y=;
	h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
	b=TUcLISWcbjt30T4tpDIBcwKR/Zra60VDSNbdxvHueSuhmCyDfKairlSu9Tqma1Dx6
	S2ri/t9nuOocFlqGrAb0+To7L5Eoc8bGsH1O5joiZJreCPKWnr1qUP6UK2ehLw6GIV
	hO1z0kR5Q9C6CmQN/ocNFGe7iHHT9VSu4w1+IeoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.3]) by mail.gmx.com (mrgmx001
	[212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1gmRLi2msh-013tsx;
	Fri, 05 Apr 2019 09:14:09 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<e0959fcc-df89-1d64-e512-924c25106dc0@redhat.com>
From: Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
	xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
	y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
	+sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
	KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
	OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
	AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
	AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
	UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
	+ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
	iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
	288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
	vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
	zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
	+0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
	UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
	T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
	gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
	BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
	91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
	kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
	lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
	ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
	KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <87b3bdc4-3e35-c81b-bd41-7817fc70e9e5@gmx.de>
Date: Fri, 5 Apr 2019 09:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e0959fcc-df89-1d64-e512-924c25106dc0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0sRqROkP7NRvgxqGTAIrhBtzGuPt79oQBsADn40+V6RMrMyvbDq
	YoqPjq+slcHb0q+3WicrZDbPmhFVwzGfZbjCoMQZZSRpOpRPXGSdon1GldfbUG9rPsCTxXp
	x/us0Y1siZ/SimWAIBxyWnp0WGlYMAWUw45kaK80Oiau+o2QSJhfo4+H4ztW7Gkj4k9+qnV
	Jjt7pxtQylnl5B1uIwEFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lp2xMEE0yAs=:7uUUsM3LVO09KAeAl2QlWr
	e96SziXkopLybuCssy0eG6k1grWPHOR7NT3i+L/TeLGeuzGuoBlI5wKKHsQtDPBJ7chSX+mSM
	EkM0sysOuNudSUvaYIGnurnovleUgaU+NwpOgPYuCXPk2MmpJIa8YHf03iZ5qFmjSP5eV7kxn
	m2O3mdA0hAKklxSq05vq7I05ANNfHMVCmPM3KDSjjpYqCWLFqZwXcajETr8xYO37vYdIbQ67Y
	0ulFdlUT6QDWEdFG4cBFniWo/krmc121CSKIpbIp7cQFXrHKfqebjqmQlDfQLh/qr4+/DZ9w9
	kXbFlQi9KoeHEA2/yDKbAFD2SojuoElHE/8wen5ggcl+QFRha4Pf5S4b02anXkQZfay/oLCQi
	XiRhnM8GmZjD80uUS22XBbR6XP1WEhZawTQBQ2666bFiqz60B0lz1ckhSBdmAJ+x3G0tCILGX
	MC/hGGIfzsk7MZZDhgZ+YxCVaH2zBrC7d3GQyjPLaDhtB+eORkG2Ggp6VfBLbohkrcF0N8RHk
	IIdOjZBeyAFoOj4TX6wHi6vJOEUk57mK0inHbmJbtl5PB01MbvWjFPXXvSjUQJzg3Maocl0w8
	V8RVD15EYQ6eOPzE5RgFCG1HFzaILSWPvBGjAnzk2NtMKLVCk5rmF0qqabzpfL41SBihnOVMx
	lmrAgWUq0O39So93XtEHtHbL9Qjx5ZMNWfffrx0Hv0qk38131nXt4Eu3n70JvbJ86x92ibtHP
	k9j3HYqZ88gzv+5PW9jakRprmZvjubDX/4MXVSES668QMv0ByyCpxswS41Hot7J2GB+e52Uon
	8lRyMuq15xf+AlkRIAPgm4m96oguPAgo4A6AVBB79U4Yq4UfBVRQsT4yr8CNzVZvKkLXzXj1d
	Zbgz1rJ7IeGS7asGO4ZxgPZ9YqVLTfiRZ2KD49cj1uyoNkHYj9+hfzxU8gC+Em
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405071408.1jx1ClSvCWAZvCgNi0VN-5YvcRkAR4SBsomBBfIG6Es@z>

Hi Philippe,

On 04.04.19 21:24, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Helge,
>
> On 4/4/19 8:57 PM, Helge Deller wrote:
>> If a non-release architecture is found, and it's known that there is no
>> native TCG support for that CPU, automatically fall back to the TCI
>> implementation instead of requesting the user to run configure again
>> with the --enable-tcg-interpreter option.
>>
>> This change simplifies building qemu in automatic build environments
>> (like in my case the debian buildds) because one does not need to
>> special case on the architectures.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/configure b/configure
>> index 1c563a7027..8fe4fc84d8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -769,8 +769,10 @@ case "$cpu" in
>>      cross_cc_sparc=3D$host_cc
>>    ;;
>>    *)
>> -    # This will result in either an error or falling back to TCI later
>> +    # Fall back to TCI on unsupported CPUs
>>      ARCH=3Dunknown
>> +    echo "Unsupported '$cpu' CPU found. Will use TCG with TCI (experim=
ental)."
>> +    tcg_interpreter=3D"yes"
>
> I'm not comfortable with this change... I'd prefer to keep the explicit
> flag. Is your debian buildd targetting mainstream QEMU or the Debian
> package? Can't you manage this as a Debian specific patch?

I tried to get it added as debian specific patch a few times.

> Else, why not add a "hppa" case selecting TCI in the switch? This would
> be less invasive.

If that would be acceptable, I'm happy to send a new patch.

Helge

>>    ;;
>>  esac
>>  if test -z "$ARCH"; then
>> @@ -1855,16 +1857,6 @@ if ! compile_prog ; then
>>      error_exit "\"$cc\" cannot build an executable (is your linker bro=
ken?)"
>>  fi
>>
>> -# Now we have handled --enable-tcg-interpreter and know we're not just
>> -# printing the help message, bail out if the host CPU isn't supported.
>> -if test "$ARCH" =3D "unknown"; then
>> -    if test "$tcg_interpreter" =3D "yes" ; then
>> -        echo "Unsupported CPU =3D $cpu, will use TCG with TCI (experim=
ental)"
>> -    else
>> -        error_exit "Unsupported CPU =3D $cpu, try --enable-tcg-interpr=
eter"
>> -    fi
>> -fi
>> -
>>  # Consult white-list to determine whether to enable werror
>>  # by default.  Only enable by default for git builds
>>  if test -z "$werror" ; then
>>


