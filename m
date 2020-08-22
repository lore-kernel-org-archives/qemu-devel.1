Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D27C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37F82072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Qrt4X7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9V4r-0004aq-0j
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 11:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k9V3s-0003vM-Qi
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 11:04:04 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:42852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k9V3n-0007S3-Gz
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 11:04:04 -0400
Received: by mail-lj1-x236.google.com with SMTP id t6so4940123ljk.9
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IuzBaAVV7qKj1XQhKgpES3XjfQOOm5Dp+k0kyC536J4=;
 b=I0Qrt4X72wdtOTckvYCi8zphyc0++fl790CpGsf91NAA/GNO74mw3aLuu6huUEkahD
 oew6TJ3GBtSh6KZ1WDjl0v85hPn7G+3yjelrKdeKB6Zr4+GqcfEhUDDw+JpbVSkVyKsx
 epxh28NZm5ZXcvbkLk2Q0tHZzKpTAuCyaOkcFOk0MOzUh/BI6P8AlhIXQs6os1yQtV6Q
 ca9N4yTiWbLuL41SGbwB5FOxrhuoDiRckG3WYSI0r2dbOPoqzKegZr1FsXDef+Gqdh9f
 zafJK0hv4ItG9tsfb/l49xWpDiUxMVed84QnKfUtU/mGG+N8TP9pySL0Nn7rfXP3zoiD
 B6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuzBaAVV7qKj1XQhKgpES3XjfQOOm5Dp+k0kyC536J4=;
 b=hqefaE1stJCfvEVMDAMx8pOxFWCn1Kj9q5JPwSVLerUJevaUiCMzSVYC7Cv51JsaxX
 bE8pCkrGy6OB8RSNTbvpY/hgJL1hyCt+ZhxGND60TNaVgHxBElAugunYnV3zlVD7eBE5
 eQ6ciU3xErhkEvtdkCSuQblrERWawW3d2yUZ9pztDj1DrQUPq1x0ycPtkch5i/kZFkKM
 OpJJmJWsIBS2OxdpKNJ3SpWRYwnpBoVFOQZS2kLFL08gD/yvd6pJIxKLco7Mzq+LaBFF
 p9iPtX5WvYsTWVnEtnzpWyMeAkGThkaij0jpjkh/XR4BrXmWEQwuQbVuJUt0WXGkusVX
 svgw==
X-Gm-Message-State: AOAM533ibmWfHYfS73YBXCsUZo7HHV1DGF4Ahn7z2UzMQUv4s9ag7B9m
 pnrIgeo33tDVNm0G+DaEcz66N6vnVKSl0pIIL6s=
X-Google-Smtp-Source: ABdhPJzvRu3gyQJrM2zFD9jPsXbbcG7nHxHQmpEFLeUqX6xVs/HQJD8M3+CiPTjt+WZMzPcr+IpdKZgf1sPXCZFU7+0=
X-Received: by 2002:a2e:9050:: with SMTP id n16mr3896905ljg.228.1598108637258; 
 Sat, 22 Aug 2020 08:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <5f3d9a64.1c69fb81.58fa8.0979@mx.google.com>
 <CAHiYmc5ikDG2wOF5cv4j+weMJHw+scHBFWde60PF0nNTxqinQA@mail.gmail.com>
 <CAHiYmc5ej_tNGbktAV51y1ra_ufEnVKSrBbMFrxdbH4F=ednkw@mail.gmail.com>
In-Reply-To: <CAHiYmc5ej_tNGbktAV51y1ra_ufEnVKSrBbMFrxdbH4F=ednkw@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sat, 22 Aug 2020 17:03:46 +0200
Message-ID: <CALTWKrUy9CZX7muipprorPG3U8rT+BaMs1mjnSZy+cy=iuTuDA@mail.gmail.com>
Subject: Re: [REPORT] Nightly Performance Tests - Wednesday, August 19, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a2e78b05ad78a9c2"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a2e78b05ad78a9c2
Content-Type: text/plain; charset="UTF-8"

Thanks Mr. Aleksandar,

"Reference" and "latest" already each has its own results directory.

