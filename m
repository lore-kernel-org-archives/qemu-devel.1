Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF634C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0144208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0144208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaRW-0005Xq-1S
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBaQl-00057b-Cr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBaQk-00039N-7P
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:03 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBaQj-00030a-Ud
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNKuI-1izxQV09DG-00Oskk; Tue, 10 Mar 2020 09:39:49 +0100
To: unai.martinezcorral@ehu.eus, Eric Blake <eblake@redhat.com>
References: <20200309191200.GA60@669c1c222ef4>
 <20200309191846.GA65@669c1c222ef4>
 <9f03379d-f4fa-2ac4-409f-123222233cf4@redhat.com>
 <CAGZZdDHj6nA78YYXNOpncOTQSNqWKLwTXY_ppU+REikCQcpRtQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v10 01/10] qemu-binfmt-conf.sh: enforce style consistency
Message-ID: <5e41fff2-20af-c4b1-5d57-26da7f08a57c@vivier.eu>
Date: Tue, 10 Mar 2020 09:39:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGZZdDHj6nA78YYXNOpncOTQSNqWKLwTXY_ppU+REikCQcpRtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y8eKvHDkh52l1McAtke3sUeIkZ+CLLoN2oGUNkWe/plm/ELbG+Q
 EuvEclyZpc34WZRVQvh/9SrrBXIsn4GIyFCN9vjbpmAaiSBhYB2Iy0Phs3dxh3j/XB3RozF
 jcGXZWZ2BTFDSnxEdEPJtHvcVa5UCaOa7mBNbsbVjAQDp/aagvKzUaZdXx1IqxDmss/i3xp
 ww1cIDh5INT4VA1ootJwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sDQXzaht94c=:T7C9QxjDYwz1dEhOb2HA7e
 Sh2EEZiiK/ngMYBd2TcPSPIUPuPkXS6S9+ST+/7B1qr8UYE5v5SEbpkiUqbr15Efp4hvKmzAv
 fVyZITqWEpSz95z4rtVTNB7NBt0LFBtPgjs59I9m63R0fPVY2qjWUu/SSZzdVTIateWluYr6o
 /Sd64+EugwNMMveyM1iw4waI8Agpp0Y3hnG8RqWlVhG47/DSc3xryWi8Ar6kCyIEMUmZHa8TG
 8GWnXOoXBFsDAmi4Tc/BLIOJa3ZHi3SRlClPQqGDKGHzBanf+vz/kVBub2wxhZO3GuQ/GW4YH
 M1mSy+Azgld375vMGgv7jdyCkb6G9ZGy8PMhkNMH/WHSpPtiQ4Sf9UDFp5+uoFO31NrdQBEM5
 jlgbJIVGYcwrg1tCzky2DAiz2mQyCiOu/4BCOHAbU/ni91eenX4+4eB/tHy1uawEEGgHBePFA
 n95hlAYW730KLhpsM35Mkzj2pcf4iRAMBRsbnb/2aV7BnGaOQm4ShShKRq6TqwxPr9Xz/AWhH
 QEGrLErPlgE4+en14+ObeSdath2DqpE6912WL/dA3+fRU0Ivzl0ocqZ7btbXWwcP3N0bK/fra
 BeyM2m8Gl1lcEhi+u77n4TVFvrQokiYvW+hkmqpIMSJinevEKxRgLzj5AxJLTwWeIDPFodagN
 GxOrc+Y7qxjKb8FxKpfKjc0O/kJxY1iOAjikVhrzN35dk2k0TXLAFpykTgWFavKewwBAbbEqx
 QgYS2pW0c9qdKoMuvWMCFZ3i6QvwgaY82SdDcjtvBEyh7/+WHGYQIzY9e2sUR6RyWhnAw+Yrh
 0rWeUg4LsZzxFWoGREH4YE3/fDc5ukq2DSrb3mlt7BYyWEc3QDLLQPkXDbA6sfSZD7qAs3e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 20:36, Unai Martinez Corral a écrit :
> 2020/3/9 20:30, Eric Blake:
> 
>     On 3/9/20 2:18 PM, Unai Martinez-Corral wrote:
>     > Spaces are removed before '; then', for consistency with other scripts
>     > in the project.
>     >
>     > Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
>     > Reviewed-by: Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>>
> 
>     Technically, since this change is different than what Laurent
>     previously
>     reviewed, it might have been better to drop the R-b to make sure
>     everything is still okay.  But I'll let Laurent chime in, no need to
>     respin just yet.
> 
> 
> Thanks for clarifying. Honestly, I was not sure about how to proceed.
> 

Yes, it's better to drop the R-b if you change something that could
impact the review.

But this patch seems good, so you can let my R-b now.

Thanks,
Laurent

