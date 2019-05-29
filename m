Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C51DC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458CD20644
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458CD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxIl-0006Ea-HH
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:03:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVxHn-0005tF-N7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVxHm-00033t-JZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:02:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVxHm-00033J-EX
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:02:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so1580269wrt.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 05:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uzkVejDaUlyLXJCSUgyhH2Aj7ZnjAr3WHnrSXcrMiBg=;
	b=tlGiYuettAfP0wldtH5CWHqY/Ueq5+b92t4XY2qxHx1XwiJzul/UyesLW5L7ioiHtH
	EDojqId11Yzohg1qtOo5n61Nl88t/vqxDdkcgcVWwYgpnIFzcjatak+6n5Aov59SkvfR
	eHrf0glpxiwivstxxvS47/6vcFOOWx2oHObU2GTRw8gWtXgr1mz3wiNWKNqAZoXpwHVl
	rmdUvjamPY8GjCTr6v9cZlO6/uGmOvyVB7AudNB+JXIgDxvZOdomyI5d2eh/mmrk53p5
	rN1rhg3akCeQnYv8FEz2RT6pw5ecrr2ot0ByYL6KAws1kOxfhEZuoWxtPAFSX7zCLoJm
	EOPg==
X-Gm-Message-State: APjAAAWybrCU1fURSMOYWVOG4kPqIWoLE5282dUL5TNx67z91JL3CJf1
	VugaPRZoYul9DqwbZXc6vyIhmA==
X-Google-Smtp-Source: APXvYqwuV2Id8ge3o48EVHJKGWXnsEpCHzEpydmUhywUbJzWRGD/WglW6yV29HQ3tyzWV4lDoUQ5EA==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr25962841wru.273.1559131345461;
	Wed, 29 May 2019 05:02:25 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	l190sm7661898wml.25.2019.05.29.05.02.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 05:02:24 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-13-kraxel@redhat.com>
	<24daf870-9c97-d1e2-47b0-4713aaad38f2@redhat.com>
	<699fa2ab-257d-66c8-6810-05cfd5a59280@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ad875c1-1cb3-26aa-0965-b884244b41b1@redhat.com>
Date: Wed, 29 May 2019 14:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <699fa2ab-257d-66c8-6810-05cfd5a59280@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 12/14] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André (chardev)

On 5/29/19 1:52 PM, Philippe Mathieu-Daudé wrote:
> On 5/29/19 1:32 PM, Philippe Mathieu-Daudé wrote:
>> On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
>>> Instead of fetching the prebuilt image from patchew download the install
>>> iso and prepare the image locally.  Install to disk, using the serial
>>> console.  Create qemu user, configure ssh login.  Install packages
>>> needed for qemu builds.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>>> Tested-by: Thomas Huth <thuth@redhat.com>
> [...]
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
> 
> And now:
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I tested this using Fedora 29:

$ qemu-system-x86_64 -version
QEMU emulator version 3.0.1 (qemu-3.0.1-3.fc29)

Now testing with:

$ qemu-system-x86_64 -version
QEMU emulator version 4.0.50 (v4.0.0-798-g8dc7fd56dd)

# Configured with: '../configure' '--target-list=x86_64-softmmu'
'--disable-tools'

I get:

~/source/qemu$ make vm-build-netbsd V=1
[...]
con recv: >o: Add a user
con recv: x: Finished configuring
con recv: >a: Configure network
configure  o: Add a user
con recv: Which network device would you like to use?
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:
con recv:  qqqqqqqqqqqqqqqqqqqqqqqqqk Available interfaces    >a: vioif0
con send: a<enter>
con recv:  x: Exitqqqqqqqqqqqqqqqqqqqqqqqqqj
con recv: To be able to use the network, we need answers to the
following:Network media type
con send: <enter>
con recv: : qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk Perform autoconfiguration?
   >a: Yes b: Noqqqqqqqqqqqqqqqqq
console: *** read timeout ***
console: waiting for: 'a: Yes'
console: line buffer:

con recv: qqqqqqqqqqqqqqj

Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/phil/source/qemu/tests/vm/basevm.py", line 350, in main
    return vm.build_image(args.image)
  File "tests/vm/netbsd", line 147, in build_image
    self.console_wait_send("a: Yes",                   "a\n")
  File "/home/phil/source/qemu/tests/vm/basevm.py", line 250, in
console_wait_send
    self.console_wait(wait)
  File "/home/phil/source/qemu/tests/vm/basevm.py", line 212, in
console_wait
    chars = vm.console_socket.recv(1024)
timeout: timed out
DEBUG:QMP:>>> {'execute': 'quit'}
DEBUG:QMP:<<< {u'return': {}}
tests/vm/Makefile.include:43: recipe for target
'/home/phil/.cache/qemu-vm/images/netbsd.img' failed
make: *** [/home/phil/.cache/qemu-vm/images/netbsd.img] Error 2

Did something related to the serial console/chardev change?

Anyway your patch works with qemu-stable, so the series is good to go IMO.

Regards,

Phil.

