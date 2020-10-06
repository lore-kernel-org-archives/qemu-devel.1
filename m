Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8716C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A17920760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A17920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPnkn-00073q-0d
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1kPnjp-0006da-Mq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:14:45 -0400
Received: from gecko.sbs.de ([194.138.37.40]:48893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1kPnjn-0003Wf-4J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:14:44 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 096EEVk4006324
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2020 16:14:31 +0200
Received: from [167.87.130.37] ([167.87.130.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 096EE4w7026867;
 Tue, 6 Oct 2020 16:14:06 +0200
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
 <87eemc3b1q.fsf@linaro.org>
 <alpine.DEB.2.21.2010052047250.11145@digraph.polyomino.org.uk>
 <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
 <878scj3cyv.fsf@linaro.org> <bbe2408e-75bd-1a72-7d5e-acde1a5d5e21@amsat.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d09a6b2f-b7a3-f111-1aa8-9a573b94e2fd@siemens.com>
Date: Tue, 6 Oct 2020 16:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bbe2408e-75bd-1a72-7d5e-acde1a5d5e21@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.138.37.40;
 envelope-from=jan.kiszka@siemens.com; helo=gecko.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 10:14:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>, qemu-devel@nongnu.org,
 Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>,
 Thomas Schwinge <thomas@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.10.20 14:41, Philippe Mathieu-Daudé wrote:
> On 10/6/20 11:44 AM, Alex Bennée wrote:
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 05.10.20 22:52, Joseph Myers wrote:
>>>> On Mon, 5 Oct 2020, Alex Bennée wrote:
>>>>
>>>>> Joseph Myers <joseph@codesourcery.com> writes:
>>>>>
>>>>>> On Sun, 4 Oct 2020, Philippe Mathieu-Daudé wrote:
>>>>>>
>>>>>>> There is a number of contributors from this domain,
>>>>>>> add its own entry to the gitdm domain map.
>>>>>>
>>>>>> At some point the main branding will be Siemens; not sure how you want to 
>>>>>> handle that.
>>>>>
>>>>> We've already done something similar with WaveComp who have rolled up
>>>>> the various mips and imgtec contributions into
>>>>> contrib/gitdm/group-map-wavecomp.
>>>>>
>>>>> It's really up to you and which corporate entity would like internet
>>>>> bragging points. The only Siemens contributor I could find is Jan Kiszka
>>>>> but he has contributed a fair amount ;-)
>>>>
>>>> Given that the Mentor branding is going away (and the "Mentor Graphics" 
>>>> version largely has gone away, "Mentor, a Siemens Business" is what's 
>>>> currently used as a Mentor brand), probably it makes sense to use Siemens 
>>>> for both codesourcery.com and mentor.com addresses.
>>>>
>>>
>>> I think the key question is what this map is used for: Is it supposed to
>>> document the historic status, who was who at the time of contribution?
>>> Or is its purpose to help identifying the copyright holder of a
>>> contribution today?
>>
>> I don't know what others use them for but for me it was just an easy way
>> to get a survey of the companies and individuals involved over the last
>> year (2y, 3y, 5y... etc) of development.
> 
> My personal interest is seeing how the corporate/academic/hobbyist
> contributions are split, and how this evolves over time.
> 
> Since there were entries for some companies, I added more,
> but this is not a requisite and we can drop the patches if
> considered not useful or giving headaches to the contributors.
> 
>> The consolidation of
>> contributions isn't overly distorting IMO. The biggest user is probably
>> the end of year state of the nation surveys wanting to see what impact
>> various organisations are having on a project and consolidation just
>> helps push you up the table a little more.
>>
>> The biggest counter example we have at the moment is RedHat/IBM which
>> AFAICT is because the RedHat guys are treated as a separate business
>> unit with their own unique identity.
>>
>> Either way I don't think it's a major issue - hence it is up to the
>> hackers to make the choice.
> 
> Totally. In this particular case, we could even keep "Codesourcery"
> group separate, similarly to RH/IBM.
> 

If there is a way to express also timeline, then I would keep the
historic contributions separate and account those since the merger
(April 2017) to Siemens. You may even consider adding also the phase
when Codesourcery was owned by Mentor.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

