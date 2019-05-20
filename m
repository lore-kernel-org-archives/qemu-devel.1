Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C05C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D5020856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D5020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgQQ-0007Gm-NO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:25:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgPW-0006sW-7D
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgPV-0007m1-9M
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:24:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSgPV-0007lO-3X
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:24:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so7765290wrt.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hzOrpazV6gdgKD+C58Z37W5Xkj5dzNf7NY4r1mWP11g=;
	b=CAsG7JyA738RIRcdUpPBmx9SAIZ55+6gZwc2nsfHF8QcmU8zcaF0o8WBTiYqq5EPwU
	0z5nRtkL1yFgtHMN74AFiMV6EUYQ5MGgWJjGjIMx64/5BWNw1cWrmuoZ/bx4mOvqFYSf
	f6iSqsUPmoolwvfx9neavb6zmjhKcM3mwEWZWOafGcRGvyA67AciRYui0l0Stny4hB3W
	slZhsVvSie7sZzAWgjH01u+OCeDm8bLKCTwz3ecG3yqBmH05kqF/gOCVrZ4mumXhkbgA
	c5+zZFbas1EoZi/4ueu15svjsm85yOKXFlLDLHiJK72P0B69x0AL1mDj3GlFCz666r+H
	v7LQ==
X-Gm-Message-State: APjAAAULdeAhr6elDwLnxna1W7LKl+IK4txs4d5Q5cwcc2kkg7v6cSN2
	FxJyi5i2de7+ouN7qz4wafNbgQ==
X-Google-Smtp-Source: APXvYqzRhrkLlhJkbfvCKXHlHbDFIEQal8U8v4g2gTrHKYYKPoACuGQEDCCzajvbllfhBcJN+eWMVg==
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr8721035wrn.88.1558351491807; 
	Mon, 20 May 2019 04:24:51 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	a62sm2487549wmh.11.2019.05.20.04.24.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 04:24:51 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-11-kraxel@redhat.com>
	<40966599-9a55-8078-bc49-e2597ce5d498@redhat.com>
	<20190520052615.ty2bpmxdoajjqvk6@sirius.home.kraxel.org>
	<84415abd-3066-90db-e10d-51f756aa6767@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <94272c6c-c12a-5411-4981-332bdb37631b@redhat.com>
Date: Mon, 20 May 2019 13:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <84415abd-3066-90db-e10d-51f756aa6767@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 10/13] tests/vm: freebsd autoinstall,
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
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 9:14 AM, Thomas Huth wrote:
> On 20/05/2019 07.26, Gerd Hoffmann wrote:
>> On Sun, May 19, 2019 at 12:55:09AM +0200, Philippe Mathieu-Daudé wrote:
>>> Hi Gerd,
>>>
>>> On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
>>>> Instead of fetching the prebuilt image from patchew download the install
>>>> iso and prepare the image locally.  Install to disk, using the serial
>>>> console.  Create qemu user, configure ssh login.  Install packages
>>>> needed for qemu builds.
>>>
>>> I'm impressed how charmly this works :)
>>>
>>> 3 comments so far.
>>>
>>> 1/ We could record (in tests/vm/freebsd header?) roughly how many local
>>> storage will be used (or display in 'make vm-help'?). FYI this image
>>> takes ~3.1GiB.
>>
>> vm-help would be more useful I think.
>>
>>> 2/ "Autoboot in 9 seconds, hit [Enter] to boot or any other key to stop"
>>
>> Probably tweakable via loader.conf, I'll check.
>>
>>> 3/ I am a bit annoyed it overwrote my previous
>>> ~/.cache/qemu-vm/images/freebsd.img VM. Not sure what's the best hash to
>>> use, maybe "git log -n 1 --pretty=format:%H -- tests/vm/freebsd"?
>>> (Similarly for other images).
>>
>> Then use ~/.cache/qemu-vm/images/freebsd-${hash}.img ?
>>
>> Which will fill ~/.cache/qemu-vm/images with stale images over time,
>> which isn't great either ...
>>
>> Or do you have something else in mind?

Maybe we can simply use a ${VM_IMG_VERSION} and manually increase it
when there are significant changes.

We could add a "make vm-clean-cache-older-than-%" parsing the
"20days/3months/2y" formats?

> I'd vote to keep the current approach to overwrite "freebsd.img". It's a
> "cache" directory - if you want to have something persisten, Philippe, I
> think you should simply copy your image to a different location instead.

My concern came when thinking about bisecting:

$ git log --oneline \
  $(git log --pretty=format:%H \
    --diff-filter=A -- tests/vm/freebsd)..origin/master | wc -l
13016

But then I only used "make check-vm" while bisecting twice, so I can
stop worrying about testing old VMs.

Regards,

Phil.

