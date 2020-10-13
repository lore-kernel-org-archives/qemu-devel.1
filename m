Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A1F20776
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A1F20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIhO-0001XX-Hz
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIfA-0000VU-ID; Tue, 13 Oct 2020 07:40:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIf8-0003Pp-I5; Tue, 13 Oct 2020 07:40:16 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MN5aF-1kib9x1kEn-00J6KK; Tue, 13 Oct 2020 13:40:08 +0200
Subject: Re: [PULL 00/15] Trivial branch for 5.2 patches
To: Thomas Huth <thuth@redhat.com>
References: <20201013065313.7349-1-laurent@vivier.eu>
 <CAFEAcA81HdRLh25MoC+=ZS7TERAzbZt_Ns+-Lp=oZFL69nMsoA@mail.gmail.com>
 <f22fbab6-9b09-341c-98c8-0832e29de1a5@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b27a2faa-15d0-fe28-a758-537e5fdeb94c@vivier.eu>
Date: Tue, 13 Oct 2020 13:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f22fbab6-9b09-341c-98c8-0832e29de1a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eA7dZ3Wug42z3mv7/6w4yqfHMITYRn+y/FrRfGdyHleOcr5TfX6
 iqkRmJOP8FJQXvrcxYDEEHonhtUlJ/TAP/hbn9T7272n9Ur/LR/Q/4DzZ1gimBrqcteOsjL
 fCFLz6HmtBahONjzdifMW6ScR9jXUa2pT6H3QvRM9t9So7HRFqduNszGtaGFRUWTsYLjz92
 qWu16Wx6qmB50MVWzlfkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qvs9yW0HTPY=:z/+e1KTZ5vXFWE83o5Sb2E
 R5qOAgMPWOx6XDSNMk0V3/FSBNMglWpBGl454la07RvCGhWwGy6rP3XXe1ZTKzHU0jR9wz6G3
 mDXJ5E+9DfZPTkEvc1XmaSx08Eala4tE1YUq3aX8UZsEngX6QhbAskPrroSWkqHrnyzQdBWPY
 yL4Wx90Srng1d5LACu1QOl7pTHUbrMpF4kn44XEul2nVMi234IuIm38iocN0yN0jYUAbqtmvU
 eHlzoOlLsaAsIkW3cGH/WuVvaMrezvk708fjigKaDlWHkApr4YbwljLzWUfTKMuYw9s04tFwt
 SyIjdIjxJeuedMXM+S3I7feG5NC9dMlKjVvRQS0zJYgdZsdVdkN9uWqS3Q1Yt8MZoI6kwIqst
 5WRZIdDlbKFohUbos/OfxymVwi6ckJPPmYBU/2Z11wdGMvn4zsPKk7FHvS9xSN7UDoeAyr0aW
 B66RSCxjfBmBFqdLHzhVa+5TccSsIiqeops8rtXMlqtleob476xXaNIlSzRG/XHj5fr/KvG3q
 cWHA8ieHpU9YHrsCkKZuJd+luy7bBWkW6jVGYfTGXGbGgXU1WQBqthkIBcMwIFTOvWH/IJ3eK
 5E5xUExJWGDoas5UGwd369vIHjnWfeHfq58WVMgSD01MeLDQYxlM/Wp/DDYK7UZuZnC9tGSLu
 JL25IbLUux1Itap6agfTycso2c+vmMpLw70hSt2e8fi/ESUOngWfYbQ/vU6Tsk6fo99N4M5j0
 EQ/9He+1lKkAUL9tNaYsyHkGsRmk/841fvHS3KqbSZKWxQiVaA3uHt5lxuwNYRy7OCA4lRRUi
 +nmplNIznaoMYT5Ad+S9chF9gt+5XPgCSNCI3hcgnaPS9hVLC6rCsJ3xrWRHxKokydpWBko
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:40:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/10/2020 à 13:34, Thomas Huth a écrit :
> On 13/10/2020 13.06, Peter Maydell wrote:
>> On Tue, 13 Oct 2020 at 07:56, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54:
>>>
>>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' int=
>>> o staging (2020-10-12 11:29:42 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>>>
>>> for you to fetch changes up to ef3a1d9fc36140f8933fbced70ee21fd9740b33c:
>>>
>>>   meson.build: drop duplicate 'sparc64' entry (2020-10-12 23:11:32 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Trivial Patches Pull request 20201013
>>>
>>> ----------------------------------------------------------------
>>
>> Compile failure on ppc64be:
>>
>> ../../hw/rtc/twl92230.c: In function ‘menelaus_rx’:
>> ../../hw/rtc/twl92230.c:289:23: error: array subscript is above array
>> bounds [-Werror=array-bounds]
>>          return s->dcdc[addr - MENELAUS_VCORE_CTRL1];
> 
> Uh, oh, mea culpa, copy-n-paste error... that should have been
> MENELAUS_DCDC_CTRL1 instead.
> Laurent, could you fix it up, or shall I send a v2 of the patch?

I prefere a v2, I don't like to play with patches in a pull request.

Thanks,
Laurent

