Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEACC38A2D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872BA22202
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="NIlwj92P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872BA22202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPUHb-0002Q9-Hj
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1jPUEN-00010b-8B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1jPUEM-0003HE-7C
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:52:43 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1jPUEF-00039F-V9; Fri, 17 Apr 2020 12:52:36 -0400
Received: from [192.168.1.12] (lfbn-gre-1-344-171.w90-112.abo.wanadoo.fr
 [90.112.62.171])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 59A3896F50;
 Fri, 17 Apr 2020 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587142353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSvfu6qH9m18s7xOnXwbs4IuO5TxdBMihz7/KC5BP10=;
 b=NIlwj92PW55ZcKyc6dVIhxwBJWdVpEg82grvDRxcqKW86GGkX1/LA0Mu5LFkQvwk6sf5pD
 v1BsWE9FTfwEW2Ymv2iEzvzSfX7SEC9sBb0yrsDI5ZN77EIqd2bI7hXnC6SLhEU70ah8lx
 EFyttZPrzbH8txk2qFcWNLo1ZOcYmM0=
Subject: Re: [PATCH v9 5/9] docs/clocks: add device's clock documentation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-6-damien.hedde@greensocs.com>
 <CAFEAcA_NVJg9KS-yrYDKe0GbAC7xah6mH1SmkjLmyr-BNPF8WQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <eee8cb35-c7bc-f60c-fd10-073320a41ed7@greensocs.com>
Date: Fri, 17 Apr 2020 18:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NVJg9KS-yrYDKe0GbAC7xah6mH1SmkjLmyr-BNPF8WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587142353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSvfu6qH9m18s7xOnXwbs4IuO5TxdBMihz7/KC5BP10=;
 b=L9mrTTKkSOw76QoqXXL4S1yfFR4uCO8eQEvxqjqnRpsh4eux0YFC0vwzOTM1yB5ObTTq32
 1VRW53xgJuUNpetUc5FP4XOQQnYeZB0UgG6GvfL23kvplqPrEje7AEDEwdnmr/OsT9LXNd
 hr8ryNt87bKe9LWX0J1yAsSk4XQ+3QE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587142353; a=rsa-sha256; cv=none;
 b=F0aQDkHH0oIDy3+VeM8IsE49qZ8FrGXrxpo/SfnQ09Y5Gqy8Wf+fyetDOn8RIpeykvKynZ
 /SY9Qa2wl7WLuJht9rQBaJROMPpI2svOIdF+tKrdNWnMYBYsg8bTsC26UTt76eZ6TCPP9A
 kT7logk78+r2hi8nXbtJoiBs1KuOPDM=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/17/20 5:52 PM, Peter Maydell wrote:
> On Mon, 6 Apr 2020 at 14:53, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Add the documentation about the clock inputs and outputs in devices.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> I did an edit pass on this to address minor grammar/style
> issues and some Sphinx syntax stuff (notably, using
> "code-block:: c" renders nicer than a plain literal block).
> Diff against this patch is below; it looks bigger than
> you might expect because one of the changes was that I
> rewrapped some of the paragraphs that were close to or
> over 80 chars per line. Changes include the tweak Markus
> asked for.
> 

Thanks a lot,

I thought that the maximum column size was 80, should we use a
bit less in practice ?

I'll apply this and do a respin along with your other patch 1 catcha
bout the integer type in traces.

Damien


