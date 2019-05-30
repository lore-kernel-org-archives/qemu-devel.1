Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29142C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB28525E95
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="CANYD0r3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB28525E95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57251 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWP2l-0001dt-7A
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 13:40:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1hWP1e-0000xz-2V
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1hWP1d-0001iX-5H
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:39:38 -0400
Received: from smtp41.i.mail.ru ([94.100.177.101]:54920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>)
	id 1hWP1a-0001bk-Fp; Thu, 30 May 2019 13:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail2; 
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
	bh=f+vLxXGaSvomUNkNtYRIEwIzoRsRDJ7OcHF9Nt4Vb00=; 
	b=CANYD0r3isWM178gxRhfu4gvhdDX8qujsh+1GlNkBDMGf8CUn6aKa/8ZtfPZ+HdbEtTizCKblZIw8zCwpPtOhEglv51GC9KZKelVSIEPlAK8o4Q+gsCw6+/vM3Itdb5dgVS6Qj/qmwC5k6Q5VMptEd8/bOpDr1PFiVEbnF0g2o0=;
Received: by smtp41.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
	id 1hWP1W-0005wc-5p; Thu, 30 May 2019 20:39:30 +0300
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
References: <20190527092319.15844-1-stefanha@redhat.com>
	<20190530084214.GA4890@linux.fritz.box>
	<2cbb60cd-beba-52bf-71d0-bc3cfe756a59@redhat.com>
Message-ID: <c58dd5de-9cec-a3b8-7e00-33531f1e4124@mail.ru>
Date: Thu, 30 May 2019 20:39:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2cbb60cd-beba-52bf-71d0-bc3cfe756a59@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp41.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
	smtp.mailfrom=jusual@mail.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC29414818EDE70289007F880856BAC404ABEFBDD8BB59315268E7790DE444AA98A0EB
X-7FA49CB5: 0D63561A33F958A5261F53018B01C6EA1F98A1A653212DB59E2B0D76CDF5F6D58941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249AE6B62100CB10EE23AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE72546FE575EB473F1CD04E86FAF290E2DBBC930A3941E20C675ECD9A6C639B01B78DA827A17800CE7E22FC644589531CC22622B1C6AE4F09575ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC852301B74F4230CB9127F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 42ECD68FB001EF95CFF07A00C0DCB66EFE7092D4D5102C21CE1994A6CC337A1EEF2A0D6DA0DA3300BCD5BA2C93075E1EC77752E0C033A69E882C431543FD75E20226C39053983FF03453F38A29522196
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 94.100.177.101
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: explictly clear laiocb->co
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
From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Julia Suvorova <jusual@mail.ru>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30.05.2019 17:07, Paolo Bonzini wrote:
> On 30/05/19 10:42, Kevin Wolf wrote:
>> Am 27.05.2019 um 11:23 hat Stefan Hajnoczi geschrieben:
>>> qemu_aio_get() does not zero allocated memory.  Explicitly initialize
>>> laiocb->co to prevent an uninitialized memory access in
>>> qemu_laio_process_completion().
>>>
>>> Note that this bug has never manifested itself.  I guess we're lucky!
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> That the bug never manifested itself might be because it's in an unused
>> function. How about we finally just remove the unused callback-based
>> laio_submit() from the code?
>>
>> At the time when I converted linux-aio to coroutines, someone (maybe
>> Paolo?) insisted that we keep the old interface because we might add a
>> new user sometime with possible shortcuts that bypass the whole coroutine
>> path, but it hasn't happened and I think we've moved even further in the
>> opposite direction since then.
> 
> Yes, I suppose it's time.  Spending time fixing bugs in dead code is
> always a sign that it's time. :)

Great, I'll clean it up.

Best regards, Julia Suvorova.

