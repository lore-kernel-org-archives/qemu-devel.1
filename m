Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDCC43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4752087C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q4frNVmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4752087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKRGN-0003VQ-Ks
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 13:37:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44095)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hKRFS-0003Cd-TK
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hKRFR-0001M6-8p
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:36:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hKRFQ-0001Kt-SN
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1556386577;
	bh=Ln7E1njIru/ay7whRdkrEUvhwG5pWQxGxgx7h/smLKY=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=Q4frNVmU5BQutSlrSoAt/lab2lnZY2lJHQ8IN44FS86AwoKNLTfUYwDOYFqBQoOK2
	7NMhwonb5qJfh4k0GsARlklF9poFPfJYqbqoK7uIL6EsTwGoJU8QTZMplJUxHdN/g8
	G7wSqQob3uh6nsYDAY33qY8Bu2ezxNjsP+ioxTbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx001
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0LbuCq-1gsqGr0ZPA-00jH6D;
	Sat, 27 Apr 2019 19:36:17 +0200
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
	<20190427163007.5113-3-samuel.thibault@ens-lyon.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
Date: Sat, 27 Apr 2019 19:36:40 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190427163007.5113-3-samuel.thibault@ens-lyon.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DoXCxRb0b3mOoHbZiirh94payMyl8zocl"
X-Provags-ID: V03:K1:yPoMLrIlUTE9S5h7cMoea8xKkldlYKSoVUlNWXbTZi8MVLZHPwa
	xVw9vlicDQXt2zzH0N0BftMva3OrgmOekGj6IGBFRkHmg1lDRyKxQGrcr551Hka8ujBoB6/
	AUSyqZ/3LgnS/0yryeszTy5jfxz9kwrhP7xm35TfOtf/wntW5KJQnY8kIksPu/IqyONNf6c
	YabVyNKAUerAWY9jRjWOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kkX4gN2CUpY=:PAo/gOd3vu17dU5lPfTpIM
	9BjLiSsRoIALRf2AXseEs1TxlBDq9Vi89oX/YFG8UXF86xSKNlR1S7KVL6SdVlVdZOD4rvUnM
	KIPhXXtqpfSsjfnnICRfgM+rvEMP1cMa7Dg0lX/kgGb+XKAyOB21m1zsw0/5krfSEU3mNPNgi
	NdCWp6l0AUEPTA44HFZ99IH8aNw8rcfYVTxtSzBN2Ch+t7UaEacKr8bXDCgOI0kH/sqckEGcm
	ZyMAHGcYqc5zSpFCd76WeRmVrSDRwfg3fpMebcJNH1hyZj8mjX7D4v7gVxe5pWiHAmxM4WcQz
	IF0PYoNPAMNAUEukPkF1uVVrgFeyQXLA81rz2bXwctI1O52YccRiDgQYS6++uf9BPzfR6hHrM
	AxQJagZYnuelOHLlx/dItrFI0h1b3Z72CrLgAcNtCV9ZsOmxcozuAAmSTk9Me6z9aPe7+YfcQ
	YBg+rCZiQTjFiq1gmTrqeO6nW+UVewKS1CsEcp2QriFLGMdMV8Fk2PnwC7sJ8Wiwtb0uwBQkD
	oGw9F8bXKKNop3r381PNspz4Cxy4xsiOhFfKT+R9ejYFtN6NywJ3y0bPfEt2+XaBFMphzFlg3
	Xi02r/MlKwfDDi2oeqEIG22zwgoOyxDbDDV943OQseazPggVPqXZfTzd1bd0O3qoD1bwIY8WM
	E1u+nx9x1CdCswRvWvu4c26/hhEtTpkIbDiM5eLDGugI/o8W/lvNjrb3QD+ncnTtmp/vgXUus
	KEsa78JblOCAssE7rp+NsGYl+RTdMXgcGCRMuWmk3Jp38O/nrZ1DvK1xIMJYqV3ZaaZiz+j1F
	kyCjA1d6/mODu4CkUIAfrEJDqaarcEllTHiRN3ujpsGRjBsMV4PlClYjVDOhcrg3vhV5+sAGd
	tMLBxA4NE9/t+VDYZahcs6c3To1zo2dkijPypU8Z8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
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
Cc: kamil@netbsd.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427173640.Gk1vtv5uwdv_78cTmwEGdDh0jMj40f6trusZxK-pBpE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DoXCxRb0b3mOoHbZiirh94payMyl8zocl
From: Kamil Rytarowski <n54@gmx.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, kamil@netbsd.org
Message-ID: <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
Subject: Re: [PATCHv3 1/2] ui/curses: Do not assume wchar_t contains unicode
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
 <20190427163007.5113-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190427163007.5113-3-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2019 18:30, Samuel Thibault wrote:
