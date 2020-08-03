Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7699F2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmDyO1nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7699F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZN0-0004FH-GA
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k2ZMO-0003ia-G7; Mon, 03 Aug 2020 08:14:32 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:43981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k2ZML-0003MA-DA; Mon, 03 Aug 2020 08:14:32 -0400
Received: by mail-qv1-xf43.google.com with SMTP id l13so10816493qvt.10;
 Mon, 03 Aug 2020 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bRpzTYEBzHW43osqBU+AT3Z5PV6cfhhzPaJRxnoPWvo=;
 b=tmDyO1nqHHAmYaEabPzm214vNQHGV7mtHN3SjjMR1IOE1YN5yhsqSutR57OHJ3tLB0
 HGp8U8HTWJMJmnl+sW9EjnGo5XRIgie2PuxTXCGb0+gMo4IcuEXEXf3AJx3ZfiOqPjvc
 DHEY/fFUjdgmyDijnfQJthht2t2Dk6W+W+uOeYmmxB5rZZQirxgclIYbvED+AJhk/woC
 uPgwDb6WO421lqbMW27oQmTuGdibUN2UHr22PVvd3adtsIQzvcVcpE+uIY/zSKA8Wqe1
 2sUBem9MJCDOpGdeA0WELYOPrCLklSHLSAwpjVwPrBoHrK8wY/J1Onhgl2eh/cas0MAE
 copA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRpzTYEBzHW43osqBU+AT3Z5PV6cfhhzPaJRxnoPWvo=;
 b=DvWPkiNeBNfAkbGWEK0kv0oP9cD8NeBS9Q7ET7+aCMahPxk8JDxSXgY5RjKiL5mX7M
 /tlAz6mQ9c/xUyYjWzDlQ2BzJwdxjFrQyoq4HKwrk34y5I+jX4R9nvb8/qy+Q10cMcmN
 0NE3AqJO+CiK2uBpFSZ55fTlHXTeUtjKLwj5Uhtd5iIJv3rQYz0oNRbdD4TNSoFVpr6Y
 MQwAtufdPN6L0sHZB4fs08RYPjdhWQjMDUZj77BKY62Z8gu0ugD8KsQ7YnBIXTYHSvcv
 JoucF7UyBlfHxoWVB2HA7Os6KptMJayqtWI1ryEsgBTRcagORLI1OJoV1OUbtXqylXnT
 7Ybg==
X-Gm-Message-State: AOAM5302TI7McfAlvn/soXIvWGc78/Uoasj979xNwiVZgy6+DTHc5dAf
 ozHEntcbW0Hhc1sQYZLO6P+Pt3bV
X-Google-Smtp-Source: ABdhPJxjqEdLj2Ck3IYbl4z3wNbD1bZPS36LUpEhdJu+tmulvd9AB1jWkxnqSbtK3eyFfdj0vHWlAw==
X-Received: by 2002:a0c:9cc4:: with SMTP id j4mr15860492qvf.230.1596456866929; 
 Mon, 03 Aug 2020 05:14:26 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:fea0:f34f:387b:ebfa:f155?
 ([2804:431:c7c7:fea0:f34f:387b:ebfa:f155])
 by smtp.gmail.com with ESMTPSA id y5sm12361804qkc.23.2020.08.03.05.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 05:14:26 -0700 (PDT)
Subject: Re: [PATCH 1/1] docs: adding NUMA documentation for pseries
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20200729125756.224846-1-danielhb413@gmail.com>
 <20200730005852.GN84173@umbus.fritz.box> <20200803134917.48c5e7a5@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <8985209a-427b-1ec5-7d90-6a760e58f1cd@gmail.com>
Date: Mon, 3 Aug 2020 09:14:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803134917.48c5e7a5@bahia.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/3/20 8:49 AM, Greg Kurz wrote:
> On Thu, 30 Jul 2020 10:58:52 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Wed, Jul 29, 2020 at 09:57:56AM -0300, Daniel Henrique Barboza wrote:
>>> This patch adds a new documentation file, ppc-spapr-numa.rst,
>>> informing what developers and user can expect of the NUMA distance
>>> support for the pseries machine, up to QEMU 5.1.
>>>
>>> In the (hopefully soon) future, when we rework the NUMA mechanics
>>> of the pseries machine to at least attempt to contemplate user
>>> choice, this doc will be extended to inform about the new
>>> support.
>>>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>
>> Applied to ppc-for-5.2, thanks.
>>
> 
> I'm now hitting this:
> 
> Warning, treated as error:
> docs/specs/ppc-spapr-numa.rst:document isn't included in any toctree

How are you hitting this? I can't reproduce this error. Tried running
./autogen.sh and 'make' and didn't see it.

Checking what other docs are doing I figure that this might be missing:

