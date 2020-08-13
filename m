Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB21EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA7E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA7E2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6DTb-0005Wm-D0
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.brodsky@arm.com>)
 id 1k6A3D-0000FR-Tp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:01:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45424)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.brodsky@arm.com>) id 1k6A3A-000396-Sr
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:01:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 530B131B;
 Thu, 13 Aug 2020 03:01:29 -0700 (PDT)
Received: from [192.168.178.35] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911193F70D;
 Thu, 13 Aug 2020 03:01:27 -0700 (PDT)
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Evgenii Stepanov <eugenis@google.com>,
 Andrey Konovalov <andreyknvl@google.com>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
 <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
 <CAAeHK+zD3ZdjpZOBny3QuYtKe-qzhmEfd9w+nr3NrzEuzHHRvw@mail.gmail.com>
 <CAFKCwrjSU89jiUbzd8Ys8nV6NDCJer=FbUnGWv8m0p0E+9MdVg@mail.gmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <f3e2717b-878c-f6cf-51dc-fe2c372a7b41@arm.com>
Date: Thu, 13 Aug 2020 11:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFKCwrjSU89jiUbzd8Ys8nV6NDCJer=FbUnGWv8m0p0E+9MdVg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------B662C6CCBE1B4141BC04C887"
Content-Language: en-GB
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=kevin.brodsky@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 05:05:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Aug 2020 09:37:10 -0400
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
Cc: peter.maydell@linaro.org, Branislav Rankov <Branislav.Rankov@arm.com>,
 Elena Petrova <lenaptr@google.com>, Peter Collingbourne <pcc@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Kostya Serebryany <kcc@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, alex.bennee@linaro.org,
 Dmitry Vyukov <dvyukov@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------B662C6CCBE1B4141BC04C887
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2020 20:06, Evgenii Stepanov wrote:
> On Wed, Aug 12, 2020 at 11:03 AM Andrey Konovalov <andreyknvl@google.com 
> <mailto:andreyknvl@google.com>> wrote:
>
>     On Wed, Aug 12, 2020 at 7:52 PM Richard Henderson
>     <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
>     >
>     > On 8/12/20 10:38 AM, Andrey Konovalov wrote:
>     > > On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
>     > > <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
>     > >>
>     > >> As reported by Andrey, I was missing the complete ISS info for
>     > >> the Data Abort raised upon a synchronous tag check fail.
>     > >>
>     > >> The following should fix that.  All the twisty little rules for
>     > >> the ISS.ISV bit are already handled by merge_syn_data_abort.
>     > >> Probably the most important bit that was missing was ISS.WnR,
>     > >> as that is independent of ISS.ISV.
>     > >>
>     > >> Andrey, will you please test?
>     > >
>     > > Looks like WnR is now being set properly, but SAS is still always 0.
>     >
>     > Are you looking at ESR_EL1?
>     >
>     > On page D13-2992 of revision F.a:
>     >
>     > # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.
>     >
>     > which means that ISS[23:14] are RES0, which includes SAS.
>
>     +more Arm and Google people
>
>     Is this known? Do we not get access size when MTE fault happens?
>
>
> It sounds like this applies to all data abort exceptions, no matter MTE or not.

Correct. For data aborts in general, the extra syndrome information in ISS[23:14] is 
only provided at EL2, in order to help hypervisors emulate simple loads/stores (that 
access device memory) by looking at ESR_EL2 without having to decode the trapped 
instruction. Did you have any particular use-case in mind for SAS being set even in 
ESR_EL1?

Kevin

--------------B662C6CCBE1B4141BC04C887
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 12/08/2020 20:06, Evgenii Stepanov wrote:<br>
    <blockquote type="cite"
cite="mid:CAFKCwrjSU89jiUbzd8Ys8nV6NDCJer=FbUnGWv8m0p0E+9MdVg@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">On Wed, Aug 12, 2020 at 11:03 AM Andrey Konovalov
        &lt;<a href="mailto:andreyknvl@google.com"
          moz-do-not-send="true">andreyknvl@google.com</a>&gt; wrote:<br>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On Wed, Aug 12, 2020 at
            7:52 PM Richard Henderson<br>
            &lt;<a href="mailto:richard.henderson@linaro.org"
              target="_blank" moz-do-not-send="true">richard.henderson@linaro.org</a>&gt;
            wrote:<br>
            &gt;<br>
            &gt; On 8/12/20 10:38 AM, Andrey Konovalov wrote:<br>
            &gt; &gt; On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson<br>
            &gt; &gt; &lt;<a href="mailto:richard.henderson@linaro.org"
              target="_blank" moz-do-not-send="true">richard.henderson@linaro.org</a>&gt;
            wrote:<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; As reported by Andrey, I was missing the
            complete ISS info for<br>
            &gt; &gt;&gt; the Data Abort raised upon a synchronous tag
            check fail.<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; The following should fix that.  All the twisty
            little rules for<br>
            &gt; &gt;&gt; the ISS.ISV bit are already handled by
            merge_syn_data_abort.<br>
            &gt; &gt;&gt; Probably the most important bit that was
            missing was ISS.WnR,<br>
            &gt; &gt;&gt; as that is independent of ISS.ISV.<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; Andrey, will you please test?<br>
            &gt; &gt;<br>
            &gt; &gt; Looks like WnR is now being set properly, but SAS
            is still always 0.<br>
            &gt;<br>
            &gt; Are you looking at ESR_EL1?<br>
            &gt;<br>
            &gt; On page D13-2992 of revision F.a:<br>
            &gt;<br>
            &gt; # ISV is 0 for all faults reported in ESR_EL1 or
            ESR_EL3.<br>
            &gt;<br>
            &gt; which means that ISS[23:14] are RES0, which includes
            SAS.<br>
            <br>
            +more Arm and Google people<br>
            <br>
            Is this known? Do we not get access size when MTE fault
            happens?<br>
          </blockquote>
          <div><br>
          </div>
          <div>It sounds like this applies to all data abort exceptions,
            no matter MTE or not.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Correct. For data aborts in general, the extra syndrome information
    in ISS[23:14] is only provided at EL2, in order to help hypervisors
    emulate simple loads/stores (that access device memory) by looking
    at ESR_EL2 without having to decode the trapped instruction. Did you
    have any particular use-case in mind for SAS being set even in
    ESR_EL1?<br>
    <br>
    Kevin<br>
  </body>
</html>

--------------B662C6CCBE1B4141BC04C887--