> E.g. BSD and Solaris even use locale-specific encoding there.
>=20
> We thus have to go through the native multibyte representation and use
> mbtowc/wctomb to make a proper conversion.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Both patches work for me on NetBSD/amd64 8.99.37 for qemu-system-x86_64.
Borders are printed correctly.

Regarding the patch I'm not sure whether to use MB_LEN_MAX or MB_CUR_MAX?=


I'm also unsure whether to reset conversion state between a multibyte
character and wide character, with: `mbtowc(NULL, 0, 0);`. It's
recommended to use in code examples examples. I think it doesn't make
any harm to use it.


I'm not sure if this is related, but "qemu-system-hppa -curses" is
broken for me. I didn't use it in the past as it just recently acquired
NetBSD guest support.

(lldb) bt
* thread #1, stop reason =3D signal SIGSEGV
    frame #0: 0x00007f7ff6c1fb98
libcurses.so.7`wmove(win=3D0x0000000000000000, y=3D0, x=3D0) at move.c:71=

    frame #1: 0x00007f7ff6c0ca9b
libcurses.so.7`mvwadd_wchnstr(win=3D0x0000000000000000, y=3D<unavailable>=
,
x=3D<unavailable>, wchstr=3D0x00007f7fffffe020, n=3D0) at add_wchstr.c:12=
3
  * frame #2: 0x000000000078629e
qemu-system-hppa`curses_update(dcl=3D0x00007f7ff7bd8bc0, x=3D0, y=3D0, w=3D=
79,
h=3D24) at curses.c:86:9
    frame #3: 0x0000000000753dae
qemu-system-hppa`dpy_text_update(con=3D0x00007f7ff7bae580, x=3D0, y=3D0, =
w=3D79,
h=3D24) at console.c:1658:13
    frame #4: 0x0000000000758abe
qemu-system-hppa`text_console_update(opaque=3D0x00007f7ff7bae580,
chardata=3D0x000000000118e490) at console.c:1264:9
    frame #5: 0x0000000000751ef8
qemu-system-hppa`graphic_hw_text_update(con=3D0x00007f7ff7bae580,
chardata=3D0x000000000118c690) at console.c:389:9
    frame #6: 0x0000000000785bcb
qemu-system-hppa`curses_refresh(dcl=3D0x00007f7ff7bd8bc0) at curses.c:273=
:5
    frame #7: 0x0000000000758248
qemu-system-hppa`dpy_refresh(s=3D0x00007f7ff7bd8770) at console.c:1622:13=

    frame #8: 0x000000000075809d
qemu-system-hppa`gui_update(opaque=3D0x00007f7ff7bd8770) at console.c:205=
:5
    frame #9: 0x00000000008d9f4d
qemu-system-hppa`timerlist_run_timers(timer_list=3D0x00007f7ff7e57d20) at=

qemu-timer.c:574:9
    frame #10: 0x00000000008da01d
qemu-system-hppa`qemu_clock_run_timers(type=3DQEMU_CLOCK_REALTIME) at
qemu-timer.c:588:12
    frame #11: 0x00000000008da4ea
qemu-system-hppa`qemu_clock_run_all_timers at qemu-timer.c:708:25
    frame #12: 0x00000000008da962