I will try re-running the tests tonight from scratch as you've suggested to
see how things will go.

I will also add the "-------" line at the beginning as you've suggested.

Best regards,
Ahmed

On Sat, Aug 22, 2020, 2:21 PM Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

>
>
> On Saturday, August 22, 2020, Aleksandar Markovic <
> aleksandar.qemu.devel@gmail.com> wrote:
>
>>
>>
>> On Wednesday, August 19, 2020, Ahmed Karaman <
>> ahmedkhaledkaraman@gmail.com> wrote:
>>
>>> Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
>>> Host Memory      : 15.49 GB
>>>
>>> Start Time (UTC) : 2020-08-19 21:00:01
>>> End Time (UTC)   : 2020-08-19 21:32:15
>>> Execution Time   : 0:32:14.021998
>>>
>>> Status           : SUCCESS
>>>
>>> --------------------------------------------------------
>>>
>>>
>>> I see we did not receive nightly report last night. The cause is most
>> likely the change of our build system that happened yesterday.
>>
>> I think the best approach for you is to start tonight "from scratch". So,
>> with source code tree and all past data deleted - as if you execute the
>> nighlies for the first time ever. This will cause a fresh checkout, and a
>> recreation of 5.1 and 'latest' perfirmace data.
>>
>>
> Sorry, I envision some problems with the approach I described. I think you
> should better create a separate source directory for reference 5.1
> measurements, and another source directory for all measurements from
> tonight on. That way you will avoid switching between build systems from
> within the same directory.
>
> Thanks,
> Aleksandar
>
>
>
>
>> Unrelated hint:
>>
>> Please include the following (or similar) text right before the tables
>> with results:
>>
>> "'-----' denotes difference less than 0.01%."
>>
>> This way the readers will not be confused with '-----' meaning.
>>
>> Yours,
>> Aleksandar
>>
>>
>>>
>>>             SUMMARY REPORT - COMMIT 672b2f26
>>> --------------------------------------------------------
>>>                     AVERAGE RESULTS
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 118 484 879       -----       -----
>>> alpha              1 838 407 216       -----       -----
>>> arm                7 887 992 884       -----       -----
>>> hppa               4 124 996 474       -----       -----
>>> m68k               2 453 421 671       -----       -----
>>> mips               1 812 636 995       -----       -----
>>> mipsel             1 947 725 352       -----       -----
>>> mips64             1 862 495 613       -----       -----
>>> mips64el           1 984 211 702       -----       -----
>>> ppc                2 394 319 834       -----       -----
>>> ppc64              2 488 040 622       -----       -----
>>> ppc64le            2 470 198 016       -----       -----
>>> riscv64            1 367 774 718       -----       -----
>>> s390x              3 058 498 362       -----       -----
>>> sh4                2 278 490 061       -----       -----
>>> sparc64            3 186 999 246       -----       -----
>>> x86_64             1 734 475 394       -----       -----
>>> --------------------------------------------------------
>>>
>>>                    DETAILED RESULTS
>>> --------------------------------------------------------
>>> Test Program: dijkstra_double
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            3 019 613 303       -----       -----
>>> alpha              3 078 110 233       -----       -----
>>> arm               15 982 079 823       -----       -----
>>> hppa               7 012 014 505       -----       -----
>>> m68k               3 914 631 319       -----       -----
>>> mips               2 979 137 836       -----       -----
>>> mipsel             3 141 391 810       -----       -----
>>> mips64             3 163 713 203       -----       -----
>>> mips64el           3 314 105 619       -----       -----
>>> ppc                4 692 148 212       -----       -----
>>> ppc64              4 875 585 404       -----       -----
>>> ppc64le            4 859 857 200       -----       -----
>>> riscv64            2 150 267 230       -----       -----
>>> s390x              4 455 507 359       -----       -----
>>> sh4                3 816 841 775       -----       -----
>>> sparc64            4 399 783 149       -----       -----
>>> x86_64             2 441 371 746       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: dijkstra_int32
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 177 687 656       -----       -----
>>> alpha              1 462 693 182       -----       -----
>>> arm                8 048 440 634       -----       -----
>>> hppa               5 053 362 217       -----       -----
>>> m68k               1 683 346 196       -----       -----
>>> mips               1 473 265 047       -----       -----
>>> mipsel             1 475 326 892       -----       -----
>>> mips64             1 683 560 350       -----       -----
>>> mips64el           1 663 467 060       -----       -----
>>> ppc                1 978 581 291       -----       -----
>>> ppc64              2 160 088 877       -----       -----
>>> ppc64le            2 151 841 575       -----       -----
>>> riscv64            1 323 226 597       -----       -----
>>> s390x              2 880 509 792       -----       -----
>>> sh4                1 938 787 291       -----       -----
>>> sparc64            2 768 217 627       -----       -----
>>> x86_64             1 521 726 675       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: matmult_double
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            1 408 042 295       -----       -----
>>> alpha              3 009 129 018       -----       -----
>>> arm                8 453 187 175       -----       -----
>>> hppa               3 334 593 464       -----       -----
>>> m68k               3 309 165 600       -----       -----
>>> mips               2 252 644 394       -----       -----
>>> mipsel             3 166 010 232       -----       -----
>>> mips64             2 266 660 274       -----       -----
>>> mips64el           3 179 408 969       -----       -----
>>> ppc                3 108 563 525       -----       -----
>>> ppc64              3 186 404 684       -----       -----
>>> ppc64le            3 186 105 591       -----       -----
>>> riscv64            1 218 230 013       -----       -----
>>> s390x              2 715 954 030       -----       -----
>>> sh4                3 330 300 193       -----       -----
>>> sparc64            3 197 860 268       -----       -----
>>> x86_64             1 244 922 914       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: matmult_int32
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64              595 215 814       -----       -----
>>> alpha                369 955 794       -----       -----
>>> arm                  735 842 738       -----       -----
>>> hppa                 666 414 556       -----       -----
>>> m68k                 406 857 412       -----       -----
>>> mips                 497 082 899       -----       -----
>>> mipsel               497 032 468       -----       -----
>>> mips64               478 686 174       -----       -----
>>> mips64el             462 210 845       -----       -----
>>> ppc                  338 165 176       -----       -----
>>> ppc64                390 046 801       -----       -----
>>> ppc64le              390 236 162       -----       -----
>>> riscv64              348 989 619       -----       -----
>>> s390x                491 496 329       -----       -----
>>> sh4                  399 095 487       -----       -----
>>> sparc64              490 124 541       -----       -----
>>> x86_64               399 613 899       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: qsort_double
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 645 742 637       -----       -----
>>> alpha              1 899 562 379       -----       -----
>>> arm                8 113 107 429       -----       -----
>>> hppa               3 098 469 739       -----       -----
>>> m68k               4 302 051 049       -----       -----
>>> mips               2 060 965 462       -----       -----
>>> mipsel             2 061 404 232       -----       -----
>>> mips64             1 933 231 416       -----       -----
>>> mips64el           1 930 636 000       -----       -----
>>> ppc                2 673 960 745       -----       -----
>>> ppc64              2 623 577 315       -----       -----
>>> ppc64le            2 580 240 728       -----       -----
>>> riscv64            1 575 021 518       -----       -----
>>> s390x              2 437 147 903       -----       -----
>>> sh4                2 520 101 855       -----       -----
>>> sparc64            3 882 349 298       -----       -----
>>> x86_64             1 969 776 338       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: qsort_int32
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 131 273 662       -----       -----
>>> alpha              1 460 090 651       -----       -----
>>> arm                3 372 526 755       -----       -----
>>> hppa               2 196 131 815       -----       -----
>>> m68k               1 779 454 745       -----       -----
>>> mips               1 500 097 569       -----       -----
>>> mipsel             1 502 804 063       -----       -----
>>> mips64             1 497 347 136       -----       -----
>>> mips64el           1 476 627 156       -----       -----
>>> ppc                1 667 589 417       -----       -----
>>> ppc64              1 779 203 387       -----       -----
>>> ppc64le            1 728 565 582       -----       -----
>>> riscv64            1 288 897 227       -----       -----
>>> s390x              2 113 929 796       -----       -----
>>> sh4                1 878 433 512       -----       -----
>>> sparc64            3 353 723 284       -----       -----
>>> x86_64             1 751 619 062       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: qsort_string
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 529 811 267       -----       -----
>>> alpha              1 793 314 577       -----       -----
>>> arm                7 155 792 109       -----       -----
>>> hppa               4 595 956 496       -----       -----
>>> m68k               2 294 974 463       -----       -----
>>> mips               2 113 124 208       -----       -----
>>> mipsel             2 110 049 468       -----       -----
>>> mips64             1 967 925 447       -----       -----
>>> mips64el           1 950 320 901       -----       -----
>>> ppc                2 428 056 923       -----       -----
>>> ppc64              2 404 890 978       -----       -----
>>> ppc64le            2 385 487 957       -----       -----
>>> riscv64            1 563 271 793       -----       -----
>>> s390x              3 934 075 315       -----       -----
>>> sh4                2 097 732 542       -----       -----
>>> sparc64            4 131 589 952       -----       -----
>>> x86_64             2 864 598 485       -----       -----
>>> --------------------------------------------------------
>>> --------------------------------------------------------
>>> Test Program: search_string
>>> --------------------------------------------------------
>>> Target              Instructions      Latest      v5.1.0
>>> ----------  --------------------  ----------  ----------
>>> aarch64            2 440 492 400       -----       -----
>>> alpha              1 634 401 901       -----       -----
>>> arm               11 242 966 409       -----       -----
>>> hppa               7 043 029 003       -----       -----
>>> m68k               1 936 892 588       -----       -----
>>> mips               1 624 778 552       -----       -----
>>> mipsel             1 627 783 657       -----       -----
>>> mips64             1 908 840 910       -----       -----
>>> mips64el           1 896 917 069       -----       -----
>>> ppc                2 267 493 386       -----       -----
>>> ppc64              2 484 527 533       -----       -----
>>> ppc64le            2 479 249 335       -----       -----
>>> riscv64            1 474 293 752       -----       -----
>>> s390x              5 439 366 376       -----       -----
>>> sh4                2 246 627 833       -----       -----
>>> sparc64            3 272 345 849       -----       -----
>>> x86_64             1 682 174 033       -----       -----
>>> --------------------------------------------------------
>>>
>>>
>>>
>>>

