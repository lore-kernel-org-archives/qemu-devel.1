Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD122190F
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVAlV8JG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD122190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMBwX-00046S-9K
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMBve-0003YG-Pd
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMBvd-0005DT-O0
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:11:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMBvZ-0005BW-0Z; Sun, 20 Oct 2019 10:11:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id g24so1319072wmh.5;
 Sun, 20 Oct 2019 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qWNLqw5/rk/U02x775a4mNFotqXGWCjFioqKX39zVy0=;
 b=nVAlV8JG2ZowljCQa3FGEmb3AMujIJqvaEM3klguOR+P2A6XBV7a5iObDrNkpn5Yk0
 jp9n2/IiJk6UAPq8swl8hiD7v3eN1S0I19bFJEDOBEtkk0r5WFLJzPPBN8/rYFr2XwIw
 M/Frrc5ttsnv+1FfxWGTAqDchjuBga0h8JVOnhJm4i9+Dlb4kDND4u9qP7/L8NXPBKUE
 jOPBlHaYCbyuXY5SIzpxZtPVrOrLqRgzJsliOQoZ0G8X1NZ6+F+aFrV7raRk1bbG6emL
 cmxqdNRjgsA2pP07GZR1HTOxmgBgLHf3bHKH7MWc/x8/6k2tTUq5pWpU33mP9b05Nr1F
 kikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qWNLqw5/rk/U02x775a4mNFotqXGWCjFioqKX39zVy0=;
 b=YdDStmVg9JGcYtm8ChgGmX440+5Tc1ZdHpxQQnizyIyOL8FvwVa9Rdv95Qg8n+vqM+
 flvUAlmPJcbc60iOhoyCVPghOv0m51Lr08SRNtf2XpzvUw8yjLiRklgKbQucCq+MsUY2
 1pt5RZ6xmRk3zNLsIDVelx8VLcC+kniewzM5zjFrtpv7dPu+/teMrQtxPgp0nldtK3k4
 vqPUz4hmP1sXX6hzB5DdcPfcjinA+YR81JDtw7p0O4h6Py32CPyHn/zITpqSgY8phrWg
 CB8W27YWREm4ZTV6SdTdmnewjq8vNhKmmCIfEoGFj1h9O7W5Zcv2PohhBha4cenBoXS0
 tAnA==
X-Gm-Message-State: APjAAAXYorYAtHDm5VoUq3gQBWghqxCFo+iSi7COhSkJIErHHSujEuXs
 zv3cO1hNWKu5gz9QvVmdZlw=
X-Google-Smtp-Source: APXvYqwVHX4OSDjrX8137XW+/zM+bF1MnSXAKYNsNgY1YCq+IjalBMXWGMG8uqrdTWEoT/8pB7TOBA==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr14780778wmd.172.1571580683633; 
 Sun, 20 Oct 2019 07:11:23 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p21sm2378937wmc.25.2019.10.20.07.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2019 07:11:22 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] tests/acceptance: Send <carriage return> on serial
 lines
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191017165239.30159-1-f4bug@amsat.org>
 <20191017165239.30159-4-f4bug@amsat.org>
 <20191020100906.GL1960@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d21da354-0c14-5b55-0e87-1a63d246e4ca@amsat.org>
Date: Sun, 20 Oct 2019 16:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020100906.GL1960@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paolo/Samuel/Marc-André

On 10/20/19 12:09 PM, David Gibson wrote:
> On Thu, Oct 17, 2019 at 06:52:33PM +0200, Philippe Mathieu-Daudé wrote:
>> Some firmwares don't parse the <Newline> control character and
>> expect a <carriage return>.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   tests/acceptance/boot_linux_console.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 9ff2213874..bf9861296a 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -30,7 +30,7 @@ class BootLinuxConsole(Test):
>>       KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>   
>>       def exec_command_and_wait_for_pattern(self, command, success_message):
>> -        command += '\n'
>> +        command += '\r\n'
> 
> I'm actually wondering if '\r' alone is really what we should be using
> here.  Isn't that usually the character that actually pressing the
> Enter key generates (on an old school tty)?  IIRC it's the thing on
> the other side of the console that echoes back a \r and \n in order to
> reposition the cursor on the next line.

Our current tests mostly target Linux/*BSD.
When I started testing U-boot/VxWorks images, I noticed the tests were 
stuck, why testing manually it was working, then this patch solved my issue.
I haven't checked the source but think the readline() implementation of 
these do strchr('\r') instead of strchr('\n') to match a newline?

So input sending Cartridge Return makes more sense here...

I tested with:

-- >8 --
      def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\n'
+        command += '\r'
          self.vm.console_socket.sendall(command.encode())
          self.wait_for_console_pattern(success_message)
---

And everything works fine, so we don't need to send the New Line char :)

Thanks for helping me figure this out!
I'll wait if there are other comments then respin.

Regards,

Phil.

>>           self.vm.console_socket.sendall(command.encode())
>>           wait_for_console_pattern(self, success_message)
>>   
> 