qemu-system-hppa`main_loop_wait(nonblocking=3D0) at main-loop.c:519:5
    frame #13: 0x00000000005570a4 qemu-system-hppa`main_loop at vl.c:1970=
:9
    frame #14: 0x0000000000551fa4 qemu-system-hppa`main(argc=3D2,
argv=3D0x00007f7fffffe768, envp=3D0x00007f7fffffe780) at vl.c:4604:5
    frame #15: 0x000000000040e7ad qemu-system-hppa`___start + 280

(lldb) p screenpad
(WINDOW *) $2 =3D 0x0000000000000000

We pass NULL window argument to mvwadd_wchnstr(3) and crash. Can you
reproduce it locally?

I will try to investigate it.

> ---
>  ui/curses.c | 151 ++++++++++++++++++++++++++++++++--------------------=

>  1 file changed, 94 insertions(+), 57 deletions(-)
>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index fb63945188..395f9545e9 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -400,65 +400,102 @@ static void curses_atexit(void)
>      endwin();
>  }
> =20
> +/*
> + * In the following:
> + * - fch is the font glyph number
> + * - uch is the unicode value
> + * - wch is the wchar_t value (may not be unicode, e.g. on BSD/solaris=
)
> + * - mbch is the native local-dependent multibyte representation
> + */
> +
>  /* Setup wchar glyph for one UCS-2 char */
> -static void convert_ucs(int glyph, uint16_t ch, iconv_t conv)
> +static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)=