--000000000000a2e78b05ad78a9c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Mr. Aleksandar,<div dir=3D"auto"><br><div dir=3D"a=
uto">&quot;Reference&quot; and &quot;latest&quot; already each has its own =
results directory.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I wil=
l try re-running the tests tonight from scratch as you&#39;ve suggested to =
see how things will go.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I will also add the &quot;-------&quot; line at the beginning as you&#39;ve=
 suggested.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards=
,</div><div dir=3D"auto">Ahmed</div></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 22, 2020, 2:21 PM Ale=
ksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">ale=
ksandar.qemu.devel@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br><br>On Saturday, August 22, 2020, Aleksandar Markovic &lt;<a h=
ref=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_blank" rel=3D"nor=
eferrer">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><br><br>On Wednesday, August 19, 2020, Ahmed Karaman &lt;<a =
href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank" rel=3D"noref=
errer">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div><pre>Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.2=
0GHz
Host Memory      : 15.49 GB

Start Time (UTC) : 2020-08-19 21:00:01
End Time (UTC)   : 2020-08-19 21:32:15
Execution Time   : 0:32:14.021998

Status           : SUCCESS

--------------------------------------------------------</pre><pre><br></pr=
e></div></blockquote><div>I see we did not receive nightly report last nigh=
t. The cause is most likely the change of our build system that happened ye=
sterday.</div><div><br></div><div>I think the best approach for you is to s=
tart tonight &quot;from scratch&quot;. So, with source code tree and all pa=
st data deleted - as if you execute the nighlies for the first time ever. T=
his will cause a fresh checkout, and a recreation of 5.1 and &#39;latest&#3=
9; perfirmace data.</div><div><br></div></blockquote><div><br></div><div>So=
rry, I envision some problems with the approach I described. I think you sh=
ould better create a separate source directory for reference 5.1 measuremen=
ts, and another source directory for all measurements from tonight on. That=
 way you will avoid switching between build systems from within the same di=
