Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE333206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj47IY7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE333206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWqN-0001wn-3g
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWpf-0001Mp-G6; Mon, 04 May 2020 04:52:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWpe-0005DJ-Qt; Mon, 04 May 2020 04:52:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so7513294wmb.4;
 Mon, 04 May 2020 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5YQS9n5B+I3esLmVzRuNMjbia2NgIbA9HkdB9fWIKFw=;
 b=Wj47IY7UIY0m4Ol4b48A5EA4dPJA2CfMNl2IJfV1WHbVF9e/FKBEMirvBXmmIXKWcu
 uJHrhs3J/JwYcL5EeEH2LL9K8dN3qmqOLgooknb/ODhjLywr6DEVNYIWhn1v0dwjYbaH
 DpSKX74X6QB8uk/O43RTGEszItATbvANijQ/b2i5F6zX5S3SqyPcU0eZGOCFknSNccLH
 t/Rm+sRhAXCR4QwTP51saGJXuVu1nLGpJUxMGAtPOcGeM3zXESurR+uWmb9Y6v9HaSgR
 dlx1J6ew2Bzgt8fMStWsx6YvVH5oTf60/KFlJn9tfQ6OCGRjQE/PnX/bVoSdtmQLIf/d
 4mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5YQS9n5B+I3esLmVzRuNMjbia2NgIbA9HkdB9fWIKFw=;
 b=PoKz0l+gHU8FyU34VYs6FfM77Vcmy2IwvkFv3NWqAL6Vf+FfTKt6UIJLAVsJMoM45J
 K1/WgSr3VTG+zTvgNQqUkvnKEmm3CVsR7m71hdpiZcyax2Ggwjxh9VSQfjirAQAiB4va
 sRXgAmR9GbSZv+OS6djEH/nWxch/pTqKQb4Vs+5Q8s9wYdCjLhkcaAtehv6fwG7+GWdE
 IUzcCn2DLT3FEOni7aYhSOTArz5tYiT/Dh2l6S2RWekz0eQnYfLqRGU8HTTVP1CDMLd1
 0652+ivuK1vn2weAIAoIC1Z6lbbyFyNt/uI8729zOZQ5hdn7q7161veNU9tyDOoLHq6I
 EgLw==
X-Gm-Message-State: AGi0PuY3bu6ZQ5+vki3YqD2/hOHcnNpyAFE/T5tsBKYujkg7x1HbhxY4
 +hcQEt/JusHMoxJNO8V76cI=
X-Google-Smtp-Source: APiQypL5gBwSSIZeHmc1IEnsSPsfj7bjcqgw9BIcKFNMyn4ZmCEL7M7r7bUo5oWE952l+PS/f82rcQ==
X-Received: by 2002:a05:600c:2196:: with SMTP id
 e22mr13049523wme.105.1588582328844; 
 Mon, 04 May 2020 01:52:08 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id a8sm4904814wrg.85.2020.05.04.01.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 01:52:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Cover the GDB Python scripts in the
 gdbstub section
To: Kevin Wolf <kwolf@redhat.com>
References: <20200430065720.10763-1-f4bug@amsat.org>
 <20200430065720.10763-2-f4bug@amsat.org>
 <20200430075950.GA6578@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2c96c40-f251-12c5-71b3-433ea99fbf3b@amsat.org>
Date: Mon, 4 May 2020 10:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430075950.GA6578@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 9:59 AM, Kevin Wolf wrote:
> Am 30.04.2020 um 08:57 hat Philippe Mathieu-Daudé geschrieben:
>> Keep an eye on these "same same, but different" files.
>>
>> Acked-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8cbc1fac2b..7a7f2b9c31 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2083,6 +2083,7 @@ R: Philippe Mathieu-Daudé <philmd@redhat.com>
>>   S: Maintained
>>   F: gdbstub*
>>   F: gdb-xml/
>> +F: scripts/qemugdb/
> 
> Wouldn't it make sense to add scripts/qemu-gdb.py as well?

I agree scripts/qemu-gdb.py with scripts/qemugdb/*py, but now looking at 
the files closely I don't think they belong to the gdbstub section (GDB 
protocol, with no knowledge of Python), and rather deserve a new section 
(GDB Python scripts, with no knowledge of GDB protocol).

I am discarding this patch.

Regards,

Phil.

> 
> Kevin
> 