$ git diff
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 426632a475..1b0eb979d5 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -12,6 +12,7 @@ Contents:
  
     ppc-xive
     ppc-spapr-xive
+   ppc-spapr-numa
     acpi_hw_reduced_hotplug
     tpm
     acpi_hest_ghes



Can you please check if this solves the error?



Thanks,


Daniel

> 
>>> ---
>>>   docs/specs/ppc-spapr-numa.rst | 191 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 191 insertions(+)
>>>   create mode 100644 docs/specs/ppc-spapr-numa.rst
>>>
>>> diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
>>> new file mode 100644
>>> index 0000000000..e762038022
>>> --- /dev/null
>>> +++ b/docs/specs/ppc-spapr-numa.rst
>>> @@ -0,0 +1,191 @@
>>> +
>>> +NUMA mechanics for sPAPR (pseries machines)
>>> +============================================
>>> +
>>> +NUMA in sPAPR works different than the System Locality Distance
>>> +Information Table (SLIT) in ACPI. The logic is explained in the LOPAPR
>>> +1.1 chapter 15, "Non Uniform Memory Access (NUMA) Option". This
>>> +document aims to complement this specification, providing details
>>> +of the elements that impacts how QEMU views NUMA in pseries.
>>> +
>>> +Associativity and ibm,associativity property
>>> +--------------------------------------------
>>> +
>>> +Associativity is defined as a group of platform resources that has
>>> +similar mean performance (or in our context here, distance) relative to
>>> +everyone else outside of the group.
>>> +
>>> +The format of the ibm,associativity property varies with the value of
>>> +bit 0 of byte 5 of the ibm,architecture-vec-5 property. The format with
>>> +bit 0 equal to zero is deprecated. The current format, with the bit 0
>>> +with the value of one, makes ibm,associativity property represent the
>>> +physical hierarchy of the platform, as one or more lists that starts
>>> +with the highest level grouping up to the smallest. Considering the
>>> +following topology:
>>> +
>>> +::
>>> +
>>> +    Mem M1 ---- Proc P1    |
>>> +    -----------------      | Socket S1  ---|
>>> +          chip C1          |               |
>>> +                                           | HW module 1 (MOD1)
>>> +    Mem M2 ---- Proc P2    |               |
>>> +    -----------------      | Socket S2  ---|
>>> +          chip C2          |
>>> +
>>> +The ibm,associativity property for the processors would be:
>>> +
>>> +* P1: {MOD1, S1, C1, P1}
>>> +* P2: {MOD1, S2, C2, P2}
>>> +
>>> +Each allocable resource has an ibm,associativity property. The LOPAPR
>>> +specification allows multiple lists to be present in this property,
>>> +considering that the same resource can have multiple connections to the
>>> +platform.
>>> +
>>> +Relative Performance Distance and ibm,associativity-reference-points
>>> +--------------------------------------------------------------------
>>> +
>>> +The ibm,associativity-reference-points property is an array that is used
>>> +to define the relevant performance/distance  related boundaries, defining
>>> +the NUMA levels for the platform.
>>> +
>>> +The definition of its elements also varies with the value of bit 0 of byte 5
>>> +of the ibm,architecture-vec-5 property. The format with bit 0 equal to zero
>>> +is also deprecated. With the current format, each integer of the
>>> +ibm,associativity-reference-points represents an 1 based ordinal index (i.e.
>>> +the first element is 1) of the ibm,associativity array. The first
>>> +boundary is the most significant to application performance, followed by
>>> +less significant boundaries. Allocated resources that belongs to the
>>> +same performance boundaries are expected to have relative NUMA distance
>>> +that matches the relevancy of the boundary itself. Resources that belongs
>>> +to the same first boundary will have the shortest distance from each
>>> +other. Subsequent boundaries represents greater distances and degraded
>>> +performance.
>>> +
>>> +Using the previous example, the following setting reference points defines
>>> +three NUMA levels:
>>> +
>>> +* ibm,associativity-reference-points = {0x3, 0x2, 0x1}
>>> +
>>> +The first NUMA level (0x3) is interpreted as the third element of each
>>> +ibm,associativity array, the second level is the second element and
>>> +the third level is the first element. Let's also consider that elements
>>> +belonging to the first NUMA level have distance equal to 10 from each
>>> +other, and each NUMA level doubles the distance from the previous. This
>>> +means that the second would be 20 and the third level 40. For the P1 and
>>> +P2 processors, we would have the following NUMA levels:
>>> +
>>> +::
>>> +
>>> +  * ibm,associativity-reference-points = {0x3, 0x2, 0x1}
>>> +
>>> +  * P1: associativity{MOD1, S1, C1, P1}
>>> +
>>> +  First NUMA level (0x3) => associativity[2] = C1
>>> +  Second NUMA level (0x2) => associativity[1] = S1
>>> +  Third NUMA level (0x1) => associativity[0] = MOD1
>>> +
>>> +  * P2: associativity{MOD1, S2, C2, P2}
>>> +
>>> +  First NUMA level (0x3) => associativity[2] = C2
>>> +  Second NUMA level (0x2) => associativity[1] = S2
>>> +  Third NUMA level (0x1) => associativity[0] = MOD1
>>> +
>>> +  P1 and P2 have the same third NUMA level, MOD1: Distance between them = 40
>>> +
>>> +Changing the ibm,associativity-reference-points array changes the performance
>>> +distance attributes for the same associativity arrays, as the following
>>> +example illustrates:
>>> +
>>> +::
>>> +
>>> +  * ibm,associativity-reference-points = {0x2}
>>> +
>>> +  * P1: associativity{MOD1, S1, C1, P1}
>>> +
>>> +  First NUMA level (0x2) => associativity[1] = S1
>>> +
>>> +  * P2: associativity{MOD1, S2, C2, P2}
>>> +
>>> +  First NUMA level (0x2) => associativity[1] = S2
>>> +
>>> +  P1 and P2 does not have a common performance boundary. Since this is a one level
>>> +  NUMA configuration, distance between them is one boundary above the first
>>> +  level, 20.
>>> +
>>> +
>>> +In a hypothetical platform where all resources inside the same hardware module
>>> +is considered to be on the same performance boundary:
>>> +
>>> +::
>>> +
>>> +  * ibm,associativity-reference-points = {0x1}
>>> +
>>> +  * P1: associativity{MOD1, S1, C1, P1}
>>> +
>>> +  First NUMA level (0x1) => associativity[0] = MOD0
>>> +
>>> +  * P2: associativity{MOD1, S2, C2, P2}
>>> +
>>> +  First NUMA level (0x1) => associativity[0] = MOD0
>>> +
>>> +  P1 and P2 belongs to the same first order boundary. The distance between then
>>> +  is 10.
>>> +
>>> +
>>> +How the pseries Linux guest calculates NUMA distances
>>> +=====================================================
>>> +
>>> +Another key difference between ACPI SLIT and the LOPAPR regarding NUMA is
>>> +how the distances are expressed. The SLIT table provides the NUMA distance
>>> +value between the relevant resources. LOPAPR does not provide a standard
>>> +way to calculate it. We have the ibm,associativity for each resource, which
>>> +provides a common-performance hierarchy,  and the ibm,associativity-reference-points
>>> +array that tells which level of associativity is considered to be relevant
>>> +or not.
>>> +
>>> +The result is that each OS is free to implement and to interpret the distance
>>> +as it sees fit. For the pseries Linux guest, each level of NUMA duplicates
>>> +the distance of the previous level, and the maximum amount of levels is
>>> +limited to MAX_DISTANCE_REF_POINTS = 4 (from arch/powerpc/mm/numa.c in the
>>> +kernel tree). This results in the following distances:
>>> +
>>> +* both resources in the first NUMA level: 10
>>> +* resources one NUMA level apart: 20
>>> +* resources two NUMA levels apart: 40
>>> +* resources three NUMA levels apart: 80
>>> +* resources four NUMA levels apart: 160
>>> +
>>> +
>>> +Consequences for QEMU NUMA tuning
>>> +---------------------------------
>>> +
>>> +The way the pseries Linux guest calculates NUMA distances has a direct effect
>>> +on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, this is
>>> +the default ibm,associativity-reference-points being used in the pseries
>>> +machine:
>>> +
>>> +ibm,associativity-reference-points = {0x4, 0x4, 0x2}
>>> +
>>> +The first and second level are equal, 0x4, and a third one was added in
>>> +commit a6030d7e0b35 exclusively for NVLink GPUs support. This means that
>>> +regardless of how the ibm,associativity properties are being created in
>>> +the device tree, the pseries Linux guest will only recognize three scenarios
>>> +as far as NUMA distance goes:
>>> +
>>> +* if the resources belongs to the same first NUMA level = 10
>>> +* second level is skipped since it's equal to the first
>>> +* all resources that aren't a NVLink GPU, it is guaranteed that they will belong
>>> +  to the same third NUMA level, having distance = 40
>>> +* for NVLink GPUs, distance = 80 from everything else
>>> +
>>> +In short, we can summarize the NUMA distances seem in pseries Linux guests, using
>>> +QEMU up to 5.1, as follows:
>>> +
>>> +* local distance, i.e. the distance of the resource to its own NUMA node: 10
>>> +* if it's a NVLink GPU device, distance: 80
>>> +* every other resource, distance: 40
>>> +
>>> +This also means that user input in QEMU command line does not change the
>>> +NUMA distancing inside the guest for the pseries machine.
>>
> 

