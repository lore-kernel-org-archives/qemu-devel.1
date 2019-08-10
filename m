Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A45C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603C72089E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603C72089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwRXt-0006Ya-NU
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hwRXU-0005uA-Jt
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hwRXS-0004Xa-PE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:36:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1hwRXR-0004QB-Vb; Sat, 10 Aug 2019 09:36:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06184501|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.362003-0.0192363-0.61876; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l10434; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.F9is1lq_1565444133; 
Received: from 192.168.79.129(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.F9is1lq_1565444133)
 by smtp.aliyun-inc.com(10.147.43.230);
 Sat, 10 Aug 2019 21:35:55 +0800
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAL1e-=jceerbvam57mmXoKWHzepB-qUFL08gBEnSws_ohewLzw@mail.gmail.com>
 <CAEiOBXVDg-oaqWDpzFrsPjzt8jdmLt7DskG4=zXwYVUb+5=tfg@mail.gmail.com>
From: LIU ZhiWei <zhiwei_liu@c-sky.com>
Message-ID: <29508a4a-ac24-c8d2-d703-cb971c33166b@c-sky.com>
Date: Sat, 10 Aug 2019 06:35:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXVDg-oaqWDpzFrsPjzt8jdmLt7DskG4=zXwYVUb+5=tfg@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/8/19 6:48 AM, Chih-Min Chao wrote:
>
>
> On Thu, Aug 8, 2019 at 7:29 PM Aleksandar Markovic 
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>
>     On Thu, Aug 8, 2019 at 11:52 AM liuzhiwei <zhiwei_liu@c-sky.com
>     <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>     > Hi all,
>     >
>     >     My workmate  and I have been working on Vector & Dsp
>     extension, and
>     > I'd like to share develop status  with folks.
>     >
>     >     The spec references for  Vector extension is
>     riscv-v-spec-0.7.1, and
>     > riscv-p-spec-0.5 for DSP extension.
>
>
>     Hello, Liu.
>
>     I will not answer your questions directly, however I want to bring
>     to you
>     and others another perspective on this situation.
>
>     First, please provide the link to the specifications. Via Google,
>     I found
>     that "riscv-v-spec-0.7.1" is titled "Working draft of the proposed
>     RISC-V V
>     vector extension". I could not find "riscv-p-spec-0.5".
>
>     I am not sure what the QEMU policy towards "working draft
>     proposal" type of
>     specification is. Peter, can you perhaps clarify that or any other
>     related
>     issue?
>
>
> Hi Aleksandar,
>
> As for riscv-v-spec 0.7.1, it is first stable spec for target software 
> development
> though the name is working draft.  The architecture skeleton is fix 
> and most of
> work are focusing the issues related to micro-architecture 
> implementation complexity.
> Sifive has released an open source implementation on spike simulation 
> and Imperas also
> provides another implementation with its binary simulator.  I think it 
> is worth to include the extension
> in Qemu at this moment.
>
> As for riscv-p-spec-0.5, I think Andes has fully supported this 
> extension and should release more
> detailed spec in the near future (described Riscv Technical Update 
> 2019/06).
> They have implement lots of DSP kernel based on this extension and 
> also provided impressed
> performance result.  It is also worth to be reviewed (at least [RFC]) 
> if the detailed  spec is public.
>
>
> ref:
>      1. 
> https://content.riscv.org/wp-content/uploads/2019/06/17.40-Vector_RISCV-20190611-Vectors.pdf
>      2. 
> https://content.riscv.org/wp-content/uploads/2019/06/17.20-P-ext-RVW-Zurich-20190611.pdf
>      3. 
> https://content.riscv.org/wp-content/uploads/2019/06/10.05-TechCommitteeUpdate-June-2019-Copy.pdf
>
>
> chihmin
>
Hi chihmin,

Thank you for the detailed and informative response. You have a very 
good understanding of the specifications.

I will modify the code according to the latest spec(currently 
riscv-v-spec 0.7.2) from the ISA spec git repo as Alistair advised.

Yours,

Zhiwei

>
>     I would advice some caution in these cases. The major issue is
>     backward
>     compatibility, but there are other issues too. Let's say,
>     fairness. If we
>     let emulation of a component based on a "working draft proposal" be
>     integrated into QEMU, this will set a precedent, and many other
>     developer
>     would rightfully ask for their contributions based on drafts to be
>     integrated into QEMU. Our policy should be as equal as possible to all
>     contribution, large or small, riscv or alpha, cpu or device, tcg
>     or kvm -
>     in my honest opinion. QEMU upstream should not be a collecting
>     place for
>     all imaginable experimentations, certain criteria on what is
>     appropriate
>     for upstreaming exist and must continue to exist.
>
>     Yours,
>     Aleksandar
>
>
>
>
>     > The code of vector extension is
>     > ready and under testing,  the first patch will be sent about two
>     weeks
>     > later. After that we will forward working on DSP extension, and
>     send the
>     > first patch in middle  October.
>     >
>     >      Could the maintainers  tell me whether the specs referenced are
>     > appropriate? Is anyone working on these extensions? I'd like to get
>     > your status, and maybe discuss questions and work togather.
>     >
>     > Best Regards
>     >
>     > LIU Zhiwei
>     >
>     >
>     >
>     >
>