>  {
> +    char mbch[MB_CUR_MAX];
>      wchar_t wch;
> -    char *pch, *pwch;
> -    size_t sch, swch;
> -
> -    pch =3D (char *) &ch;
> -    pwch =3D (char *) &wch;
> -    sch =3D sizeof(ch);
> -    swch =3D sizeof(wch);
> +    char *puch, *pmbch;
> +    size_t such, smbch;
> +
> +    puch =3D (char *) &uch;
> +    pmbch =3D (char *) mbch;
> +    such =3D sizeof(uch);
> +    smbch =3D sizeof(mbch);
> +
> +    if (iconv(conv, &puch, &such, &pmbch, &smbch) =3D=3D (size_t) -1) =
{
> +        fprintf(stderr, "Could not convert 0x%04x "
> +                        "from UCS-2 to a multibyte character: %s\n",
> +                        uch, strerror(errno));
> +        return;
> +    }
> =20
> -    if (iconv(conv, &pch, &sch, &pwch, &swch) =3D=3D (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%04x from UCS-2 to WCHAR_=
T: %s\n",
> -                        ch, strerror(errno));
> -    } else {
> -        vga_to_curses[glyph].chars[0] =3D wch;
> +    if (mbtowc(&wch, mbch, sizeof(mbch) - smbch) =3D=3D -1) {
> +        fprintf(stderr, "Could not convert 0x%04x "
> +                        "from a multibyte character to wchar_t: %s\n",=

> +                        uch, strerror(errno));
> +        return;
>      }
> +    vga_to_curses[fch].chars[0] =3D wch;
>  }
> =20
>  /* Setup wchar glyph for one font character */
> -static void convert_font(unsigned char ch, iconv_t conv)
> +static void convert_font(unsigned char fch, iconv_t conv)
>  {
> +    char mbch[MB_CUR_MAX];
>      wchar_t wch;
> -    char *pch, *pwch;
> -    size_t sch, swch;
> -
> -    pch =3D (char *) &ch;
> -    pwch =3D (char *) &wch;
> -    sch =3D sizeof(ch);
> -    swch =3D sizeof(wch);
> +    char *pfch, *pmbch;
> +    size_t sfch, smbch;
> +
> +    pfch =3D (char *) &fch;
> +    pmbch =3D (char *) &mbch;
> +    sfch =3D sizeof(fch);
> +    smbch =3D sizeof(mbch);
> +
> +    if (iconv(conv, &pfch, &sfch, &pmbch, &smbch) =3D=3D (size_t) -1) =
{
> +        fprintf(stderr, "Could not convert font glyph 0x%02x "
> +                        "from %s to a multibyte character: %s\n",
> +                        fch, font_charset, strerror(errno));
> +        return;
> +    }
> =20
> -    if (iconv(conv, &pch, &sch, &pwch, &swch) =3D=3D (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%02x from %s to WCHAR_T: =
%s\n",
> -                        ch, font_charset, strerror(errno));
> -    } else {
> -        vga_to_curses[ch].chars[0] =3D wch;
> +    if (mbtowc(&wch, mbch, sizeof(mbch) - smbch) =3D=3D -1) {
> +        fprintf(stderr, "Could not convert font glyph 0x%02x "
> +                        "from a multibyte character to wchar_t: %s\n",=

> +                        fch, strerror(errno));
> +        return;
>      }
> +    vga_to_curses[fch].chars[0] =3D wch;
>  }
> =20
>  /* Convert one wchar to UCS-2 */
>  static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>  {
> -    uint16_t ch;
> -    char *pch, *pwch;
> -    size_t sch, swch;
> -
> -    pch =3D (char *) &ch;
> -    pwch =3D (char *) &wch;
> -    sch =3D sizeof(ch);
> -    swch =3D sizeof(wch);
> -
> -    if (iconv(conv, &pwch, &swch, &pch, &sch) =3D=3D (size_t) -1) {
> -        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS=
-2: %s\n",
> -                (unsigned long)wch, strerror(errno));
> +    char mbch[MB_CUR_MAX];
> +    uint16_t uch;
> +    char *pmbch, *puch;
> +    size_t smbch, such;
> +    int ret;
> +
> +    ret =3D wctomb(mbch, wch);
> +    if (ret =3D=3D -1) {
> +        fprintf(stderr, "Could not convert 0x%04x "
> +                        "from wchar_t to a multibyte character: %s\n",=

> +                        wch, strerror(errno));
> +        return 0xFFFD;
> +    }
> +
> +    pmbch =3D (char *) mbch;
> +    puch =3D (char *) &uch;
> +    smbch =3D ret;
> +    such =3D sizeof(uch);
> +
> +    if (iconv(conv, &pmbch, &smbch, &puch, &such) =3D=3D (size_t) -1) =
{
> +        fprintf(stderr, "Could not convert 0x%04x "
> +                        "from a multibyte character to UCS-2 : %s\n",
> +                        wch, strerror(errno));
>          return 0xFFFD;
>      }
> =20
> -    return ch;
> +    return uch;
>  }
> =20
>  /*
> @@ -466,6 +503,11 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)=

>   */
>  static void font_setup(void)
>  {
> +    iconv_t ucs2_to_nativecharset;
> +    iconv_t nativecharset_to_ucs2;
> +    iconv_t font_conv;
> +    int i;
> +
>      /*
>       * Control characters are normally non-printable, but VGA does hav=
e
>       * well-known glyphs for them.
> @@ -505,30 +547,25 @@ static void font_setup(void)
>        0x25bc
>      };
> =20
> -    iconv_t ucs_to_wchar_conv;
> -    iconv_t wchar_to_ucs_conv;
> -    iconv_t font_conv;
> -    int i;
> -
> -    ucs_to_wchar_conv =3D iconv_open("WCHAR_T", "UCS-2");
> -    if (ucs_to_wchar_conv =3D=3D (iconv_t) -1) {
> +    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), "UCS-2"=
);
> +    if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
>          fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s=
'\n",
>                          strerror(errno));
>          exit(1);
>      }
> =20
> -    wchar_to_ucs_conv =3D iconv_open("UCS-2", "WCHAR_T");
> -    if (wchar_to_ucs_conv =3D=3D (iconv_t) -1) {
> -        iconv_close(ucs_to_wchar_conv);
> +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", nl_langinfo(CODESET)=
);
> +    if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
> +        iconv_close(ucs2_to_nativecharset);
>          fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\=
n",
>                          strerror(errno));
>          exit(1);
>      }
> =20
> -    font_conv =3D iconv_open("WCHAR_T", font_charset);
> +    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
>      if (font_conv =3D=3D (iconv_t) -1) {
> -        iconv_close(ucs_to_wchar_conv);
> -        iconv_close(wchar_to_ucs_conv);
> +        iconv_close(ucs2_to_nativecharset);
> +        iconv_close(nativecharset_to_ucs2);
>          fprintf(stderr, "Could not convert font glyphs from %s: '%s'\n=
",
>                          font_charset, strerror(errno));
>          exit(1);
> @@ -536,7 +573,7 @@ static void font_setup(void)
> =20
>      /* Control characters */
>      for (i =3D 0; i <=3D 0x1F; i++) {
> -        convert_ucs(i, control_characters[i], ucs_to_wchar_conv);
> +        convert_ucs(i, control_characters[i], ucs2_to_nativecharset);
>      }
> =20
>      for (i =3D 0x20; i <=3D 0xFF; i++) {
> @@ -544,12 +581,12 @@ static void font_setup(void)
>      }
> =20
>      /* DEL */
> -    convert_ucs(0x7F, 0x2302, ucs_to_wchar_conv);
> +    convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
> =20
>      if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
>          /* Non-Unicode capable, use termcap equivalents for those avai=
lable */
>          for (i =3D 0; i <=3D 0xFF; i++) {
> -            switch (get_ucs(vga_to_curses[i].chars[0], wchar_to_ucs_co=
nv)) {
> +            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_t=
o_ucs2)) {
>              case 0x00a3:
>                  vga_to_curses[i] =3D *WACS_STERLING;
>                  break;
> @@ -649,8 +686,8 @@ static void font_setup(void)
>              }
>          }
>      }
> -    iconv_close(ucs_to_wchar_conv);
> -    iconv_close(wchar_to_ucs_conv);
> +    iconv_close(ucs2_to_nativecharset);
> +    iconv_close(nativecharset_to_ucs2);
>      iconv_close(font_conv);
>  }
> =20
>=20