rectory.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><b=
r></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
>Unrelated hint:</div><div><br></div><div>Please include the following (or =
similar) text right before the tables with results:</div><div><br></div><di=
v>&quot;&#39;-----&#39; denotes difference less than 0.01%.&quot;</div><div=
><br></div><div>This way the readers will not be confused with &#39;-----&#=
39; meaning.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div><pre><br></pre><pre><br></pr=
e><pre>            SUMMARY REPORT - COMMIT 672b2f26
--------------------------------------------------------
                    AVERAGE RESULTS
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 118 484 879       -----       -----
alpha              1 838 407 216       -----       -----
arm                7 887 992 884       -----       -----
hppa               4 124 996 474       -----       -----
m68k               2 453 421 671       -----       -----
mips               1 812 636 995       -----       -----
mipsel             1 947 725 352       -----       -----
mips64             1 862 495 613       -----       -----
mips64el           1 984 211 702       -----       -----
ppc                2 394 319 834       -----       -----
ppc64              2 488 040 622       -----       -----
ppc64le            2 470 198 016       -----       -----
riscv64            1 367 774 718       -----       -----
s390x              3 058 498 362       -----       -----
sh4                2 278 490 061       -----       -----
sparc64            3 186 999 246       -----       -----
x86_64             1 734 475 394       -----       -----
--------------------------------------------------------

                   DETAILED RESULTS
