Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAAFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24D120637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24D120637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBe7N-0000PA-RF
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBe6c-0007p2-Db
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBe6b-0008L5-54
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:35:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBe6V-0007wZ-8H; Tue, 10 Mar 2020 08:35:23 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McXs5-1jlWfn0Gx3-00d0AR; Tue, 10 Mar 2020 13:34:34 +0100
Subject: Re: [PULL 00/33] Trivial branch patches
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
 <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
 <0bb2eac1-74ab-bee8-e8d0-bac542562cdd@vivier.eu>
 <20200310114548.GA6926@linux.fritz.box>
 <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
 <20200310121300.GD6926@linux.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <28fb5e38-48c1-e640-90d2-830924ad93d3@vivier.eu>
Date: Tue, 10 Mar 2020 13:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310121300.GD6926@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qPob5bEhxxf2oCVXsTbluzu1WU+AQrrkifSiGqobVrxhsys/OtP
 ryZ4/C5bvOmzc+UP8oiWHmPgxFtXXE9pDMnsiup+l1F8YqlScZoh9uMukHPzDFOWWyhotGf
 zu72Cevt1vCkrmaw52cK91GiSqx7950cZRRP1U6El19F32NQci2KlC9ST0WcSkMTzisGYw4
 Ngg8HTrern4qb8Ai3eccA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9+upii/4B0=:oC45h7Z1mZynwAEsAFOGKS
 iQ6Ukc/r9TLf7pWDUUcVLajK727W5bvK5N4IXQswLJQHiuF/ylZAlElXDE49es1zy8XtZ4qdj
 Nn2FRoLcXtQ2owh1cBrEDMW/QPIFXEYfiA6lE/WX+JxERgX9ObcRbCp24YqfmSDezgb3woghl
 YN71HwCrG9WV0B5rUMPvUFl2l5xLcekYofIWnEAs+guDHNJgjD3kUhgZNTS5i9U0HEoZqEI6P
 bo+nQYgE8jLO8Q/dgu5ii49+EA2h/iBR5aIG63WYfhbH5udZkNzsr7Jng7c5JNGF4mjOypWll
 pT/3MtFboKJ7az8JCMrhCvi+eUda6NbXvtCg22XrRfvq42OfHRdsfvCc/v0uWhjNeSU2nA/R4
 gZcvDCIgCkZ8sGdML3e0x8dH2CpiIO0/wDeHWfAOBQbCphWDMgxNalImbMlJqE51RMKpUCCr9
 UfYc67Kr7L5AkNYFOImOcdycPXJfrTLvF/GZXY4zCRiVV9q7ysmC0zsylS+mRZ+0RESQVfkHZ
 fkm8RtDaP9jz4DpZL7gX37mpl1uoe19iUtdIhWJZdPJWCtO/WcVicjPoV6Ije1o2n/aSukSQJ
 CHM1GG0CHUIcZGSMBKvg9ISVsp57uuUqpv4Q2ZvaJtc6nf0psUXXljYn//m0YD9Rw/dMHkmQK
 OFABbKlIROZqnLd4FktmNEp0pCStGpi0cFjy5QkocpcIkCUVnjZjYH/MvP8KSc4ioIA/nw5F9
 f4h91Gfb77ClnLqVnL1009+2B1VQM4dXC07VVgG9vs5oXV2mCI45+EC8bu7wyFyJsZker2upP
 nB/vE1wSuU0N9k4KS9leX8HFwoybcURdjvHPUrAEieAHbJUu8GP28zIdJM8zyfSIjyUUfNm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 13:13, Kevin Wolf a écrit :
> Am 10.03.2020 um 13:00 hat Philippe Mathieu-Daudé geschrieben:
>> On 3/10/20 12:45 PM, Kevin Wolf wrote:
>>> Am 10.03.2020 um 09:02 hat Laurent Vivier geschrieben:
>>>> Le 09/03/2020 à 20:30, Philippe Mathieu-Daudé a écrit :
>>>>> On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
>>>>>> On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
>>>>>>> The following changes since commit
>>>>>>> 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
>>>>>>>
>>>>>>>     Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into
>>>>>>> staging (2020-03-09 10:32:53 +0000)
>>>>>>>
>>>>>>> are available in the Git repository at:
>>>>>>>
>>>>>>>     git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>>>>>>
>>>>>>> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636bb:
>>>>>>>
>>>>>>>     monitor/hmp-cmds: Remove redundant statement in
>>>>>>> hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
>>>>>>
>>>>>>
>>>>>> Could you avoid CC everyone involved on the whole PULL req?
>>>>>> I was involved in a patch or two and don't really need to see
>>>>>> the whole series. Just the cover and the relevant patches
>>>>>> would be enough - if I do want it there's always lore.
>>>>>
>>>>> I suppose Laurent used git-publish, which has this limitation.
>>>>>
>>>>
>>>> Yes, I use git publish and CC are automatically added.
>>>>
>>>> Philippe, you told me some time ago you have a patch to fix this
>>>> behaviour and only CC people on a patch base. Is it available?
>>
>> I guess you mean https://github.com/philmd/git-publish/commit/5bab6e2cc77, I
>> haven't improved it but plan to spend time on it during my next holidays.
>>
>>> Actually, I don't think it's even necessary to CC anyone at all (except
>>> the relevant lists) for pull requests. These patches were already
>>> reviewed.
>>
>> Well as a contributor I find useful to get notified when patches are merged.
> 
> Hm, I guess a matter of different preferences then.
> 
>> I guess remember some time ago patchew (or another bot?) was sending a
>> notification on pull request merged, this was even more useful than Cc'ing
>> ppl on pull-req. It is also helpful when you track someone else patch on the
>> list.
>> Since most of the maintainers now include the patch RFC822 Message-Id, it is
>> now easy for a bot to reply to patch taken from the last.
> 
> I don't remember anything like this, but having an automatic reply to
> the email thread of each merged patch series might be a good idea.

I receive an email for each merge [1]

There is a mailing list for that:

https://lists.nongnu.org/mailman/listinfo/qemu-commits

Thanks,
Laurent

[1] https://lists.nongnu.org/archive/html/qemu-commits/2020-03/index.html