--DoXCxRb0b3mOoHbZiirh94payMyl8zocl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzEkygMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs5v8P/jyuSAeCZpixA2g58dr4oTioxT9AnkvgtAmwt8OF
RhCsiv8GQx+9pBzEQukKP8M/UO+2RC3GuQ6m6/EkrNMPEVeWBmZrFe24ZmNtR44i
7KA5QpeqSJhI/x07mcPXaYXQmCF2wLEs+eiuFErXsXoWrmx8qXBAEWWqA0GZwKbu
tKeD8vCtaG38ABm/83hKM8mpEPEY8MfCduZNqpKrmmUT7eVKzCDGfpzvhSX0D+Am
bI8OuRjOgaAPu301bZwFImZDxjKi48P8puQqhou04iRzz6z3tyT8yIWmAX6Wh6dN
vOSj66Pt0ST5x8ygyhDeIAgrdumsxM57QtUBAbh0NJKP2/nd08YOTvfku3rk969e
hyjmob835OUR7+AFq2+B+gwNcNZWlzV+gvd9g0dCZTJ9h8puYtUo0tY2B1nIYWeU
zQGEMwZifQvL6PXxuDrYTMEc4jLW4hoV09KBa9zZBnPv4rRYelV4zHQ57/E0Y/3H
Ke8igNexoC4/lumujAcz+VuPrqb2d73FiBm9QLDmfPjD2oEewPComMQHSnH1eQEu
zwjU0nCMaGyVqH0DTunJhurdBcTMqdwrQpkCpNhgSq0zyYsNbyN3RMlea1PI0Py9
dxZDdX57r3c//NAnEwmXazfMwCyVJSHoQCXjiG3/PJ4qxkkhZOSQXltU8ukZZbPv
JaTy
=sgJN
-----END PGP SIGNATURE-----

--DoXCxRb0b3mOoHbZiirh94payMyl8zocl--