--------------------------------------------------------
Test Program: dijkstra_double
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            3 019 613 303       -----       -----
alpha              3 078 110 233       -----       -----
arm               15 982 079 823       -----       -----
hppa               7 012 014 505       -----       -----
m68k               3 914 631 319       -----       -----
mips               2 979 137 836       -----       -----
mipsel             3 141 391 810       -----       -----
mips64             3 163 713 203       -----       -----
mips64el           3 314 105 619       -----       -----
ppc                4 692 148 212       -----       -----
ppc64              4 875 585 404       -----       -----
ppc64le            4 859 857 200       -----       -----
riscv64            2 150 267 230       -----       -----
s390x              4 455 507 359       -----       -----
sh4                3 816 841 775       -----       -----
sparc64            4 399 783 149       -----       -----
x86_64             2 441 371 746       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: dijkstra_int32
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 177 687 656       -----       -----
alpha              1 462 693 182       -----       -----
arm                8 048 440 634       -----       -----
hppa               5 053 362 217       -----       -----
m68k               1 683 346 196       -----       -----
mips               1 473 265 047       -----       -----
mipsel             1 475 326 892       -----       -----
mips64             1 683 560 350       -----       -----
mips64el           1 663 467 060       -----       -----
ppc                1 978 581 291       -----       -----
ppc64              2 160 088 877       -----       -----
ppc64le            2 151 841 575       -----       -----
riscv64            1 323 226 597       -----       -----
s390x              2 880 509 792       -----       -----
sh4                1 938 787 291       -----       -----
sparc64            2 768 217 627       -----       -----
x86_64             1 521 726 675       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: matmult_double
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            1 408 042 295       -----       -----
alpha              3 009 129 018       -----       -----
arm                8 453 187 175       -----       -----
hppa               3 334 593 464       -----       -----
m68k               3 309 165 600       -----       -----
mips               2 252 644 394       -----       -----
mipsel             3 166 010 232       -----       -----
mips64             2 266 660 274       -----       -----
mips64el           3 179 408 969       -----       -----
ppc                3 108 563 525       -----       -----
ppc64              3 186 404 684       -----       -----
ppc64le            3 186 105 591       -----       -----
riscv64            1 218 230 013       -----       -----
s390x              2 715 954 030       -----       -----
sh4                3 330 300 193       -----       -----
sparc64            3 197 860 268       -----       -----
x86_64             1 244 922 914       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: matmult_int32
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64              595 215 814       -----       -----
alpha                369 955 794       -----       -----
arm                  735 842 738       -----       -----
hppa                 666 414 556       -----       -----
m68k                 406 857 412       -----       -----
mips                 497 082 899       -----       -----
mipsel               497 032 468       -----       -----
mips64               478 686 174       -----       -----
mips64el             462 210 845       -----       -----
ppc                  338 165 176       -----       -----
ppc64                390 046 801       -----       -----
ppc64le              390 236 162       -----       -----
riscv64              348 989 619       -----       -----
s390x                491 496 329       -----       -----
sh4                  399 095 487       -----       -----
sparc64              490 124 541       -----       -----
x86_64               399 613 899       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: qsort_double
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 645 742 637       -----       -----
alpha              1 899 562 379       -----       -----
arm                8 113 107 429       -----       -----
hppa               3 098 469 739       -----       -----
m68k               4 302 051 049       -----       -----
mips               2 060 965 462       -----       -----
mipsel             2 061 404 232       -----       -----
mips64             1 933 231 416       -----       -----
mips64el           1 930 636 000       -----       -----
ppc                2 673 960 745       -----       -----
ppc64              2 623 577 315       -----       -----
ppc64le            2 580 240 728       -----       -----
riscv64            1 575 021 518       -----       -----
s390x              2 437 147 903       -----       -----
sh4                2 520 101 855       -----       -----
sparc64            3 882 349 298       -----       -----
x86_64             1 969 776 338       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: qsort_int32
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 131 273 662       -----       -----
alpha              1 460 090 651       -----       -----
arm                3 372 526 755       -----       -----
hppa               2 196 131 815       -----       -----
m68k               1 779 454 745       -----       -----
mips               1 500 097 569       -----       -----
mipsel             1 502 804 063       -----       -----
mips64             1 497 347 136       -----       -----
mips64el           1 476 627 156       -----       -----
ppc                1 667 589 417       -----       -----
ppc64              1 779 203 387       -----       -----
ppc64le            1 728 565 582       -----       -----
riscv64            1 288 897 227       -----       -----
s390x              2 113 929 796       -----       -----
sh4                1 878 433 512       -----       -----
sparc64            3 353 723 284       -----       -----
x86_64             1 751 619 062       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: qsort_string
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 529 811 267       -----       -----
alpha              1 793 314 577       -----       -----
arm                7 155 792 109       -----       -----
hppa               4 595 956 496       -----       -----
m68k               2 294 974 463       -----       -----
mips               2 113 124 208       -----       -----
mipsel             2 110 049 468       -----       -----
mips64             1 967 925 447       -----       -----
mips64el           1 950 320 901       -----       -----
ppc                2 428 056 923       -----       -----
ppc64              2 404 890 978       -----       -----
ppc64le            2 385 487 957       -----       -----
riscv64            1 563 271 793       -----       -----
s390x              3 934 075 315       -----       -----
sh4                2 097 732 542       -----       -----
sparc64            4 131 589 952       -----       -----
x86_64             2 864 598 485       -----       -----
--------------------------------------------------------
--------------------------------------------------------
Test Program: search_string
--------------------------------------------------------
Target              Instructions      Latest      v5.1.0
----------  --------------------  ----------  ----------
aarch64            2 440 492 400       -----       -----
alpha              1 634 401 901       -----       -----
arm               11 242 966 409       -----       -----
hppa               7 043 029 003       -----       -----
m68k               1 936 892 588       -----       -----
mips               1 624 778 552       -----       -----
mipsel             1 627 783 657       -----       -----
mips64             1 908 840 910       -----       -----
mips64el           1 896 917 069       -----       -----
ppc                2 267 493 386       -----       -----
ppc64              2 484 527 533       -----       -----
ppc64le            2 479 249 335       -----       -----
riscv64            1 474 293 752       -----       -----
s390x              5 439 366 376       -----       -----
sh4                2 246 627 833       -----       -----
sparc64            3 272 345 849       -----       -----
x86_64             1 682 174 033       -----       -----
--------------------------------------------------------


</pre></div>
</blockquote>
</blockquote>
</blockquote></div>

--000000000000a2e78b05ad78a9c2--

